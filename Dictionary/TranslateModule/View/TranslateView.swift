//
//  TranslateView.swift
//  Dictionary
//
//  Created by KOДИ on 17.06.2024.
//

import UIKit

protocol TranslateViewInput {
    var output: TranslateViewOutput? { get set }
    func setSourceLanguage(_ language: String)
    func setTargetLanguage(_ language: String)
}

protocol TranslateViewOutput {
    func didPressLanguageButton(isSourceLanguage: Bool)
}

final class TranslateView: UIViewController, TranslateViewInput {
    
    var output: TranslateViewOutput?
    
    private lazy var leftButton = CustomButton.createButton(title: "English",
                                                            type: .system,
                                                            target: self,
                                                            action: #selector(leftButtonPressed))
    
    private lazy var rightButton = CustomButton.createButton(title: "Russian",
                                                             type: .system,
                                                             target: self,
                                                             action: #selector(rightButtonPressed))
    
    private let betweenLabel: UILabel = {
        let label = UILabel()
        label.text = "↔"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var selectLanguageStackView: UIStackView = {
        UIStackView(arrangedSubviews: [leftButton, betweenLabel, rightButton], axis: .horizontal, spacing: 5)
    }()
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Text or website address"
        textField.contentVerticalAlignment = .top
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let translationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupKeyboardDismissalGestures()
        setupConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = .systemYellow
        
        view.addSubview(selectLanguageStackView)
        view.addSubview(backView)
        backView.addSubview(inputTextField)
        inputTextField.delegate = self
        
        backView.addSubview(separatorView)
        backView.addSubview(translationLabel)
    }
    
    
    func setSourceLanguage(_ language: String) {
        leftButton.setTitle(language, for: .normal)
    }
    
    func setTargetLanguage(_ language: String) {
        rightButton.setTitle(language, for: .normal)
    }
    
    @objc private func leftButtonPressed() {
        output?.didPressLanguageButton(isSourceLanguage: true)
    }
    
    @objc private func rightButtonPressed() {
        output?.didPressLanguageButton(isSourceLanguage: false)
    }
}

//MARK: - UITapGestureRecognizer
private extension TranslateView {
    func setupKeyboardDismissalGestures() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

//MARK: - UITextFieldDelegate
extension TranslateView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputTextField.resignFirstResponder()
        return true
    }
}

//MARK: - Constraints
private extension TranslateView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            selectLanguageStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            selectLanguageStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            backView.topAnchor.constraint(equalTo: selectLanguageStackView.bottomAnchor, constant: 10),
            backView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            backView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backView.heightAnchor.constraint(equalToConstant: 400),
            
            inputTextField.topAnchor.constraint(equalTo: backView.topAnchor, constant: 15),
            inputTextField.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 5),
            inputTextField.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            inputTextField.heightAnchor.constraint(equalToConstant: 100),
            
            separatorView.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 15),
            separatorView.leadingAnchor.constraint(equalTo: inputTextField.leadingAnchor, constant: 10),
            separatorView.centerXAnchor.constraint(equalTo: inputTextField.centerXAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 2),
            
            translationLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 20),
            translationLabel.leadingAnchor.constraint(equalTo: inputTextField.leadingAnchor, constant: 5),
            translationLabel.centerXAnchor.constraint(equalTo: inputTextField.centerXAnchor)
        ])
    }
}
