//
//  NumberSection.swift
//  CompositionalLayout
//
//  Created by Gabriel Augusto Marson on 26/12/22.
//

import Foundation

enum NumberSection: Int, Hashable {
    
    case list = 0
    case grid = 1
    case column = 2
    
    
    var stringDescription: String {
        switch self {
        case .list:
            return "List"
        case .grid:
            return "Grid"
        case .column:
            return "Column"
        }
    }
}
