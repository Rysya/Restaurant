import UIKit

class OrderTableViewCell: UITableViewCell {
    static let id = "OrderTableViewCell"

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.numberOfLines = 0
        return label
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.textAlignment = .right
        return label
    }()
    
    let stackLabel: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        stackLabel.addArrangedSubview(titleLabel)
        stackLabel.addArrangedSubview(countLabel)
        self.addSubviews([stackLabel])
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleLabel.centerYAnchor.constraint(equalTo: stackLabel.centerYAnchor),
            
            countLabel.centerYAnchor.constraint(equalTo: stackLabel.centerYAnchor),
            ])
    }
}
