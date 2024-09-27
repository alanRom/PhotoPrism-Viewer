//
//  ContentView.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 9/26/24.
//

import SwiftUI
import Kingfisher

struct GalleryView: View {
    @ObservedObject var galleryViewModel: GalleryViewModel 
    private let aspectRatio: CGFloat = 1
    
    var body: some View {
        AspectVGrid(galleryViewModel.imagePaths, aspectRatio: aspectRatio){galleryImage in
                KFImage(galleryImage.url)
                    .resizable()
                    .onSuccess { result in
                        print("Image loaded from cache: \(result.cacheType)")
                    }
                    .onFailure { error in
                        print("Error: \(error)")
                    }
                    .fade(duration: 0.25) 
        }
    }
}

#Preview {
    GalleryView(galleryViewModel: GalleryViewModel())
}
