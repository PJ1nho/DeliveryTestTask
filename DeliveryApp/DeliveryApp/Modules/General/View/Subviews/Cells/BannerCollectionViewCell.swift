//
//  BannerCollectionViewCell.swift
//  DeliveryApp
//
//  Created by Тихтей  Павел on 13.01.2024.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    
    static let bannerCellIdentifier = "BannerCellIdentifier"
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bannerImageView)
        setupConstraints()
    }
    
    // MARK: - SetupUI
    
    lazy var bannerImageView: UIImageView = {
        let bannerImage = UIImageView()
        bannerImage.translatesAutoresizingMaskIntoConstraints = false
        bannerImage.clipsToBounds = true
        bannerImage.contentMode = .scaleAspectFill
        bannerImage.layer.cornerRadius = 10
        return bannerImage
    }()
    
    // MARK: - Private Methods
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bannerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bannerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bannerImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
