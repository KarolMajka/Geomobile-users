//
//  UIColor+AppearanceMode.swift
//  Geomobile-users
//
//  Created by Karol Majka on 23/11/2023.
//

import UIKit

extension UIColor {
    convenience init(light: UIColor, dark: UIColor) {
        self.init { trait in
            switch trait.userInterfaceStyle {
            case .unspecified, .light:
                return light
            case .dark:
                return dark
            @unknown default:
                return light
            }
        }
    }
}
