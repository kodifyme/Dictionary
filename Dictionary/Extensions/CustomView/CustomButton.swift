//
//  CustomButton.swift
//  Dictionary
//
//  Created by KOДИ on 17.06.2024.
//

import UIKit

class CustomButton: UIButton {
    
    static func createButton(title: String, type: UIButton.ButtonType, target: Any?, action: Selector) -> CustomButton {
        let button: CustomButton = CustomButton(type: type)
        button.setTitle(title, for: .normal)
        button.setupButton()
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        backgroundColor = .clear
        setTitleColor(.black, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 20)
    }
}
