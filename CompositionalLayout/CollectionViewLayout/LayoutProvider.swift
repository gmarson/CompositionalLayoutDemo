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
    
    func buildFooterSection(kind: String) -> NSCollectionLayoutBoundarySupplementaryItem {
        NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: "SectionHeaderElementKind" + kind, alignment: .bottom
        )
    }
    
    func buildHeaderSection(kind: String) -> NSCollectionLayoutBoundarySupplementaryItem {
        NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: "SectionHeaderElementKind" + kind, alignment: .top
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
    
    func listGridColumnLayout(kind: String) -> UICollectionViewCompositionalLayout {
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
            
//            let headerRegistration = UICollectionView.SupplementaryRegistration
//            <TitleSupplementaryView>(elementKind: SectionHeadersFootersViewController.sectionHeaderElementKind) {
//                (supplementaryView, string, indexPath) in
//                supplementaryView.label.text = "\(string) for section \(indexPath.section)"
//                supplementaryView.backgroundColor = .lightGray
//                supplementaryView.layer.borderColor = UIColor.black.cgColor
//                supplementaryView.layer.borderWidth = 1.0
//            }
            
//            section.boundarySupplementaryItems = [buildHeaderSection(kind: kind)]
            
            return section
        }
        
        return layout
    }
    
}
