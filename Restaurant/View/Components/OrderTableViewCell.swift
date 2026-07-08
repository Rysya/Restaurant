import UIKit

final class OrderTableViewCell: UITableViewCell {
    static let id = "OrderTableViewCell"

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.numberOfLines = 0
        return label
    }()
    
    var countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    var sumLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.text = " ₽"
        label.textAlignment = .right
        return label
    }()
    
    var sumLineFirst: UIView = {
        let line = UIView()
        line.backgroundColor = .lightGray
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    var sumLineSecond: UIView = {
        let line = UIView()
        line.backgroundColor = .lightGray
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    private let sumStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    
    private let stackLabel: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins.left = 10
        stack.layoutMargins.right = 10
        stack.layoutMargins.top = 10
        stack.layoutMargins.bottom = 10
        stack.distribution = .equalSpacing
        return stack
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupUI() {
        stackLabel.addArrangedSubview(titleLabel)
        stackLabel.addArrangedSubview(sumStack)
        sumStack.addArrangedSubview(countLabel)
        sumStack.addArrangedSubview(sumLabel)
        self.addSubviews([stackLabel, sumLineFirst, sumLineSecond])
    }
    
    // MARK: - Constraints

    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            stackLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
            
            sumStack.widthAnchor.constraint(equalTo: stackLabel.widthAnchor, multiplier: 0.3),
            sumStack.centerYAnchor.constraint(equalTo: stackLabel.centerYAnchor),
 
            titleLabel.centerYAnchor.constraint(equalTo: stackLabel.centerYAnchor),
            
            countLabel.centerYAnchor.constraint(equalTo: stackLabel.centerYAnchor),
            
            sumLineFirst.widthAnchor.constraint(equalToConstant: 1),
            sumLineFirst.heightAnchor.constraint(equalTo: stackLabel.heightAnchor, multiplier: 0.8),
            sumLineFirst.trailingAnchor.constraint(equalTo: stackLabel.trailingAnchor, constant:  -140),
            sumLineFirst.centerYAnchor.constraint(equalTo: stackLabel.centerYAnchor),
            
            sumLineSecond.widthAnchor.constraint(equalToConstant: 1),
            sumLineSecond.heightAnchor.constraint(equalTo: stackLabel.heightAnchor, multiplier: 0.8),
            sumLineSecond.trailingAnchor.constraint(equalTo: stackLabel.trailingAnchor, constant:  -80),
            sumLineSecond.centerYAnchor.constraint(equalTo: stackLabel.centerYAnchor),
            ])
    }
}
