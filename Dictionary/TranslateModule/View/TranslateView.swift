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
    func displayTranslation(_ translation: String)
    func getCurrentText() -> String?
    func setCurrentText(_ text: String)
}

protocol TranslateViewOutput {
    func didPressLanguageButton(isSourceLanguage: Bool)
    func didEnterText(_ text: String)
    func didLoad()
    func didPressReverseButton()
}

final class TranslateView: UIViewController, TranslateViewInput {
    
    var output: TranslateViewOutput?
    
    private var typingTimer: Timer?
    private let typingDelay: TimeInterval = 1
    
    private lazy var leftButton = CustomButton.createButton(title: "",
                                                            type: .system,
                                                            target: self,
                                                            action:
                                                            #selector(leftButtonPressed))
    
    private lazy var rightButton = CustomButton.createButton(title: "",
                                                             type: .system,
                                                             target: self,
                                                             action: #selector(rightButtonPressed))
    
    private lazy var reverseButton = CustomButton.createButton(title: "↔️",
                                                               type: .system,
                                                               target: self,
                                                               action: #selector(reverseButtonPressed))
    
    private lazy var selectLanguageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [leftButton, reverseButton, rightButton])
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Text or website address"
        textField.contentVerticalAlignment = .top
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.delegate = self
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
        
        output?.didLoad()
        
        setupView()
        setupKeyboardDismissalGestures()
        setupConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = .systemYellow
        view.addSubview(selectLanguageStackView)
        
        view.addSubview(backView)
        backView.addSubview(inputTextField)
        backView.addSubview(separatorView)
        backView.addSubview(translationLabel)
    }
    
    func getCurrentText() -> String? {
        inputTextField.text
    }
    
    func setCurrentText(_ text: String) {
        inputTextField.text = translationLabel.text
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        typingTimer?.invalidate()
        if let text = textField.text, !text.isEmpty {
            typingTimer = Timer.scheduledTimer(withTimeInterval: typingDelay, repeats: false) { [weak self] _ in
                self?.output?.didEnterText(text)
            }
        } else {
            translationLabel.text = ""
        }
    }
    
    @objc private func leftButtonPressed() {
        output?.didPressLanguageButton(isSourceLanguage: true)
    }
    
    @objc private func rightButtonPressed() {
        output?.didPressLanguageButton(isSourceLanguage: false)
    }
    
    @objc private func reverseButtonPressed() {
        output?.didPressReverseButton()
    }
}

//MARK: - TranslateViewInput
extension TranslateView {
    
    func setSourceLanguage(_ language: String) {
        leftButton.setTitle(language, for: .normal)
    }
    
    func setTargetLanguage(_ language: String) {
        rightButton.setTitle(language, for: .normal)
    }
    
    func displayTranslation(_ translation: String) {
        translationLabel.text = translation
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
            backView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            backView.heightAnchor.constraint(equalToConstant: 400),
            
            inputTextField.topAnchor.constraint(equalTo: backView.topAnchor, constant: 15),
            inputTextField.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
            inputTextField.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
            inputTextField.heightAnchor.constraint(equalToConstant: 50),
            
            separatorView.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 15),
            separatorView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
            separatorView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            translationLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 20),
            translationLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
            translationLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10)
        ])
    }
}
