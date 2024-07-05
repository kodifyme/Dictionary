//
//  HistoryInteractor.swift
//  Dictionary
//
//  Created by KOДИ on 05.07.2024.
//

import UIKit

protocol HistoryInteractorInput {
    var output: HistoryInteractorOutput? { get set }

}

protocol HistoryInteractorOutput: AnyObject {

}

class HistoryInteractor: HistoryInteractorInput {
    weak var output: HistoryInteractorOutput?
    
    var allItems: [String] = ["Машина", "Machine", "Remote", "Удаленный"]
    var filteredItems: [String] = []
    
    
}

extension HistoryInteractor {
    
}
