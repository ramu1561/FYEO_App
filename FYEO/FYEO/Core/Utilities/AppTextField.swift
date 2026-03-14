//
//  AppTextField.swift
//  FYEO
//
//  Created by Harvi Jivani on 12/03/26.
//


import UIKit

@IBDesignable
class AppTextField: UITextField {

    @IBOutlet weak var errorLabel: UILabel?
    var validationType: ValidationType = .none
    var errorMessage: String?

    // MARK: - Inspectable Properties

    @IBInspectable var cornerRadius: CGFloat = 8 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var borderColor: UIColor = .lightGray {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var placeholderColor: UIColor = .lightGray {
        didSet {
            updatePlaceholder()
        }
    }

    @IBInspectable var textPadding: CGFloat = 10

    // MARK: - Init

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }

    private func setup() {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        setupErrorLabel()
        updatePlaceholder()
        self.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }

    @objc private func textDidChange() {
        hideError()
    }
    // MARK: - Padding

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: textPadding, dy: 0)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: textPadding, dy: 0)
    }

    // MARK: - Placeholder Styling

    private func updatePlaceholder() {
        if let placeholder = placeholder {
            attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [.foregroundColor: placeholderColor]
            )
        }
    }

    // MARK: - Error Label

    private func setupErrorLabel() {
        errorLabel?.textColor = .red
        errorLabel?.font = UIFont.systemFont(ofSize: 12)
        errorLabel?.numberOfLines = 0
        errorLabel?.isHidden = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    //MARK: - Validation
    
    func validate() -> Bool {

        let text = self.text ?? ""

        switch validationType {

        case .required:
            if text.isEmpty {
                showError(errorMessage ?? "This field is required")
                return false
            }

        case .email:
            if !text.contains("@") {
                showError(errorMessage ?? "Enter valid email")
                return false
            }

        case .phone:
            if text.count < 10 {
                showError(errorMessage ?? "Enter valid phone")
                return false
            }

        case .password:
            if text.count < 6 {
                showError(errorMessage ?? "Password must be 6 characters")
                return false
            }

        case .none:
            break
        }

        hideError()
        return true
    }
    // MARK: - Show Error
    func showError(_ message: String) {
        errorLabel?.text = message
        errorLabel?.isHidden = false
        layer.borderColor = UIColor.red.cgColor
    }
    
    func hideError() {
        errorLabel?.isHidden = true
        layer.borderColor = UIColor.lightGray.cgColor
    }
}

enum ValidationType {
    case none
    case email
    case password
    case phone
    case required
}
