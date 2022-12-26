//
//  NumberCell.swift
//  CompositionalLayout
//
//  Created by Gabriel Augusto Marson on 19/12/22.
//

import UIKit

final class NumberCell: UICollectionViewCell {
    
    static let identifier: String = "NumberCell"
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(numberLabel)
    }
    
    private func setupConstraints() {
        numberLabel.pinToSuperView(leading: 4.0, trailing: -4.0, top: 4.0, bottom: -4.0)
    }
    
    func configure(item: NumberModel) {
        numberLabel.text = "\(item.number)"
        backgroundColor = .random()
    }
    
}
