//
//  LayoutProvider.swift
//  CompositionalLayout
//
//  Created by Gabriel Augusto Marson on 19/12/22.
//

import Foundation
import UIKit

struct LayoutProvider {
    
    private var columnLayoutGroup: NSCollectionLayoutGroup {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(44)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        return group
    }
    
    private var listLayoutGroup: NSCollectionLayoutGroup {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(44)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let spacing = CGFloat(10)
        group.interItemSpacing = .fixed(spacing)
        return group
    }
    
    private var gridLayoutGroup: NSCollectionLayoutGroup {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.2),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.2)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        return group
    }
    
    func listLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout(
            section: NSCollectionLayoutSection(group: listLayoutGroup)
        )
    }
    
    func gridLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout(
            section: NSCollectionLayoutSection(group: gridLayoutGroup)
        )
    }
    
    func columnLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout(
            section: NSCollectionLayoutSection(group: columnLayoutGroup)
        )
    }
    
    func listGridColumnLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            guard let sectionLayoutKind = NumberSection(rawValue: sectionIndex) else { return nil }
            
            let group: NSCollectionLayoutGroup
            switch sectionLayoutKind {
            case .list:
                group = listLayoutGroup
            case .grid:
                group = gridLayoutGroup
            case .column:
                group = columnLayoutGroup
            }

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
            return section
        }
        
        return layout
    }
    
}
