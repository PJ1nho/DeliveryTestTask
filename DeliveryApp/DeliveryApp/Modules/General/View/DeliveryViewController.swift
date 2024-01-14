import UIKit

class DeliveryViewController: UIViewController, DeliveryViewProtocol {
    
    // MARK: - UI Elements
    
    private lazy var titleView : UIView = {
        let titleView = UIView()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.backgroundColor = .deliveryBackground
        return titleView
    }()
    
    private lazy var locationButton: UIButton = {
        let locationButton = UIButton(type: .system)
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.setTitle("Москва", for: .normal)
        locationButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        locationButton.setTitleColor(.label, for: .normal)
        locationButton.setImage(UIImage(named: "downArrow"), for: .normal)
        locationButton.tintColor = .black
        locationButton.semanticContentAttribute = .forceRightToLeft
        locationButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        locationButton.contentHorizontalAlignment = .trailing
        return locationButton
    }()
    
    private lazy var categoryHeaderView: CategoryCollectionReusableView = {
        let categoryHeaderView = CategoryCollectionReusableView()
        categoryHeaderView.translatesAutoresizingMaskIntoConstraints = false
        return categoryHeaderView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.bannerCellIdentifier)
        collectionView.register(CategoryCollectionReusableView.self, forSupplementaryViewOfKind: "Header", withReuseIdentifier: CategoryCollectionReusableView.categoryViewIdentifier)
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.menuCellIdentifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // MARK: - Properties
    
    public var presenter: DeliveryPresenterProtocol
    
    // MARK: - Init
    
    required init(presenter: DeliveryPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.setupView()
    }
    
    // MARK: SetupUI
    
    private func setupUI() {
        setupViews()
        setupConstraints()
        configureCompositionalLayout()
    }
    
    private func setupViews() {
        view.backgroundColor = .deliveryBackground
        view.addSubview(titleView)
        titleView.addSubview(locationButton)
        view.addSubview(categoryHeaderView)
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 40),
            
            locationButton.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 16),
            locationButton.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 5),
            locationButton.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureCompositionalLayout() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch sectionIndex {
            case 0:
                return self.bannerSection()
            case 1:
                return self.menuSection()
            default:
                return NSCollectionLayoutSection(group: NSCollectionLayoutGroup(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0), heightDimension: .fractionalHeight(0))))
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    // MARK: - Functions
    
    func scrollToItem(index: Int) {
        collectionView.scrollToItem(at: .init(item: index, section: 1), at: .top, animated: true)
    }
}

// MARK: - UICollectionViewDataSource&UICollectionViewDelegate

extension DeliveryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems(at: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let bannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.bannerCellIdentifier, for: indexPath) as? BannerCollectionViewCell
            let bannerViewModel = presenter.viewModel(at: indexPath) as? BannerViewModel
            bannerCell?.bannerImageView.image = bannerViewModel?.image
            return bannerCell ?? BannerCollectionViewCell()
        case 1:
            let menuCell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.menuCellIdentifier, for: indexPath) as? MenuCollectionViewCell
            let dishViewModel = presenter.viewModel(at: indexPath) as? DishViewModel
            if indexPath.row == 0 {
                menuCell?.layer.cornerRadius = 30
                menuCell?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            }
            menuCell?.menuCellImageView.image = dishViewModel?.image
            menuCell?.menuCellTitleLabel.text = dishViewModel?.title
            menuCell?.menuCellDescriptionLabel.text = dishViewModel?.description
            menuCell?.menuCellButton.setTitle(String(dishViewModel?.price ?? 0), for: .normal)
            menuCell?.backgroundColor = .white
            return menuCell ?? MenuCollectionViewCell()
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == "Header" {
            switch indexPath.section {
            case 1:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CategoryCollectionReusableView.categoryViewIdentifier, for: indexPath) as? CategoryCollectionReusableView
                header?.categories = presenter.headerViewModel()
                header?.delegate = self
                return header ?? UICollectionReusableView()
            default:
                return UICollectionReusableView()
            }
        } else {
            return UICollectionReusableView()
        }
    }
}

// MARK: - Compositional Methods

extension DeliveryViewController {
    
    private func bannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(112))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 16)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }
    
    private func menuSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0)
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)), elementKind: "Header", alignment: .top)
        sectionHeader.pinToVisibleBounds = true
        section.boundarySupplementaryItems = [
            sectionHeader
        ]
        return section
    }
}

// MARK: - CategoryCollectionReusableViewDelegate

extension DeliveryViewController: CategoryCollectionReusableViewDelegate {
    func didSelectCategory(categoryTitle: String?) {
        presenter.didSelectCategory(categoryTitle: categoryTitle)
    }
}
