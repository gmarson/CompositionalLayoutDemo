//
//  ListGridColumnViewController.swift
//  CompositionalLayout
//
//  Created by Gabriel Augusto Marson on 26/12/22.
//

import UIKit
import Combine

final class ListGridColumnViewController: BaseViewController<ListGridColumnViewModel> {

    private var bag: Set<AnyCancellable> = .init()
    private var dataSource: NumberDataSource?
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: LayoutProvider().listGridColumnLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(NumberCell.self, forCellWithReuseIdentifier: NumberCell.identifier)
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        return collectionView
    }()
    
    private lazy var plusOneEvenButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+1k all even", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(plusOneEven), for: .touchUpInside)
        return button
    }()
    
    private lazy var minusOneEvenButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("-1k all even", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(minusOneEven), for: .touchUpInside)
        return button
    }()
    
    private lazy var plusOneOddButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+1k all odd", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(plusOneOdd), for: .touchUpInside)
        return button
    }()
    
    private lazy var minusOneOddButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("-1k all odd", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(minusOneOdd), for: .touchUpInside)
        return button
    }()
    
    private lazy var oddStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var evenStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var emptyBottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var operationsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.backgroundColor = .lightGray
        return stackView
    }()
    
    private let layoutProvider = LayoutProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupObservers()
    }
        
    override func setupViews() {
        view.addSubview(collectionView)
        view.addSubview(operationsStackView)
        view.addSubview(emptyBottomView)
        operationsStackView.addArrangedSubview(evenStackView)
        operationsStackView.addArrangedSubview(oddStackView)
        evenStackView.addArrangedSubview(plusOneEvenButton)
        evenStackView.addArrangedSubview(minusOneEvenButton)
        oddStackView.addArrangedSubview(plusOneOddButton)
        oddStackView.addArrangedSubview(minusOneOddButton)
    }
    
    override func setupConstraints() {
        view.addConstraints([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: operationsStackView.topAnchor, constant: 8)
        ])
        
        view.addConstraints([
            operationsStackView.bottomAnchor.constraint(equalTo: emptyBottomView.topAnchor),
            operationsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            operationsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            operationsStackView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        view.addConstraints([
            emptyBottomView.heightAnchor.constraint(equalToConstant: 20),
            emptyBottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            emptyBottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyBottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
    }
    
    private func setupObservers() {
        viewModel.$collectionSnapshot.sink { [weak self] in
            self?.dataSource?.apply($0, animatingDifferences: true)
        }.store(in: &bag)
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
        
        dataSource?.supplementaryViewProvider = { (view, kind, indexPath) in
            
            guard let sectionHeader = self.collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as? HeaderCollectionReusableView,
                let numberSection = NumberSection(rawValue: indexPath.section)
            else {
                return UICollectionReusableView()
            }
            
            sectionHeader.configure(numberSection.stringDescription)
            return sectionHeader
        }
        
        collectionView.dataSource = dataSource
    }
    
}


// MARK: - Actions

extension ListGridColumnViewController {
    
    @objc private func plusOneEven() { viewModel.plusOneEven() }
    @objc private func plusOneOdd() { viewModel.plusOneOdd() }
    @objc private func minusOneEven() { viewModel.minusOneEven() }
    @objc private func minusOneOdd() { viewModel.minusOneOdd() }
    
}
