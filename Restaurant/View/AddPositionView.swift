import UIKit

class AddPositionView: UIView {

    let productTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Выберите блюдо"
        return tf
    }()

    let countLablel: UILabel = {
        let countLablel = UILabel()
        countLablel.text = "1 шт."
        return countLablel
    }()
    
    let stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 1
        stepper.maximumValue = 10
        return stepper
    }()
    
    let readyButton: UIButton = {
        let readyButton = UIButton(type: .system)
        readyButton.setTitle("Готово", for: .normal)
        readyButton.setTitleColor(.white, for: .normal)
        readyButton.backgroundColor = .systemGreen
        return readyButton
    }()
    
    let picker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    let countStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    let stack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        return stackView
    }()
    
    init() {
        super.init(frame: CGRect())
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        productTF.inputView = picker
        
        countStack.addArrangedSubview(stepper)
        countStack.addArrangedSubview(countLablel)
        
        stack.addArrangedSubview(productTF)
        stack.addArrangedSubview(countStack)
        stack.addArrangedSubview(readyButton)
        
        addSubviews([stack])
    }
    
    // MARK: - Navigation
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            stack.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
}
