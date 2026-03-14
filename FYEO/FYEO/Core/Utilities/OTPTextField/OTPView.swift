//
//  OTPView.swift
//  FYEO
//
//  Created by Harvi Jivani on 12/03/26.
//

import UIKit

class OTPView: UIView, UITextFieldDelegate {

    private let hiddenTextField = UITextField()
    private var digitLabels: [UILabel] = []
    private let stackView = UIStackView()

    private(set) var digits: Int = 4   // default

    var otpChanged: ((String) -> Void)?

    // Default init → 4 digits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    // Storyboard init → 4 digits
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // Custom init → any digits
    convenience init(digits: Int) {
        self.init(frame: .zero)
        self.digits = digits
        reloadDigits()
    }

    private func setupView() {

        hiddenTextField.keyboardType = .numberPad
        hiddenTextField.textContentType = .oneTimeCode
        hiddenTextField.delegate = self
        hiddenTextField.tintColor = .clear
        hiddenTextField.textColor = .clear

        hiddenTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)

        addSubview(hiddenTextField)

        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.distribution = .fillEqually

        addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        createDigitBoxes()

        let tap = UITapGestureRecognizer(target: self, action: #selector(focusTextField))
        addGestureRecognizer(tap)
    }

    private func createDigitBoxes() {

        for _ in 0..<digits {

            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 22, weight: .bold)

            label.layer.borderWidth = 1
            label.layer.cornerRadius = 8
            label.layer.borderColor = UIColor.lightGray.cgColor
            label.clipsToBounds = true

            stackView.addArrangedSubview(label)
            digitLabels.append(label)
        }
    }

    private func reloadDigits() {

        digitLabels.forEach { $0.removeFromSuperview() }
        digitLabels.removeAll()

        createDigitBoxes()
    }

    @objc private func focusTextField() {
        hiddenTextField.becomeFirstResponder()
    }

    @objc private func textDidChange() {

        guard let text = hiddenTextField.text else { return }

        if text.count > digits {
            hiddenTextField.text = String(text.prefix(digits))
        }

        updateLabels()

        otpChanged?(hiddenTextField.text ?? "")

        if hiddenTextField.text?.count == digits {
            hiddenTextField.resignFirstResponder()
        }
    }

    private func updateLabels() {

        let text = hiddenTextField.text ?? ""

        for i in 0..<digitLabels.count {
            if i < text.count {
                let index = text.index(text.startIndex, offsetBy: i)
                digitLabels[i].text = String(text[index])
            } else {
                digitLabels[i].text = ""
            }
        }
    }

    func getOTP() -> String {
        return hiddenTextField.text ?? ""
    }

    func clearOTP() {
        hiddenTextField.text = ""
        updateLabels()
        hiddenTextField.becomeFirstResponder()
    }

    func showError() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 4
        animation.autoreverses = true

        animation.fromValue = NSValue(cgPoint: CGPoint(x: center.x - 5, y: center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: center.x + 5, y: center.y))

        layer.add(animation, forKey: "position")
    }
}
