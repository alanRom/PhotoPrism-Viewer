//
//  ContentView.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 9/26/24.
//

import SwiftUI
import Kingfisher



struct GalleryView: View {
    @Environment(SessionService.self) var sessionService: SessionService
    var galleryViewModel: GalleryViewModel
    
    private let aspectRatio: CGFloat = 1
    private let buffer = 10;
    

    @ViewBuilder
    var content: some View {
        if galleryViewModel.images.isEmpty {
                Text("No Images Found")
        } else {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 224), spacing: 0)], spacing: 0) {
                    ForEach(Array(zip(galleryViewModel.images.indices, galleryViewModel.images)), id: \.1) { index, galleryImage in
                        NavigationLink(value: galleryImage) {
                            GalleryImageView(image: galleryImage)
                        }
                        .onAppear(){
                            if galleryViewModel.images.count - buffer == index {
                                Task {
                                    do {
                                        try await galleryViewModel.fetchNextBatch(with: sessionService, offset: galleryViewModel.images.count)
                                    } catch {
                                        print(error)
                                    }
                                    
                                }
                            }
                        }
                        
                    }
                }
            }
        }
    }
    
    var body: some View {
            content
            .navigationDestination(for: GalleryImage.self) { galleryImage in
                DetailView(galleryImage: galleryImage)
            }
    }
}

struct GalleryImageView: View {
    let image: GalleryImage
    
    var body: some View {
        KFImage(image.thumbnailUrl )
            .placeholder() { Image(systemName: "photo" )}
            .resizable()
            .onFailure { error in
                print("Error: \(error)")
            }
            .fade(duration: 0.25)
    }
}

#Preview {
    @Previewable @State var sessionService = SessionService()
    let viewModel =  AllPhotosViewModel(with: sessionService, images: AllPhotosViewModel.createTestURLList())
    GalleryView(galleryViewModel: viewModel) 
        .environment(sessionService)
}
