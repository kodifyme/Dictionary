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
    
    enum CodingKeys: String, CodingKey {
        case sourceLanguageCode, targetLanguageCode, format, texts
        case folderID = "folderId"
    }
}

struct TranslationResponse: Codable {
    let translations: [Translation]
}

struct Translation: Codable {
    let text: String
}