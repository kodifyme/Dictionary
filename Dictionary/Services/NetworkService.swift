//
//  NetworkService.swift
//  Dictionary
//
//  Created by KOДИ on 30.06.2024.
//

import UIKit

class NetworkService {
    //Идентификатор ключа: ajeha0bf8pv9198r1lvq
    
//    Ваш секретный ключ:
//    AQVN0VAW9GfpClGw1_oxyHbD0DgqTyxTHxvIOS-x

    
    private let apiKey = "AQVN0VAW9GfpClGw1_oxyHbD0DgqTyxTHxvIOS-x"
    private let baseURL = "https://translate.api.cloud.yandex.net/translate/v2/translate"
    
    func fetchTranslation(for text: String, from sourceLanguage: String?, to targetLanguage: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        let translationRequest = TranslationRequest(
            sourceLanguageCode: sourceLanguage,
            targetLanguageCode: targetLanguage,
            format: "PLAIN_TEXT",
            texts: [text],
            folderID: "b1gt5798gsiq4fm29lhc"
        )
        
        guard let url = URL(string: baseURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Api-Key \(apiKey)", forHTTPHeaderField: "Authorization")

        do {
            let jsonData = try JSONEncoder().encode(translationRequest)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
                if httpResponse.statusCode == 403 {
                    completion(.failure(NSError(domain: "Permission denied", code: 403, userInfo: nil)))
                    return
                }
            }
            
            let responseDataString = String(data: data, encoding: .utf8)
            print("Response Data: \(responseDataString ?? "No response data")")
            
            do {
                let translationResponse = try JSONDecoder().decode(TranslationResponse.self, from: data)
                if let translation = translationResponse.translations.first?.text {
                    completion(.success(translation))
                } else {
                    completion(.failure(NSError(domain: "Invalid response format", code: -1, userInfo: nil)))
                }
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

