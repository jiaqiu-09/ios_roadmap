//
//  ViewController.swift
//  AVFoundationDemo
//
//  Created by Jason Qiu on 2024/11/12.
//

import UIKit
import AVFoundation
import Photos


class ViewController: UIViewController {
    // capture session
    var session:AVCaptureSession?
    // photo output
    let output = AVCapturePhotoOutput()
    // video preview
    let previewLayer = AVCaptureVideoPreviewLayer()
    // shutter button
    private let shutterButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.layer.cornerRadius = 50
        button.layer.borderWidth = 10
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(shutterButton)
        shutterButton.center = CGPoint(x: view.bounds.size.width / 2, y: view.bounds.size.height - 100)
        
        checkCameraPermission()
        
        shutterButton.addTarget(self, action: #selector(didTapShutter), for: .touchUpInside)
    }

    func checkCameraPermission() {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch cameraAuthorizationStatus {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                if (!granted) {
                    return
                }
                DispatchQueue.main.async {
                    self?.setupCamera()
                }
            }
        case .restricted:
            break;
        case .denied:
            break;
        case .authorized:
            setupCamera()
        @unknown default:
            break
        }
    }
    
    func setupCamera() {
        // create a new capture session
        session = AVCaptureSession()
        session?.sessionPreset = .photo
        
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else {
            print("No video device found")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: device)
            
            if session?.canAddInput(input) == true {
                session?.addInput(input)
            }
            
            if session?.canAddOutput(output) == true {
                session?.addOutput(output)
            }
            
            previewLayer.session = session
            previewLayer.videoGravity = .resizeAspectFill
            previewLayer.frame = view.bounds
            
            view.layer.insertSublayer(previewLayer, at: 0)
            
            DispatchQueue.global(qos: .userInitiated).async {
                self.session?.startRunning()
            }
        } catch {
            print("Error setting up camera input: \(error)")
        }
    }
    
    @objc private func didTapShutter() {
        let settings = AVCapturePhotoSettings()
        output.capturePhoto(with: settings, delegate: self)
    }
}

extension ViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation(), error == nil else {
            print("Failed to capture photo: \(String(describing: error))")
            return
        }
        self.session?.stopRunning()
        let image = UIImage(data: data)
        // Process or save the image as needed
        showCapturedImage(image)
        // Save the image to the system album
        saveToPhotoAlbum(image)
    }
    
    func showCapturedImage(_ image: UIImage?) {
        guard let image = image else { return }
        
        // Create a full-screen UIImageView
        let imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        imageView.backgroundColor = UIColor.black.withAlphaComponent(0.8) // Optional: dark background
        
        // Add a tap gesture recognizer to dismiss the image view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissCapturedImage(_:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
        
        // Add the image view to the top layer of the screen
        view.addSubview(imageView)
    }
    
    // Dismisses the image view when tapped
    @objc func dismissCapturedImage(_ sender: UITapGestureRecognizer) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.session?.startRunning()
        }
        sender.view?.removeFromSuperview()
    }
    
    func saveToPhotoAlbum(_ image: UIImage?) {
        guard let image = image else { return }
        
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .notDetermined:
                print("Permission not determined.")
            case .restricted, .denied:
                print("Permission denied or restricted for photo album access.")
            case .authorized, .limited:
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
            @unknown default:
                return
            }
        }
    }
    
    // Completion handler for saving the image to the photo album
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Failed to save photo to album: \(error.localizedDescription)")
        } else {
            print("Photo successfully saved to album.")
        }
    }
}

