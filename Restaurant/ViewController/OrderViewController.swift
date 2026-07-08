import UIKit

final class OrderViewController: UIViewController {
    
    private var mainView: OrderView {
        view as! OrderView
    }
    
    private(set) var orders = [OrderPosition]() {
        didSet {
            mainView.updateTotal(sum: calculateTotal())
            mainView.reloadData()
        }
    }
    
    private var sumTotal: (() -> Int)?
    
    override func loadView() {
        view = OrderView(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addActions()
        navigationItem.title = "Заказ"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func addActions() {
        let pushAddAction = UIAction { _ in
            let vc = AddPositionViewController()
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
        mainView.addButton.addAction(pushAddAction, for: .touchUpInside)
    }
    
    private func calculateTotal() -> Int {
        orders.reduce(0) { partialResult, position in
            partialResult + (position.product.price * position.count)
        }
    }
    
    private func orderIndex(for section: Int, row: Int) -> Int? {
        let category = mainView.visibleCategories[section]
        let filteredOrders = orders.filter {
            $0.product.category == category
        }
        guard row < filteredOrders.count else { return nil }
        let position = filteredOrders[row]
        return orders.firstIndex {
            $0.product.title == position.product.title
        }
    }
}

extension OrderViewController: AddPosiotnDelegate {
    func addPosition(_ pos: OrderPosition) {
            if let index = orders.firstIndex(where: {
                $0.product.title == pos.product.title
            }) {
                orders[index].count += pos.count
            } else {
                orders.append(pos)
            }
            mainView.reloadData()
        }
}

extension OrderViewController: OrderViewDelegate {
    func showEditCountAlert(for section: Int, with index: Int) {
        guard let realIndex = orderIndex(for: section, row: index)
        else { return }
        
        let alert = UIAlertController(
            title: "Изменить количество",
            message: "\n\n",
            preferredStyle: .alert
        )

        let stepper = UIStepper()
        stepper.minimumValue = 1
        stepper.maximumValue = 10
        stepper.value = Double(self.orders[realIndex].count)
        
        let countLabel = UILabel()
        countLabel.text = "\(self.orders[realIndex].count) шт."

        stepper.addAction(UIAction { _ in
                countLabel.text = "\(Int(stepper.value)) шт."
            }, for: .valueChanged
        )

        alert.view.addSubviews([stepper, countLabel])

        NSLayoutConstraint.activate([
            stepper.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor,
                                             constant: -40),

            stepper.centerYAnchor.constraint(equalTo: alert.view.centerYAnchor,
                                             constant: -10),
            countLabel.leadingAnchor.constraint(equalTo: stepper.trailingAnchor,
                                                constant: 16),
            countLabel.centerYAnchor.constraint(equalTo: alert.view.centerYAnchor,
                                                constant: -10)
        ])
        
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default) {[weak self] _ in
            self?.orders[realIndex].count = Int(stepper.value)
            self?.mainView.reloadData()
        })

        alert.addAction(UIAlertAction(title: "Отмена",
                                      style: .destructive))
        present(alert, animated: true)
    }
    
    func deleteOrder(for section: Int, with index: Int) {
        guard let realIndex = orderIndex(for: section, row: index)
        else { return }
        orders.remove(at: realIndex)
        mainView.reloadData()
    }
}
