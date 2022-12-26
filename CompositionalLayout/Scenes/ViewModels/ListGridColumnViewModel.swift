//
//  ListGridColumnViewModel.swift
//  CompositionalLayout
//
//  Created by Gabriel Augusto Marson on 26/12/22.
//

import Foundation

struct ListGridColumnViewModel: BaseViewModel {
    
    var dataDictionary: [NumberSection: [NumberModel]]
    
    init(
        list: [Int],
        grid: [Int],
        column: [Int]
    ) {
        dataDictionary = [
            .list: list.map { NumberModel(number: $0) },
            .grid: grid.map { NumberModel(number: $0) },
            .column: column.map { NumberModel(number: $0) }
        ]
    }
    
}
