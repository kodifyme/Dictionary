//
//  TranslateRouter.swift
//  Dictionary
//
//  Created by KOДИ on 17.06.2024.
//

import UIKit

protocol TranslateRouterInput {
    func openLanguageSelectionScreen(delegate: LanguageSelectionDelegate)
}

final class TranslateRouter: TranslateRouterInput {
    weak var rootViewController: UIViewController?
    
    func openLanguageSelectionScreen(delegate: LanguageSelectionDelegate) {
        let languagesVC = LanguagesListView()
        languagesVC.delegate = delegate
        rootViewController?.present(languagesVC, animated: true)
    }
}
