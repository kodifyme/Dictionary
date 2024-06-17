//
//  TranslateView.swift
//  Dictionary
//
//  Created by KOДИ on 17.06.2024.
//

import UIKit

protocol TranslateViewInput {
    
}

protocol TranslateViewOutput {
    
}

final class TranslateView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
        setupView()
        setupConstraints()
    }
    
    private func setupAppearance() {
        view.backgroundColor = .systemYellow
    }
    
    private func setupView() {
        
    }
}

private extension TranslateView {
    func setupConstraints() {
        
    }
}
