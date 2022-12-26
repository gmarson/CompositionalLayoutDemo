//
//  SingleSectionViewModel.swift
//  CompositionalLayout
//
//  Created by Gabriel Augusto Marson on 26/12/22.
//

import Foundation

struct SingleSectionViewModel: BaseViewModel {
    
    var dataDictionary: [NumberSection: [NumberModel]]
    
    init(_ sectionType: NumberSection, numberArray: [Int]) {
        let numberArray: [NumberModel] = numberArray.map { NumberModel(number: $0) }
        dataDictionary = [
            sectionType : numberArray
        ]
    }
    
}
