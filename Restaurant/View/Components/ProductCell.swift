import UIKit

class ProductCell: UICollectionViewCell {
    
    static let reuseID = "ProductCell"
    let productImageView = UIImageView(image: UIImage(systemName: "photo"))
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Название товара"
        lbl.font = .systemFont(ofSize: 14)
        return lbl
    }()
    
    let priceLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "380 ₽"
        lbl.font = .systemFont(ofSize: 16, weight: .bold)
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 12
        priceLabel.textAlignment = .right
        productImageView.layer.cornerRadius = 12
        productImageView.clipsToBounds = true
        productImageView.contentMode = .scaleAspectFill
    }
    
    // MARK: - Navigation
    
    func setConstraints() {
        let hStack = UIStackView(arrangedSubviews: [titleLabel, priceLabel])
        hStack.axis = .horizontal
        hStack.spacing = 6
        let stack = UIStackView(arrangedSubviews: [productImageView, hStack])
        stack.spacing = 4
        stack.axis = .vertical
        addSubviews([stack])
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
