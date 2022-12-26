//
//  ColorRandomizer.swift
//  CompositionalLayout
//
//  Created by Gabriel Augusto Marson on 19/12/22.
//

import Foundation
import UIKit

extension UIColor {
    static func random() -> UIColor {
        UIColor(
            red: .random(),
            green: .random(),
            blue: .random(),
            alpha: 1.0
        )
    }
}

fileprivate extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
