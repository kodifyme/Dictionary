//
//  HistoryInteractor.swift
//  Dictionary
//
//  Created by KOДИ on 05.07.2024.
//

import UIKit

protocol HistoryInteractorInput {
    var output: HistoryInteractorOutput? { get set }
    func fetchTranslations() -> [TranslationEntity]
}

protocol HistoryInteractorOutput: AnyObject {

}

class HistoryInteractor: HistoryInteractorInput {
    
    weak var output: HistoryInteractorOutput?
    private let coreDataService = CoreDataService.shared
    
    func fetchTranslations() -> [TranslationEntity] {
        return coreDataService.fetchTranslations()
    }
}

