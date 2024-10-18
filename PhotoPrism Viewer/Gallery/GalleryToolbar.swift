//
//  GalleryToolbar.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 10/15/24.
//

import SwiftUI

struct GalleryToolbar: View {
    @Binding var gallerySize: Double
    
    let toggleToolbar: () -> Void
    
    var smallPhoto: some View {
        Image(uiImage: UIImage(systemName: "photo")! )
    }

    @ViewBuilder
    var largePhoto: some View {
        let image = UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28))!
        Image(uiImage: image )
    }
    
    var photoSlider: some View {
        HStack {
            smallPhoto
            Slider(value: $gallerySize, in: 1...5, label: {
                Text("Size")
            })
            largePhoto
        }
    }
    
    var toggleToolbarButton: some View {
        Button(){
            toggleToolbar()
        } label: {
            Image(systemName: "menubar.arrow.up.rectangle")
        }
    }

    var body: some View {
        HStack {
            photoSlider
        }
    }
    
}

#Preview {
    @Previewable @State var gallerySize = 5.0
    GalleryToolbar(gallerySize: $gallerySize){
        
    }
}
