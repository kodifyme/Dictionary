//
//  TranslatePresenter.swift
//  Dictionary
//
//  Created by KOДИ on 17.06.2024.
//

import UIKit

protocol TranslatePresenterInput {
    var output: TranslatePresenterOutput { get set }
}

protocol TranslatePresenterOutput: AnyObject {
    
}

final class TranslatePresenter {
    weak var output: TranslatePresenterOutput?
    
    private var view: TranslateViewInput
    private var interactor: TranslateInteractorInput
    private var router: TranslateRouterInput
    private var isSourceLanguageSelection = true
    
    init(view: TranslateViewInput, interactor: TranslateInteractorInput, router: TranslateRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - TranslateViewOutput
extension TranslatePresenter: TranslateViewOutput {
    func didPressLanguageButton(isSourceLanguage: Bool) {
        isSourceLanguageSelection = isSourceLanguage
        router.openLanguageSelectionScreen(delegate: self)
    }
}

//MARK: - LanguageSelectionDelegate
extension TranslatePresenter: LanguageSelectionDelegate {
    func didSelectLanguage(_ language: String) {
        isSourceLanguageSelection ? view.setSourceLanguage(language) : view.setTargetLanguage(language)
    }
}
