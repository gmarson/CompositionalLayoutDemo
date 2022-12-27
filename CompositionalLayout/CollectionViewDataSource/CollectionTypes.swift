//
//  CollectionTypes.swift
//  CompositionalLayout
//
//  Created by Gabriel Augusto Marson on 26/12/22.
//

import Foundation
import UIKit

typealias NumberDataSource = UICollectionViewDiffableDataSource<NumberSection, NumberModel>
typealias NumberSupplementaryProvider = NumberDataSource.SupplementaryViewProvider
typealias NumberSnapshot = NSDiffableDataSourceSnapshot<NumberSection, NumberModel>
