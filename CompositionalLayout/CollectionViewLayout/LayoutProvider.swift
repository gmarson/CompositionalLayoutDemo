//
//  LayoutProvider.swift
//  CompositionalLayout
//
//  Created by Gabriel Augusto Marson on 19/12/22.
//

import Foundation
import UIKit

struct LayoutProvider {
    
    var headerFooterSize: NSCollectionLayoutSize {
        NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44)
        )
    }
    
    func buildFooterSection() -> NSCollectionLayoutBoundarySupplementaryItem {
        NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom
        )
    }
    
    func buildHeaderSection() -> NSCollectionLayoutBoundarySupplementaryItem {
        NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: UICollectionView.elementKindSectionHeader, alignment: .top
        )
    }
    
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
            
            let config = UICollectionViewCompositionalLayoutConfiguration()
            config.interSectionSpacing = 16
            
            let section: NSCollectionLayoutSection
            switch sectionLayoutKind {
            case .list:
                section = NSCollectionLayoutSection(group: listLayoutGroup)
            case .grid:
                section = NSCollectionLayoutSection(group: gridLayoutGroup)
                section.orthogonalScrollingBehavior = .continuous
            case .column:
                section = NSCollectionLayoutSection(group: columnLayoutGroup)
            }
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            section.boundarySupplementaryItems = [buildHeaderSection()]
            
            return section
        }
        
        return layout
    }
    
}
