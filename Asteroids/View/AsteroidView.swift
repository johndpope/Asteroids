//
//  AsteroidView.swift
//  Asteroids
//
//  Created by bu on 26/06/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import UIKit
import Foundation

@IBDesignable class AsteroidView: UIView {
    
    // Смещение тени
    @IBInspectable var shadowOffset: CGSize {
        set { layer.shadowOffset = newValue  }
        get { return layer.shadowOffset }
    }
    // Прозрачность тени
    @IBInspectable var shadowOpacity: Float {
        set { layer.shadowOpacity = newValue }
        get { return layer.shadowOpacity }
    }
    // Радиус блура тени
    @IBInspectable var shadowRadius: CGFloat {
        set {  layer.shadowRadius = newValue }
        get { return layer.shadowRadius }
    }
    // Цвет тени
    @IBInspectable var shadowColor: UIColor? {
        set { layer.shadowColor = newValue?.cgColor }
        get { return UIColor(cgColor: layer.shadowColor!) }
    }
    // Отсекание по границе
    @IBInspectable var _clipsToBounds: Bool {
        set { clipsToBounds = newValue }
        get { return clipsToBounds }
    }
}

extension CGColor {
    private var UIColor: UIKit.UIColor {
        return UIKit.UIColor(cgColor: self)
    }
}
