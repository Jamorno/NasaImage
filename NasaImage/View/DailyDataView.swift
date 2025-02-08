//
//  DailyDataView.swift
//  NasaImage
//
//  Created by Jamorn Suttipong on 8/2/2568 BE.
//

import SwiftUI

struct DailyDataView: View {
    
    @ObservedObject var viewModel = ImageViewModel()
    @ObservedObject var dataViewModel: NasaDataViewModel
    
    @State private var hasData: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            if hasData {
                if let imageUrl = viewModel.image?.hdurl,
                    let url = URL(string: imageUrl) {
                    AsyncImage(url: url) {phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                        case .failure:
                            Text("Falied to load image")
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Text("No image available")
                }
                
                VStack(alignment: .leading) {
                    Text(viewModel.image?.title ?? "No title")
                    Text("Date: \(viewModel.image?.date ?? "No date")")
                    
                    Divider()
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        Text(viewModel.image?.explanation ?? "No explanation")
                            .foregroundStyle(.gray)
                    }
                }
                .font(.headline)
                .foregroundStyle(.black)
                .padding(.vertical)
                
            } else {
                Text("Press 'GET DATA' to load today's data")
                    .font(.headline)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            HStack {
                //get data button
                Button {
                    Task {
                        await viewModel.fetchImage()
                        hasData = true
                    }
                } label: {
                    Text("GET DATA")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.pink)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                }
                
                //save to list
                Button {
                    dataViewModel.addNasaData(title: dataViewModel.title, date: dataViewModel.date, url: dataViewModel.url, explanation: dataViewModel.explanation)
                } label: {
                    Image(systemName: "square.and.arrow.down.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 26, height: 26)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
        }
        .animation(.easeInOut, value: hasData)
        .padding()
    }
}

#Preview {
    DailyDataView(dataViewModel: NasaDataViewModel(context: PersistenceController.shared.container.viewContext))
}
