//
//  ListGridColumnViewController.swift
//  CompositionalLayout
//
//  Created by Gabriel Augusto Marson on 26/12/22.
//

import UIKit

final class ListGridColumnViewController: BaseViewController<ListGridColumnViewModel> {

    private var dataSource: NumberDataSource?
    private var currentSnapshot: NumberSnapshot = NumberSnapshot()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: LayoutProvider().listGridColumnLayout())
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
                  let numberSection = NumberSection(rawValue: indexPath.section),
                  let item = self?.viewModel.dataDictionary[numberSection]?[indexPath.row]
            else {
                return UICollectionViewCell()
            }
            
            cell.configure(item: item)
            
            return cell
        })
        
        collectionView.dataSource = dataSource
        
        currentSnapshot.appendSections([.list, .grid, .column])
        
        for (key, value) in viewModel.dataDictionary {
            currentSnapshot.appendItems(value, toSection: key)
        }
        
        dataSource?.apply(currentSnapshot, animatingDifferences: true)
        
    }

}


// MARK: - Changing Values

extension ListGridColumnViewController {
    
//    private func recipeDidChange(_ notification: Notification) {
//        guard
//            // Get `recipeId` from from the `userInfo` dictionary.
//            let userInfo = notification.userInfo,
//            let recipeId = userInfo[NotificationKeys.recipeId] as? Recipe.ID,
//            // Confirm that the data source contains the recipe.
//            recipeListDataSource.indexPath(for: recipeId) != nil
//        else { return }
//
//        // Get the diffable data source's current snapshot.
//        var snapshot = recipeListDataSource.snapshot()
//        // Update the recipe's data displayed in the collection view.
//        snapshot.reconfigureItems([recipeId])
//        recipeListDataSource.apply(snapshot, animatingDifferences: true)
//    }
}
