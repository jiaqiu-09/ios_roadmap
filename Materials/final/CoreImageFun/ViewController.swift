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


class ViewController: UIViewController {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var slider: UISlider!

  let context = CIContext(options: nil)
  let filter = CIFilter(name: "CISepiaTone") ?? CIFilter()
  var orientation = UIImage.Orientation.up

  override func viewDidLoad() {
    super.viewDidLoad()

    guard let uiImage = UIImage(named: "image") else { return }
    let ciImage = CIImage(image: uiImage)
    filter.setValue(ciImage, forKey: kCIInputImageKey)

    applyOldPhotoFilter(intensity: 0.5)
  }

  @IBAction func sliderValueChanged(_ slider: UISlider) {
    applyOldPhotoFilter(intensity: slider.value)
  }

  @IBAction func loadPhoto() {
    let picker = UIImagePickerController()
    picker.delegate = self
    present(picker, animated: true)
  }
}

extension ViewController {
  func applySepiaFilter(intensity: Float) {
    filter.setValue(intensity, forKey: kCIInputIntensityKey)

    guard let outputImage = filter.outputImage else { return }

    guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
    imageView.image = UIImage(cgImage: cgImage, scale: 1, orientation: orientation)
  }

  func applyOldPhotoFilter(intensity: Float) {
    filter.setValue(intensity, forKey: kCIInputIntensityKey)

    let random = CIFilter(name: "CIRandomGenerator")

    let lighten = CIFilter(name: "CIColorControls")
    lighten?.setValue(random?.outputImage, forKey: kCIInputImageKey)
    lighten?.setValue(1 - intensity, forKey: kCIInputBrightnessKey)
    lighten?.setValue(0, forKey: kCIInputSaturationKey)

    guard let ciImage = filter.value(forKey: kCIInputImageKey) as? CIImage else { return }
    let croppedImage = lighten?.outputImage?.cropped(to: ciImage.extent)

    let composite = CIFilter(name: "CIHardLightBlendMode")
    composite?.setValue(filter.outputImage, forKey: kCIInputImageKey)
    composite?.setValue(croppedImage, forKey: kCIInputBackgroundImageKey)

    let vignette = CIFilter(name: "CIVignette")
    vignette?.setValue(composite?.outputImage, forKey: kCIInputImageKey)
    vignette?.setValue(intensity * 2, forKey: kCIInputIntensityKey)
    vignette?.setValue(intensity * 30, forKey: kCIInputRadiusKey)

    guard let outputImage = vignette?.outputImage else { return }
    guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
    imageView.image = UIImage(cgImage: cgImage, scale: 1, orientation: orientation)
  }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(
    _ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
  ) {
    guard let selectedImage = info[.originalImage] as? UIImage else { return }
    let ciImage = CIImage(image: selectedImage)
    filter.setValue(ciImage, forKey: kCIInputImageKey)
    orientation = selectedImage.imageOrientation
    applyOldPhotoFilter(intensity: slider.value)
    dismiss(animated: true)
  }
}
