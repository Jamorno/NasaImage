//
//  MyListView.swift
//  NasaImage
//
//  Created by Jamorn Suttipong on 8/2/2568 BE.
//

import SwiftUI

struct MyListView: View {
    
    @ObservedObject var dataViewModel = NasaDataViewModel(context: PersistenceController.shared.container.viewContext)
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(dataViewModel.nasaData, id: \.self) {item in
                    DataRowView(nasaImage: item) {
                        dataViewModel.deletedData(data: item)
                    }
                    Divider()
                }
            }
            .padding()
        }
    }
}

#Preview {
    MyListView()
}
