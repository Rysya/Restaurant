import UIKit

class OrderView: UIView {
    
    let addButton = UIButton()
    
    var order: [OrderPosition] = [] {
           didSet {
               tableView.reloadData()
           }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(OrderTableViewCell.self, forCellReuseIdentifier: OrderTableViewCell.id)
        return tableView
    }()

    
    init () {
        super.init(frame: CGRect())
        setTableView()
        setButton()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setButton() {
        addButton.setTitle("Добавить товар", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = .systemBlue
        addButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setTableView() {
        addSubviews([tableView])
        tableView.tableHeaderView = addButton
    }

    // MARK: - Navigation
    
    func setConstraints() {
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
         order.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.id, for: indexPath) as! OrderTableViewCell
        let position = order[indexPath.row]
        cell.titleLabel.text = position.product.title
        cell.countLabel.text = "\(position.count)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Изменить") { _, _, _ in
            let alert = UIAlertController(title: "Изменить гостя", message: nil, preferredStyle: .alert)
            
            alert.addTextField { (textField) in
                textField.text = self.order[indexPath.row].product.title
            }
           
//            let action = UIAlertAction(title: "OK", style: .default) { _ in
//                self.order[indexPath.row].product. = alert.textFields?[0].text ?? ""
//                self.tableView.reloadData()
//            }
            let cancel = UIAlertAction(title: "Отмена", style: .destructive)
//            alert.addAction(action)
            alert.addAction(cancel)
//            self.present(alert, animated: true)
        }
        action.backgroundColor = .green
        let config = UISwipeActionsConfiguration(actions: [action])
        return config
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, _ in
            self.order.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        return config
    }
}
