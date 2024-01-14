//
//  SectionsCollectionViewCell.swift
//  DeliveryApp
//
//  Created by Тихтей  Павел on 13.01.2024.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let categoryCellIdentifier = "CategoryCellIdentifier"
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.font = .systemFont(ofSize: 13, weight: .regular)
        title.textColor = .categoryDefaultText
        contentView.backgroundColor = .clear
    }
    
    // MARK: - SetupUI
    
    lazy var title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .systemFont(ofSize: 13, weight: .regular)
        title.textColor = .categoryDefaultText
        title.numberOfLines = 0
        return title
    }()
    
    // MARK: - Private Methods
    
    private func setupViews() {
        contentView.addSubview(title)
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.categoryDefaultText.cgColor
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
