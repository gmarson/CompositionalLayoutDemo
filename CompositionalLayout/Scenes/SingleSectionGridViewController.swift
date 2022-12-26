//
//  SingleSectionGridViewController.swift
//  CompositionalLayout
//
//  Created by Gabriel Augusto Marson on 26/12/22.
//

import UIKit

final class SingleSectionGridViewController: BaseViewController<SingleSectionViewModel> {

    private var dataSource: NumberDataSource?
    private var currentSnapshot: NumberSnapshot = NumberSnapshot()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: LayoutProvider().gridLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(NumberCell.self, forCellWithReuseIdentifier: NumberCell.identifier)
        return collectionView
    }()
    
    private let layoutProvider = LayoutProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        collectionView.reloadData()
    }
        
    override func setupViews() {
        view.addSubview(collectionView)
    }
    
    override func setupConstraints() {
        collectionView.pinToSuperView()
    }
    
    private func setupCollectionView() {
        dataSource = NumberDataSource(collectionView: collectionView, cellProvider: { [weak self] collectionView, indexPath, itemIdentifier in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberCell.identifier, for: indexPath) as? NumberCell,
                  let item = self?.viewModel.dataDictionary[.grid]?[indexPath.row]
            else {
                return UICollectionViewCell()
            }
            
            cell.configure(item: item)
            
            return cell
        })
        
        collectionView.dataSource = dataSource
        
        currentSnapshot.appendSections([.grid])
        guard let numbers = viewModel.dataDictionary[.grid] else { return }
        currentSnapshot.appendItems(numbers)
        dataSource?.apply(currentSnapshot, animatingDifferences: true)
        
    }

}
