//
//  BaseViewController.swift
//  CompositionalLayout
//
//  Created by Gabriel Augusto Marson on 19/12/22.
//

import UIKit

protocol BaseViewModel { }

class BaseViewController<VM: BaseViewModel>: UIViewController {

    let viewModel: VM
    
    required init(viewModel: VM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    func setupViews() { }
    func setupConstraints() { }

}
