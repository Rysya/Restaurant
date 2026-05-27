import UIKit

class MenuView: UIView {

    let collectionView = UICollectionView(frame: CGRect(),
                                          collectionViewLayout: CompositionalLayoutService.shared.createLayout())
    
    init() {
        super.init(frame: CGRect())
        backgroundColor = .white
        collectionView.register(StoriesCell.self, forCellWithReuseIdentifier: StoriesCell.reuseID)
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseID)
        collectionView.showsVerticalScrollIndicator = false
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        collectionView.backgroundColor = .white
        addSubviews([collectionView])
    }
    
    // MARK: - Navigation
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 6),
            collectionView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
        ])
    }
}
