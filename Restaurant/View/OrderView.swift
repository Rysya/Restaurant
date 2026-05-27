import UIKit

protocol OrderViewDelegate: AnyObject {
    var order: [OrderPosition] { get }
    
    func showEditCountAlert(with index: Int)
    func deleteOrder(with index: Int)
}

final class OrderView: UIView {
    
    let addButton = UIButton()
    
    private weak var delegate: OrderViewDelegate!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(OrderTableViewCell.self, forCellReuseIdentifier: OrderTableViewCell.id)
        return tableView
    }()
    
    private lazy var labelTotalTitle: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.text = "Итого"
        return lbl
    }()
    
    private lazy var labelTotalSum: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.text = ""
        return lbl
    }()
    
    private lazy var stackTotal: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [labelTotalTitle, labelTotalSum])
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins.left = 20
        stack.layoutMargins.right = 20
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init(delegate: OrderViewDelegate) {
        self.delegate = delegate
        super.init(frame: CGRect())
        setTableView()
        setButton()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func updateTotal(sum: Int) {
        labelTotalSum.text = "\(sum) ₽"
    }
    
    private func setButton() {
        addButton.setTitle("Добавить товар", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = .systemBlue
        addButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setTableView() {
        addSubviews([tableView])
        tableView.tableHeaderView = addButton
        tableView.tableFooterView = stackTotal
        tableView.tableFooterView?.backgroundColor = .brown
    }

    // MARK: - Navigation
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                              constant: 0),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            addButton.widthAnchor.constraint(equalTo: tableView.widthAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 70),
            
            stackTotal.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                                constant: 0),
            stackTotal.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                                 constant: 0),
            stackTotal.heightAnchor.constraint(equalToConstant: 50),
            stackTotal.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                               constant: 0),
        ])
    }
}

extension OrderView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        delegate.order.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.id, for: indexPath) as! OrderTableViewCell
        let position = delegate.order[indexPath.row]
        cell.titleLabel.text = position.product.title
        cell.countLabel.text = "\(position.count)"
        cell.sumLabel.text = "\(position.cost) ₽"
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Изменить") { _, _, _ in
            self.delegate.showEditCountAlert(with: indexPath.row)
        }
        action.backgroundColor = .systemGreen
        let config = UISwipeActionsConfiguration(actions: [action])
        return config
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, _ in
            self.delegate.deleteOrder(with: indexPath.row)
        }
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        return config
    }
}
