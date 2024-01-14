//
//  CategoryCollectionReusableView.swift
//  DeliveryApp
//
//  Created by Тихтей  Павел on 13.01.2024.
//

protocol CategoryCollectionReusableViewDelegate: AnyObject {
    func didSelectCategory(categoryTitle: String?)
}

import UIKit

class CategoryCollectionReusableView: UICollectionReusableView {
    static let categoryViewIdentifier = "CategoryHeader"
    
    var categories = [String]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    weak var delegate: CategoryCollectionReusableViewDelegate?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        backgroundColor = .deliveryBackground
        setupConstaints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupUI
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .deliveryBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.categoryCellIdentifier)
        return collectionView
    }()
    
    // MARK: - Private Methods
    
    private func setupConstaints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    func selectFirstItem() {
        self.collectionView(self.collectionView, didSelectItemAt: .init(item: 0, section: 0))
    }
}

// MARK: UICollectionView Methods

extension CategoryCollectionReusableView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.categoryCellIdentifier, for: indexPath) as? CategoryCollectionViewCell
        categoryCell?.title.text = categories[indexPath.row]
        return categoryCell ?? CategoryCollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = categories[indexPath.row]
        label.sizeToFit()
        return CGSize(width: label.frame.width + 5, height: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categoryCell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell
        categoryCell?.contentView.backgroundColor = .categorySelecredBackground
        categoryCell?.title.font = .systemFont(ofSize: 13, weight: .bold)
        categoryCell?.title.textColor = .categorySelectedText
        delegate?.didSelectCategory(categoryTitle: categories[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let categoryCell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell
        categoryCell?.contentView.backgroundColor = .clear
        categoryCell?.title.font = .systemFont(ofSize: 13, weight: .regular)
        categoryCell?.title.textColor = .categoryDefaultText
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
