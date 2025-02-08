//
//  MainTabView.swift
//  NasaImage
//
//  Created by Jamorn Suttipong on 7/2/2568 BE.
//

import SwiftUI

struct MainTabView: View {
    
    @ObservedObject var dataViewModel = NasaDataViewModel(context: PersistenceController.shared.container.viewContext)
    
    var body: some View {
        TabView {
            DailyDataView(dataViewModel: dataViewModel)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            MyListView(dataViewModel: dataViewModel)
                .tabItem {
                    Label("My List", systemImage: "list.bullet")
                }
        }
        .tint(.pink)
    }
}

#Preview {
    MainTabView()
}
