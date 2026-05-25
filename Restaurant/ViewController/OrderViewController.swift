import UIKit

protocol OrderViewControllerDelegate: AnyObject {
    func reloadData()
}

final class OrderViewController: UIViewController {
    
    private var mainView: OrderView {
        view as! OrderView
    }
    
    private(set) var order = [OrderPosition]() {
        didSet {
            delegate?.reloadData()
        }
    }
    
    private weak var delegate: OrderViewControllerDelegate?
    
    override func loadView() {
        view = OrderView(delegate: self)
        delegate = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("\(order.count)")
    }
    
    func addActions() {
        let pushAddAction = UIAction { _ in
            let vc = AddPositionViewController()
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
        mainView.addButton.addAction(pushAddAction, for: .touchUpInside)
    }
}

extension OrderViewController: AddPosiotnDelegate {
    func addPosition(_ pos: OrderPosition) {
        order.append(pos)
    }
}

extension OrderViewController: OrderViewDelegate {
    func showEditCountAlert(with index: Int) {
        let alert = UIAlertController(title: "Изменить количество",
                                      message:  "\n\n",
                                      preferredStyle: .alert)
                
        let stepper = UIStepper()
            stepper.minimumValue = 1
            stepper.maximumValue = 10
            stepper.value = Double(self.order[index].count)

        let countLabel = UILabel()
            countLabel.text = "\(self.order[index].count) шт."
        
        stepper.addAction(
            UIAction { _ in
                countLabel.text = "\(Int(stepper.value)) шт."
            },
            for: .valueChanged
        )
        
        alert.view.addSubviews([stepper, countLabel])
        
        NSLayoutConstraint.activate([
            stepper.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor, constant: -40),
            stepper.centerYAnchor.constraint(equalTo: alert.view.centerYAnchor, constant: -10),
            
            countLabel.leadingAnchor.constraint(equalTo: stepper.trailingAnchor, constant: 16),
            countLabel.centerYAnchor.constraint(equalTo: alert.view.centerYAnchor, constant: -10)
        ])
        
        alert.addAction(UIAlertAction(
            title: "OK",
            style: .default
        ) { _ in
            self.order[index].count = Int(stepper.value)
        })
        
        alert.addAction(
            UIAlertAction(title: "Отмена", style: .destructive)
        )
        present(alert, animated: true)
    }
    
    func deleteOrder(with index: Int) {
        self.order.remove(at: index)
        delegate?.reloadData()
    }
}
