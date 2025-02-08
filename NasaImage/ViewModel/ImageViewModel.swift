//
//  ImageViewModel.swift
//  NasaImage
//
//  Created by Jamorn Suttipong on 7/2/2568 BE.
//

import Foundation
import CoreData

class ImageViewModel: ObservableObject {
    
    @Published var image: ImageModel?
    
    private let service = NasaService()
    
    func fetchImage() async {
        Task { @MainActor in
            do {
                let fetchedImage = try await service.fetchImage()
                self.image = fetchedImage
            } catch {
                print("DEBUG: Failed to fetch image \(error.localizedDescription)")
            }
        }
    }
}
