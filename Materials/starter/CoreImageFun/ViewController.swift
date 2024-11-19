/// Copyright (c) 2022 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
import Photos
import PhotosUI

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var slider: UISlider!
  let context = CIContext(options: nil)
  let filter = CIFilter(name: "CISepiaTone")!
  var orientation = UIImage.Orientation.up

  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let uiImage = UIImage(named: "image") else { return }
    let ciImage = CIImage(image: uiImage)
    filter.setValue(ciImage, forKey: kCIInputImageKey)
    applyOldPhotoFilter(intensity: 0.5)
  }

  @IBAction func sliderValueChanged(_ slider: UISlider) {
//    applySepiaFilter(intensity: slider.value)
    applyOldPhotoFilter(intensity: slider.value)
  }
  @IBAction func loadPhoto() {
    requestPhotoLibraryAccess {
      self.openImagePicker()
    }
  }
  
  func requestPhotoLibraryAccess(completion: @escaping () -> Void) {
      let status = PHPhotoLibrary.authorizationStatus()
      switch status {
      case .notDetermined:
          PHPhotoLibrary.requestAuthorization { newStatus in
              DispatchQueue.main.async {
                  if newStatus == .authorized || newStatus == .limited {
                      completion()
                  } else {
                      self.showAccessDeniedAlert()
                  }
              }
          }
      case .authorized, .limited:
          // Access already granted
          completion()
      default:
          // Access denied or restricted
          showAccessDeniedAlert()
      }
  }
  
  func showAccessDeniedAlert() {
      let alert = UIAlertController(
          title: "Photo Library Access Denied",
          message: "Please enable access in Settings to use this feature.",
          preferredStyle: .alert
      )
      alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
      alert.addAction(UIAlertAction(title: "Open Settings", style: .default) { _ in
          if let url = URL(string: UIApplication.openSettingsURLString) {
              UIApplication.shared.open(url)
          }
      })
      present(alert, animated: true)
  }
  
  func openImagePicker() {
      let picker = UIImagePickerController()
      picker.delegate = self
      present(picker, animated: true)
  }
  
  func applySepiaFilter(intensity: Float) {
    
    filter.setValue(intensity, forKey: kCIInputIntensityKey)
    
    guard let outputImage = filter.outputImage else { return }
    
    guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
    imageView.image = UIImage(cgImage: cgImage, scale: 1, orientation: orientation)
  }
  
  func applyOldPhotoFilter(intensity: Float) {
    // 1
    filter.setValue(intensity, forKey: kCIInputIntensityKey)

    // 2
    let random = CIFilter(name: "CIRandomGenerator")

    // 3
    let lighten = CIFilter(name: "CIColorControls")
    lighten?.setValue(random?.outputImage, forKey: kCIInputImageKey)
    lighten?.setValue(1 - intensity, forKey: kCIInputBrightnessKey)
    lighten?.setValue(0, forKey: kCIInputSaturationKey)

    // 4
    guard let ciImage = filter.value(forKey: kCIInputImageKey) as? CIImage else { return }
    let croppedImage = lighten?.outputImage?.cropped(to: ciImage.extent)

    // 5
    let composite = CIFilter(name: "CIHardLightBlendMode")
    composite?.setValue(filter.outputImage, forKey: kCIInputImageKey)
    composite?.setValue(croppedImage, forKey: kCIInputBackgroundImageKey)

    // 6
    let vignette = CIFilter(name: "CIVignette")
    vignette?.setValue(composite?.outputImage, forKey: kCIInputImageKey)
    vignette?.setValue(intensity * 2, forKey: kCIInputIntensityKey)
    vignette?.setValue(intensity * 30, forKey: kCIInputRadiusKey)

    // 7
    guard let outputImage = vignette?.outputImage else { return }
    guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
    imageView.image = UIImage(cgImage: cgImage, scale: 1, orientation: orientation)
  }

  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    // 1
    guard let selectedImage = info[.originalImage] as? UIImage else { return }
    orientation = selectedImage.imageOrientation
    
    // 2
    let ciImage = CIImage(image: selectedImage)
    filter.setValue(ciImage, forKey: kCIInputImageKey)
    
    // 3
    applySepiaFilter(intensity: slider.value)
    
    // 4
    dismiss(animated: true)
  }
}
