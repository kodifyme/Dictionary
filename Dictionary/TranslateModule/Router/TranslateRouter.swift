//
//  TranslateRouter.swift
//  Dictionary
//
//  Created by KOДИ on 17.06.2024.
//

import UIKit

protocol TranslateRouterOutput {
    func didSelectLanguage(_ language: String)
}

protocol TranslateRouterInput {
    var rootViewController: UIViewController? { get set }
    var presenter: TranslatePresenter? { get set }
    func openLanguageSelectionScreen()
    func didSelectLanguage(_ language: String)
}

final class TranslateRouter: TranslateRouterInput {
    
    weak var rootViewController: UIViewController?
    weak var presenter: TranslatePresenter?
    
    func openLanguageSelectionScreen() {
        let languagesVC = LanguagesListView()
        languagesVC.router = self
        rootViewController?.present(languagesVC, animated: true)
    }
    
    func didSelectLanguage(_ language: String) {
        presenter?.didSelectLanguage(language)
    }
}
