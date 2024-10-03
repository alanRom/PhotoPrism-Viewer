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
        if galleryViewModel.imagePaths.isEmpty {
                Text("No Images Found")
        } else {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 224), spacing: 0)], spacing: 0) {
                    ForEach(Array(zip(galleryViewModel.imagePaths.indices, galleryViewModel.imagePaths)), id: \.1) { index, galleryImage in
                        NavigationLink(value: galleryImage) {
                            KFImage(galleryImage.thumbnailUrl )
                                .placeholder() { Image(systemName: "photo" )}
                                .resizable()
                                .onFailure { error in
                                    print("Error: \(error)")
                                }
                                .fade(duration: 0.25)
                                
                        }
                        .onAppear(){
                            if galleryViewModel.imagePaths.count - buffer == index {
                                Task {
                                    do {
                                        try await galleryViewModel.fetchImageList(with: sessionService, offset: galleryViewModel.imagePaths.count)
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

#Preview {
    @Previewable @State var sessionService = SessionService()
    GalleryView(galleryViewModel: GalleryViewModel(with: sessionService))
        .environment(sessionService)
}
