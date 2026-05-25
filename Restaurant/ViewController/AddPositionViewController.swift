import UIKit

protocol AddPosiotnDelegate: AnyObject {
    func addPosition(_ pos: OrderPosition)
}

final class AddPositionViewController: UIViewController {
    weak var delegate: AddPosiotnDelegate?
    let mainView = AddPositionView()
    
    private var selectedProduct = ProductsSource.products[0] {
        didSet {
            mainView.productTF.text = selectedProduct.title
        }
    }
    
    private var count = 1 {
        didSet {
            mainView.countLablel.text = "\(count) шт."
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        view.backgroundColor = .white
        navigationItem.title = "Новая позиция"
        mainView.picker.delegate = self
        mainView.picker.dataSource = self
        
        mainView.productTF.delegate = self

        addAction()
    }
    
    private func addAction() {
        let changeCountAction = UIAction { [unowned self] _ in
            self.count = Int(self.mainView.stepper.value)
        }
        
        mainView.stepper.addAction(changeCountAction, for: .valueChanged)
        let readyAction = UIAction { [unowned self] _ in
            let orderPosition = OrderPosition(product: self.selectedProduct, count: self.count)
            self.delegate?.addPosition(orderPosition)
            self.navigationController?.popViewController(animated: true)
        }
        
        mainView.readyButton.addAction(readyAction, for: .touchUpInside)
    }
    
    // MARK: - Navigation
}

extension AddPositionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return ProductsSource.products.count
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        let product = ProductsSource.products[row]
        return product.title
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        let product = ProductsSource.products[row]
        selectedProduct = product
    }
}

extension AddPositionViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        mainView.productTF.text = ProductsSource.products[0].title
    }
}
