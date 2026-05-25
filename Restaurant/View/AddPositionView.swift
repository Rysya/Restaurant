import UIKit

final class AddPositionView: UIView {

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
        let readyButton = UIButton(type: .custom)
        readyButton.setTitle("Готово", for: .normal)
        readyButton.setTitleColor(.white, for: .normal)
        readyButton.backgroundColor = .systemGreen
        readyButton.layer.cornerRadius = 20
        return readyButton
    }()
    
    let picker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    private let countStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    private let stack: UIStackView = {
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
    
    private func setupUI() {
        productTF.inputView = picker
        
        countStack.addArrangedSubview(stepper)
        countStack.addArrangedSubview(countLablel)
        
        stack.addArrangedSubview(productTF)
        stack.addArrangedSubview(countStack)
        stack.addArrangedSubview(readyButton)
        
        addSubviews([stack])
    }
    
    // MARK: - Navigation
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            readyButton.widthAnchor.constraint(equalToConstant: 200),
            readyButton.heightAnchor.constraint(equalToConstant: 40),
            
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            stack.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
}
