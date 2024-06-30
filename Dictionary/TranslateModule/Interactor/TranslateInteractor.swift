//
//  TranslateInteractor.swift
//  Dictionary
//
//  Created by KOДИ on 17.06.2024.
//

import UIKit

protocol TranslateInteractorInput {
    var output: TranslateInteractorOutput? { get set }
}

protocol TranslateInteractorOutput: AnyObject {
    
}

final class TranslateInteractor: TranslateInteractorInput {
    weak var output: TranslateInteractorOutput?
    
    
    
}
