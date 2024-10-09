//
//  SettingsView.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 10/4/24.
//

import SwiftUI
import Kingfisher


struct SettingsView: View {
    @AppStorage("thumbnailQuality") var thumbnailQuality: Int = 2
    @State private var isEditing = false
    let userThumb: String
    let displayName: String
    let serverURL: String
    let logout: () -> Void

    @ViewBuilder
    var userThumbnailImage: some View {
        let configuration = UIImage.SymbolConfiguration(pointSize: 200)
        let image = UIImage(systemName: "person.crop.circle", withConfiguration: configuration)!
        if userThumb != "", let userThumbURL = URL(string: userThumb) {
            KFImage.url(userThumbURL)
                .placeholder() { Image(uiImage: image) }
                    .cacheOriginalImage()
//                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
        } else {
            Image(uiImage: image)
        }
    }
    var serverURLView: some View {
        Text("Connected to \(serverURL)")
            .font(.system(.footnote))
            .foregroundStyle(.gray)
    }
    
    @ViewBuilder
    var userThumbnailView: some View {
        userThumbnailImage
            .frame(minWidth: 100, idealWidth: 224, maxWidth: 224, minHeight: 100, idealHeight: 224, maxHeight: 224)
        Text(displayName)
            .font(.system(.title))
            
        
    }
    


    var body: some View {
        VStack {
            
            
            userThumbnailView
    
            serverURLView
            
            Divider()
            
            Button {
                logout()
            } label: {
                Label("Log Out", systemImage: "rectangle.portrait.and.arrow.right")
            }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .controlSize(.large)
            
        }
        .padding(20)
    }
     
}

#Preview {
    SettingsView(userThumb: "", displayName: "User", serverURL: "https://test.com") {
        
    }
    
}
