//
//  MenuViewController.swift
//  CompositionalLayout
//
//  Created by Gabriel Augusto Marson on 19/12/22.
//

import UIKit

struct MenuViewModel: BaseViewModel { }

final class MenuViewController: BaseViewController<MenuViewModel> {
    
    private lazy var singleSectionListButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Single Section List", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(singleSectionListPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var singleSectionGridButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Single Section Grid", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(singleSectionGridPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var singleSectionColumnButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Single Section Column", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(singleSectionColumnPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    override func setupViews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(singleSectionListButton)
        stackView.addArrangedSubview(singleSectionGridButton)
        stackView.addArrangedSubview(singleSectionColumnButton)
    }
    
    override func setupConstraints() {
        stackView.centerToSuperView()
    }
    
}

// MARK: - Actions
extension MenuViewController {
    
    @objc
    private func singleSectionListPressed() {
        let viewModel = SingleSectionListViewModel(numberArray: [1,2,3,4,5,6,7,8])
        let viewController = SingleSectionListViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc
    private func singleSectionGridPressed() {
        let viewModel = SingleSectionGridViewModel(numberArray: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15, 99999999, 99999, 9999])
        let viewController = SingleSectionGridViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc
    private func singleSectionColumnPressed() {
        let viewModel = SingleSectionColumnViewModel(numberArray: [1,2,3,4,5,6,7,8])
        let viewController = SingleSectionColumnViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

