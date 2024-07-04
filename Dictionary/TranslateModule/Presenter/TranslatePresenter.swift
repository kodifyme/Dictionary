//
//  TranslatePresenter.swift
//  Dictionary
//
//  Created by KOДИ on 17.06.2024.
//

import UIKit

/*protocol TranslatePresenterInput {
 var output: TranslatePresenterOutput? { get set }
 }
 
 protocol TranslatePresenterOutput: AnyObject {
 func didFetchTranslation(_ translation: String)
 func didFailToFetchTranslation(error: Error)
 }*/

//weak var output: TranslatePresenterOutput?

final class TranslatePresenter {
    
    private var view: TranslateViewInput
    private var interactor: TranslateInteractorInput
    private var router: TranslateRouterInput
    
    init(view: TranslateViewInput, interactor: TranslateInteractorInput, router: TranslateRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - TranslateViewOutput
extension TranslatePresenter: TranslateViewOutput {
    
    func didPressLanguageButton(isSourceLanguage: Bool) {
        interactor.isSourceLanguage = isSourceLanguage
        router.openLanguageSelectionScreen()
    }
    
    func didEnterText(_ text: String) {
        interactor.fetchTranslation(for: text)
    }
    
    func didLoad() {
        interactor.viewDidLoad()
    }
}

//MARK: - LanguageSelectionDelegate
extension TranslatePresenter: TranslateRouterOutput {
    func didSelectLanguage(_ languageName: Language) {
        interactor.changeLanguageTo(languageName)
        if let currentText = view.getCurrentText() {
            interactor.fetchTranslation(for: currentText)
        }
    }
}

//MARK: - TranslateInteractorOutput
extension TranslatePresenter: TranslateInteractorOutput {
    
    func didFetchTranslation(_ translation: String) {
        view.displayTranslation(translation)
    }
    
    func didFailToFetchTranslation(error: Error) {
        print(error)
    }
    
    func setLanguages(_ source: String, target: String) {
        view.setSourceLanguage(source)
        view.setTargetLanguage(target)
    }
}
