import UIKit

class OrderViewController: UIViewController {

    let mainView = OrderView()
    var order = [OrderPosition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        mainView.order = order
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
        mainView.order = order
    }
}
