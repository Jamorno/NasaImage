//
//  DataRowView.swift
//  NasaImage
//
//  Created by Jamorn Suttipong on 8/2/2568 BE.
//

import SwiftUI

struct DataRowView: View {
    
    let nasaImage: NasaImage
    let onDeleted: () -> Void
    
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack {
            //image
            if let imageUrl = nasaImage.url, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { image in
                    switch image {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                    case .failure:
                        Text("Falied to load image")
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Text("No image unavailable")
            }
            
            //detail
            VStack(alignment: .leading) {
                HStack {
                    //title and date
                    VStack(alignment: .leading) {
                        Text(nasaImage.title ?? "")
                        Text("Date: \(nasaImage.date ?? "")")
                    }
                    
                    Spacer()
                    
                    //deleted button
                    Button {
                        onDeleted()
                    } label: {
                        Image(systemName: "trash.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                            .foregroundStyle(.pink)
                    }
                }
                
                //show explain
                if isExpanded {
                    Text("Show details \(nasaImage.explanation ?? "No explanation")")
                        .font(.caption)
                        .transition(.opacity)
                }
                
                Button {
                    withAnimation {
                        isExpanded.toggle()
                    }
                } label: {
                    Text(isExpanded ? "Hide detail" : "Show detail")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
            }
        }
        .font(.headline)
        .foregroundStyle(.black)
    }
}

#Preview {
    DataRowView(nasaImage: NasaImage.preview) {
        print("DEBUG: Delete button tapped in Preview")
    }
}

extension NasaImage {
    static var preview: NasaImage {
        let context = PersistenceController.shared.container.viewContext
        let data = NasaImage(context: context)
        data.title = "Test Title"
        data.date = "Test Date"
        data.explanation = "Test Explanation"
        
        return data
    }
}
