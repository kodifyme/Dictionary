//
//  TranslateInteractor.swift
//  Dictionary
//
//  Created by KOДИ on 17.06.2024.
//

import UIKit

protocol TranslateInteractorInput {
    var output: TranslateInteractorOutput? { get set }
    var isSourceLanguage: Bool { get set }
    func fetchTranslation(for text: String)
    func viewDidLoad()
    func changeLanguageTo(_ languageName: Language)
    func reverseLanguages(with text: String)
}

protocol TranslateInteractorOutput: AnyObject {
    func didFetchTranslation(_ translation: String)
    func didFailToFetchTranslation(error: Error)
    func setLanguages(_ source: String, target: String)
    func setCurrentText(_ text: String)
}

final class TranslateInteractor: TranslateInteractorInput {
    
    weak var output: TranslateInteractorOutput?
    private let networkService = NetworkService.shared
    private let coreDataService = CoreDataService.shared
    
    var isSourceLanguage = true
    
    private var sourceLanguage: Language = languages[0]
    private var targetLanguage: Language = languages[1]
    
    func setLanguages() {
        output?.setLanguages(sourceLanguage.name, target: targetLanguage.name)
    }
}

//MARK: - TranslateInteractorInput
extension TranslateInteractor {
    func fetchTranslation(for text: String) {
        networkService.fetchTranslation(for: text, from: sourceLanguage.code, to: targetLanguage.code) { result in
            switch result {
            case .success(let translation):
                self.coreDataService.saveTranslation(sourceText: text, translatedText: translation.text)
                print("\(text) - \(translation.text)")
                self.output?.didFetchTranslation(translation.text)
            case .failure(let error):
                self.output?.didFailToFetchTranslation(error: error)
            }
        }
    }
    
    func viewDidLoad() {
        setLanguages()
    }
    
    func changeLanguageTo(_ languageName: Language) {
        guard let selectedLanguage = languages.first(where: { $0.name ==  languageName.name})
        else { return }
        
        if isSourceLanguage { sourceLanguage = selectedLanguage }
        else { targetLanguage = selectedLanguage }
        
        setLanguages()
    }
    
    func reverseLanguages(with text: String) {
        let tempLanguage = sourceLanguage
        sourceLanguage = targetLanguage
        targetLanguage = tempLanguage
        
        setLanguages()
        
        output?.setCurrentText(text)
        fetchTranslation(for: text)
    }
}
