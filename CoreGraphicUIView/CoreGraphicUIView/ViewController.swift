//
//  ViewController.swift
//  CoreGraphicUIView
//
//  Created by Jason Qiu on 2024/11/7.
//

import UIKit

class ViewController: UIViewController {
    
    let myView = MyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        myView.translatesAutoresizingMaskIntoConstraints = false
        myView.backgroundColor = .cyan
        let viewSize = UIScreen.main.bounds.width * 0.95

        view.addSubview(myView)
        
        NSLayoutConstraint.activate([
            myView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            myView.widthAnchor.constraint(equalToConstant: viewSize),
            myView.heightAnchor.constraint(equalToConstant: viewSize),
        ])
        
    }
    
}

class MyView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {return}
        let viewSize = UIScreen.main.bounds.width * 0.95

        let rectangle1 = CGRect(x: 0, y: 0, width: viewSize * 0.5, height: viewSize * 0.45).insetBy(dx: 10, dy: 10)
        context.setFillColor(UIColor.systemRed.cgColor)
        context.setStrokeColor(UIColor.systemGreen.cgColor)
        context.setLineWidth(20)
        context.addRect(rectangle1)
        context.drawPath(using: .fillStroke)
        context.fill(rectangle1)
        
        let circle1 = CGRect(x: viewSize * 0.64, y: viewSize * 0.64, width: viewSize * 0.32, height: viewSize * 0.32)
        context.setFillColor(UIColor.systemBlue.cgColor)
        context.setStrokeColor(UIColor.systemYellow.cgColor)
        context.setLineWidth(10)
        context.addEllipse(in: circle1)
        context.drawPath(using: .fillStroke)
    }
}

