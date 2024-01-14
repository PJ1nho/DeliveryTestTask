//
//  MenuCollectionViewCell.swift
//  DeliveryApp
//
//  Created by Тихтей  Павел on 13.01.2024.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    static let menuCellIdentifier = "MenuCellIdentifier"
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupConstraints()
    }
    
    // MARK: - SetupUI
    
    lazy var menuCellImageView: UIImageView = {
        let menuImageView = UIImageView()
        menuImageView.translatesAutoresizingMaskIntoConstraints = false
        menuImageView.clipsToBounds = true
        menuImageView.contentMode = .scaleAspectFill
        return menuImageView
    }()
    
    lazy var menuCellTitleLabel: UILabel = {
        let menuTitle = UILabel()
        menuTitle.translatesAutoresizingMaskIntoConstraints = false
        menuTitle.numberOfLines = 0
        menuTitle.font = .systemFont(ofSize: 17, weight: .semibold)
        menuTitle.lineBreakMode = .byWordWrapping
        return menuTitle
    }()
    
    lazy var menuCellDescriptionLabel: UILabel = {
        let menuDescription = UILabel()
        menuDescription.translatesAutoresizingMaskIntoConstraints = false
        menuDescription.numberOfLines = 0
        menuDescription.textColor = .menuDescriptionText
        menuDescription.font = .systemFont(ofSize: 13, weight: .regular)
        menuDescription.lineBreakMode = .byWordWrapping
        return menuDescription
    }()
    
    lazy var menuCellButton: UIButton = {
        let menuCellButton = UIButton()
        menuCellButton.translatesAutoresizingMaskIntoConstraints = false
        menuCellButton.layer.cornerRadius = 6
        menuCellButton.layer.borderWidth = 1
        menuCellButton.layer.borderColor = UIColor.menuButton.cgColor
        menuCellButton.titleLabel?.font = .systemFont(ofSize: 13, weight: .regular)
        menuCellButton.setTitleColor(.menuButton, for: .normal)
        return menuCellButton
    }()
    
    lazy var verticalStackView: UIStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 8
        verticalStackView.distribution = .fillProportionally
        verticalStackView.alignment = .top
        return verticalStackView
    }()
    
    lazy var bottomLine: UIView = {
        let bottomLine = UIView()
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        bottomLine.backgroundColor = .menuUnderline
        return bottomLine
    }()
    
    // MARK: - Private Methods
    
    private func addViews() {
        contentView.addSubview(menuCellImageView)
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(menuCellTitleLabel)
        verticalStackView.addArrangedSubview(menuCellDescriptionLabel)
        contentView.addSubview(menuCellButton)
        contentView.addSubview(bottomLine)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            menuCellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            menuCellImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            menuCellImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            menuCellImageView.widthAnchor.constraint(equalTo: menuCellImageView.heightAnchor),
            
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            verticalStackView.leadingAnchor.constraint(equalTo: menuCellImageView.trailingAnchor, constant: 30),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            verticalStackView.bottomAnchor.constraint(equalTo: menuCellButton.topAnchor, constant: -10),
            menuCellTitleLabel.topAnchor.constraint(equalTo: verticalStackView.topAnchor),
            
            menuCellButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            menuCellButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            menuCellButton.widthAnchor.constraint(equalToConstant: 87),
            menuCellButton.heightAnchor.constraint(equalToConstant: 32),
            
            bottomLine.heightAnchor.constraint(equalToConstant: 1),
            bottomLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
