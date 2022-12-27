//
//  HeaderCollectionReusableView.swift
//  CompositionalLayout
//
//  Created by Gabriel Augusto Marson on 27/12/22.
//
// https://github.com/jamesrochabrun/UICollectionViewDiffableDataSource/blob/master/DiffableDataSource/Views/TitleSupplementaryView.swift

import UIKit

final class HeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "HeaderCollectionReusableView"
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViews() {
        addSubview(label)
    }
    
    func setupConstraints() {
        label.pinToSuperView(leading: 10, trailing: -10, top: 10, bottom: -10)
    }
    
    func configure(_ text: String) {
        label.text = text
    }
    
}
