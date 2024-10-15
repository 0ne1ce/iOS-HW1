//
//  ViewController.swift
//  avchernyiPW1
//
//  Created by Алексей on 14.10.2024.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet var views: [UIView]!
    
    //MARK: - Constants
    private enum Constants {
        static let animationTime: Double = 1.8
        static let radiusUpperBound: CGFloat = 26
        static let randomHexSymbols = "0123456789ABCDEF"
        static let hexSize = 6
    }

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        button.layer.cornerRadius = 5
    }
    
    //MARK: - Actions
    @IBAction func buttonWasPressed(_ sender: Any) {
        self.button.isEnabled = false
        UIView.animate(
            withDuration: Constants.animationTime,
            animations: { [self] in
            changeViewColors()
            changeViewRadius()
            },
            completion: {
            [weak self] _ in
                self?.button.isEnabled = true
            }
        )
    }
    
    //MARK: - Functions
    func getUniqueColors() -> Array<UIColor> {
        var colors = Array<UIColor>()
        while colors.count < views.count {
            let uniqueHex: String = uniqueHex()
            
            let newColor = UIColor().hexToRGB(hex: uniqueHex)
            if (!colors.contains(newColor)) {
                colors.append(newColor)
            }
        }
        
        return colors
    }
    
    func changeViewColors() {
        let colors = getUniqueColors()
        for i in 0..<views.count {
            views[i].backgroundColor = colors[i]
        }
    }
    
    func changeViewRadius() {
        for view in views {
            view.layer.cornerRadius = .random(in: 0...Constants.radiusUpperBound)
        }
    }
    
    func uniqueHex() -> String {
        return String((0...Constants.hexSize).map{_ in Constants.randomHexSymbols.randomElement()! })
    }
}

//MARK: - UIColor
extension UIColor {
    func hexToRGB(hex: String) -> UIColor {
        let formattedHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var rgb: UInt64 = 0
        Scanner (string: formattedHex).scanHexInt64(&rgb)
        return UIColor(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: 1
        )
    }
}
