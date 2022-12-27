//
//  ListGridColumnViewModel.swift
//  CompositionalLayout
//
//  Created by Gabriel Augusto Marson on 26/12/22.
//

import Foundation
import Combine

final class ListGridColumnViewModel: BaseViewModel {
    
    private(set) var dataDictionary: [NumberSection: [NumberModel]] {
        didSet {
            updateSnapshot()
        }
    }
    
    @Published
    var collectionSnapshot: NumberSnapshot = NumberSnapshot()
    
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
        
        updateSnapshot()
    }
    
    func updateSnapshot() {
        
        var snapshot = NumberSnapshot()
        snapshot.appendSections([.list, .grid, .column])
        
        for (key, value) in dataDictionary {
            snapshot.appendItems(value, toSection: key)
        }
        
        self.collectionSnapshot = snapshot
        
    }
    
    func plusOneEven() {
        
        var newDataDictionary: [NumberSection: [NumberModel]] = [:]
        
        for (key, array) in dataDictionary {
            newDataDictionary[key] = []
            for i in 0 ..< array.count {
                if array[i].number % 2 == 0 {
                    newDataDictionary[key]?.append(NumberModel(number: array[i].number + 1000))
                } else {
                    newDataDictionary[key]?.append(array[i])
                }
            }
        }
        
        self.dataDictionary = newDataDictionary
    }
    
    func plusOneOdd() {
        
        var newDataDictionary: [NumberSection: [NumberModel]] = [:]
        
        for (key, array) in dataDictionary {
            newDataDictionary[key] = []
            for i in 0 ..< array.count {
                if array[i].number % 2 != 0 {
                    newDataDictionary[key]?.append(NumberModel(number: array[i].number + 1000))
                } else {
                    newDataDictionary[key]?.append(array[i])
                }
            }
        }
        
        self.dataDictionary = newDataDictionary
        
    }
    
    func minusOneEven() {
        
        var newDataDictionary: [NumberSection: [NumberModel]] = [:]
        
        for (key, array) in dataDictionary {
            newDataDictionary[key] = []
            for i in 0 ..< array.count {
                if array[i].number % 2 == 0 {
                    newDataDictionary[key]?.append(NumberModel(number: array[i].number - 1000))
                } else {
                    newDataDictionary[key]?.append(array[i])
                }
            }
        }
        
        self.dataDictionary = newDataDictionary
        
    }
    
    func minusOneOdd() {
        
        var newDataDictionary: [NumberSection: [NumberModel]] = [:]
        
        for (key, array) in dataDictionary {
            newDataDictionary[key] = []
            for i in 0 ..< array.count {
                if array[i].number % 2 != 0 {
                    newDataDictionary[key]?.append(NumberModel(number: array[i].number - 1000))
                } else {
                    newDataDictionary[key]?.append(array[i])
                }
            }
        }
        
        self.dataDictionary = newDataDictionary
        
    }
    
}
