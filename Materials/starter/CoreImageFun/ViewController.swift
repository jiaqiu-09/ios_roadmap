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

  override func viewDidLoad() {
    super.viewDidLoad()
    
    applySepiaFilter(intensity: 0.5)
  }

  @IBAction func sliderValueChanged(_ slider: UISlider) {}
  @IBAction func loadPhoto() {}
  
  func applySepiaFilter(intensity: Float) {
    // 1
    guard let uiImage = UIImage(named: "image") else { return }
    let ciImage = CIImage(image: uiImage)
    
    // 2
    guard let filter = CIFilter(name: "CISepiaTone") else { return }
    
    // 3
    filter.setValue(ciImage, forKey: kCIInputImageKey)
    filter.setValue(intensity, forKey: kCIInputIntensityKey)
    
    // 4
    guard let outputImage = filter.outputImage else { return }
    
    // 5
    let newImage = UIImage(ciImage: outputImage)
    imageView.image = newImage
  }
}
