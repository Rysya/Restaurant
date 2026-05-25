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
    
    private func setButton() {
        addButton.setTitle("Добавить товар", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = .systemBlue
        addButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setTableView() {
        addSubviews([tableView])
        tableView.tableHeaderView = addButton
    }

    // MARK: - Navigation
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -60),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            addButton.widthAnchor.constraint(equalTo: tableView.widthAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 70),
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

extension OrderView: OrderViewControllerDelegate {
    func reloadData() {
        self.tableView.reloadData()
    }
}
