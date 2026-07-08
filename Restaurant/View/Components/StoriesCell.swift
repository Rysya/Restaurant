import UIKit

class StoriesCell: UICollectionViewCell {
    
    static let reuseID = "StoriesCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue
        layer.cornerRadius = 32
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
