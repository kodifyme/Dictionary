//
//  TranslateEntity.swift
//  Dictionary
//
//  Created by KOДИ on 30.06.2024.
//

import UIKit

struct TranslationRequest: Codable {
    let sourceLanguageCode: String?
    let targetLanguageCode: String
    let format: String
    let texts: [String]
    let folderID: String?
}

struct TranslationResponse: Codable {
    let translations: [Translation]
}

struct Translation: Codable {
    let text: String
}

struct Language {
    let name: String
    let code: String
}

let languages = [
    Language(name: "Russian", code: "ru"),
    Language(name: "English", code: "en"),
    Language(name: "Spanish", code: "es")
]
