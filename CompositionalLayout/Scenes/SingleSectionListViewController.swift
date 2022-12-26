//
//  SingleSectionViewController.swift
//  CompositionalLayout
//
//  Created by Gabriel Augusto Marson on 19/12/22.
//

import UIKit

struct SingleSectionListViewModel: BaseViewModel {
    
    var numberArray: [NumberModel]
    
    init(numberArray: [Int]) {
        self.numberArray = numberArray.map { NumberModel(number: $0) }
    }
    
}

final class SingleSectionListViewController: BaseViewController<SingleSectionListViewModel> {

    private var dataSource: NumberDataSource?
    private var currentSnapshot: NumberSnapshot = NumberSnapshot()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: LayoutProvider().basicListLayout())
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
                  let item = self?.viewModel.numberArray[indexPath.row]
            else {
                return UICollectionViewCell()
            }
            
            cell.configure(item: item)
            
            return cell
        })
        
        collectionView.dataSource = dataSource
        
        currentSnapshot.appendSections([0])
        currentSnapshot.appendItems(viewModel.numberArray)
        dataSource?.apply(currentSnapshot, animatingDifferences: true)
        
    }
    

}
