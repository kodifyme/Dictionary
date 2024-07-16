//
//  CoreDataService.swift
//  Dictionary
//
//  Created by KOДИ on 16.07.2024.
//

import UIKit
import CoreData

struct Keys {
    static let sourceTextKey = "sourceText"
    static let translatedTextKey = "translatedText"
}

class CoreDataService {
    
    static let shared = CoreDataService()
    let coreDataStack = CoreDataStack.shared
    
    private init() {}
    
    func saveTranslation(sourceText: String, translatedText: String) {
        let context = coreDataStack.context
        //FIXME: non force
        let entity = NSEntityDescription.entity(forEntityName: "TranslationEntity", in: context)!
        let translation = NSManagedObject(entity: entity, insertInto: context)
        translation.setValue(sourceText, forKey: Keys.sourceTextKey)
        translation.setValue(translatedText, forKey: Keys.translatedTextKey)
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchTranslations() -> [TranslationEntity] {
        do {
            let translations = try coreDataStack.context.fetch(TranslationEntity.fetchRequest())
            return translations
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
