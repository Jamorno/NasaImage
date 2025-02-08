//
//  NasaService.swift
//  NasaImage
//
//  Created by Jamorn Suttipong on 7/2/2568 BE.
//

import Foundation

class NasaService {
    
    lazy var apiKey: String = getApiKey()
    
    //get api key
    func getApiKey() -> String {
        if let url = Bundle.main.url(forResource: "apiKey", withExtension: "plist"),
           let data = try? Data(contentsOf: url),
           let plist = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any] {
            return plist["apiKey"] as? String ?? ""
        }
        return ""
    }
    
    //fetch image
    func fetchImage() async throws -> ImageModel {
        let urlString = "https://api.nasa.gov/planetary/apod?api_key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: 400, userInfo: nil)
        }
        
        let(data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NSError(domain: "Invalid response", code: 500, userInfo: nil)
        }
        
        let image = try JSONDecoder().decode(ImageModel.self, from: data)
        return image
    }
}
