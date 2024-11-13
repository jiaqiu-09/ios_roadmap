//
//  ViewController.swift
//  AVFoundationDemo
//
//  Created by Jason Qiu on 2024/11/12.
//

import UIKit
import AVFoundation
import Photos
import AVKit


class ViewController: UIViewController {
    // capture session
    var session:AVCaptureSession?
    // photo output
    let output = AVCapturePhotoOutput()
    // video preview
    let previewLayer = AVCaptureVideoPreviewLayer()
    // video output
    let movieOutput = AVCaptureMovieFileOutput()
    // shutter button
    private let shutterButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.layer.cornerRadius = 50
        button.layer.borderWidth = 10
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    private var recordedVideoURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(shutterButton)
        shutterButton.center = CGPoint(x: view.bounds.size.width / 2, y: view.bounds.size.height - 100)
        
        checkCameraPermission()
        
        shutterButton.addTarget(self, action: #selector(didTapShutter), for: .touchUpInside)
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPressShutter))
        shutterButton.addGestureRecognizer(longPressGesture)
    }
    
    func checkCameraPermission() {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch cameraAuthorizationStatus {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                if (!granted) {
                    return
                }
                self?.checkAudioPermission { granted in
                    DispatchQueue.main.async {
                        if granted {
                            self?.setupCamera()
                        } else {
                            print("Audio permission denied.")
                        }
                    }
                }
            }
        case .restricted:
            break;
        case .denied:
            break;
        case .authorized:
            checkAudioPermission { [weak self] granted in
                DispatchQueue.main.async {
                    if granted {
                        self?.setupCamera()
                    } else {
                        print("Audio permission denied.")
                    }
                }
            }
        @unknown default:
            break
        }
    }
    
    func checkAudioPermission(completion: @escaping (Bool) -> Void) {
        let audioStatus = AVCaptureDevice.authorizationStatus(for: .audio)
        switch audioStatus {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .audio) { granted in
                completion(granted)
            }
        case .authorized:
            completion(true)
        default:
            completion(false)
        }
    }
    
    func setupCamera() {
        // create a new capture session
        session = AVCaptureSession()
        session?.sessionPreset = .high
        
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
            
            if session?.canAddOutput(movieOutput) == true {
                session?.addOutput(movieOutput)
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
        
        guard let audioDevice = AVCaptureDevice.default(for: .audio) else {
            print("No audio device found")
            return
        }
        
        do {
            let audioInput = try AVCaptureDeviceInput(device: audioDevice)
            if session?.canAddInput(audioInput) == true {
                session?.addInput(audioInput)
            }
        } catch {
            print("Error setting up audio input: \(error)")
            return
        }
    }
    
    @objc private func didTapShutter() {
        let settings = AVCapturePhotoSettings()
        output.capturePhoto(with: settings, delegate: self)
    }
    
    @objc private func didLongPressShutter(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            startVideoRecording()
        } else if gesture.state == .ended {
            stopVideoRecording()
        }
    }
    
    private func startVideoRecording() {
        guard let session = session, session.isRunning else { return }
        let newVideoURL = getNewVideoFileURL()
        movieOutput.startRecording(to: newVideoURL, recordingDelegate: self)
    }
    
    func getNewVideoFileURL() -> URL {
        let tempDir = FileManager.default.temporaryDirectory
        let fileName = UUID().uuidString + ".mov"
        return tempDir.appendingPathComponent(fileName)
    }
    
    private func stopVideoRecording() {
        if movieOutput.isRecording {
            movieOutput.stopRecording()
        }
    }
    
    private func previewVideo(url: URL) {
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        // Present the player view controller
        present(playerViewController, animated: true) {
            player.play()
        }
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

extension ViewController: AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if let error = error {
            print("Error saving video: \(error.localizedDescription)")
            return
        }
        
        // Save the video to the photo library
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: outputFileURL)
        }) { [weak self] saved, error in
            if saved {
                // NEW CODE: Show video preview
                DispatchQueue.main.async {
                    self?.previewVideo(url: outputFileURL)
                }
                print("Video saved to Photo Library")
            } else if let error = error {
                print("Failed to save video: \(error.localizedDescription)")
            }
        }
    }
}

