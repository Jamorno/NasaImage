//
//  NasaDataViewModel.swift
//  NasaImage
//
//  Created by Jamorn Suttipong on 8/2/2568 BE.
//

import Foundation
import CoreData

class NasaDataViewModel: ObservableObject {
    
    @Published var nasaData: [NasaImage] = []
    
    //for add new nasa data
    @Published var title: String = ""
    @Published var date: String = ""
    @Published var url: String = ""
    @Published var explanation: String = ""
    
    private let viewContext: NSManagedObjectContext
    init(context: NSManagedObjectContext) {
        self.viewContext = context
        fetchNasaData()
    }
    
    func fetchNasaData() {
        let request: NSFetchRequest<NasaImage> = NasaImage.fetchRequest()
        
        do {
            nasaData = try viewContext.fetch(request)
        } catch {
            print("DEBUG: Failed to fetch data: \(error.localizedDescription)")
        }
    }
    
    func addNasaData(title: String, date: String, url: String, explanation: String) {
        let newData = NasaImage(context: viewContext)
        newData.title = title
        newData.date = date
        newData.url = url
        newData.explanation = explanation
        
        saveContext()
        fetchNasaData()
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
            fetchNasaData()
        } catch {
            print("DEBUG: Failed to save context: \(error)")
        }
    }
    
    func deletedData(data: NasaImage) {
        viewContext.delete(data)
        saveContext()
        fetchNasaData()
    }
}
