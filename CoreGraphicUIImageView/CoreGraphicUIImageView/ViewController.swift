//
//  ViewController.swift
//  CoreGraphicUIImageView
//
//  Created by Jason Qiu on 2024/11/8.
//

import UIKit

class ViewController: UIViewController {

    let imageView: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        drawCircle()
    }

    
    func drawCircle() {
        let viewSize = UIScreen.main.bounds.size.width * 0.9
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: viewSize, height: viewSize))
        
        let img = renderer.image { ctx in
            let circle = CGRect(x: 0, y: 0, width: viewSize, height: viewSize).insetBy(dx: 10, dy: 10)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.orange.cgColor)
            ctx.cgContext.setLineWidth(20)
            
            ctx.cgContext.addEllipse(in: circle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = img
    }

}

