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
    
    @State var galleryImageSize = 3.0
    @State var showToolbar = true
    
    private let aspectRatio: CGFloat = 1
    private let buffer = 10;
    
    func toggleToolbar() -> Void {
        withAnimation(){
            showToolbar = !showToolbar
        }
    }
    

    @ViewBuilder
    var content: some View {
        
        if galleryViewModel.isInitiallyLoading {
            ProgressView()
                .scaleEffect(2)
        }
        else if galleryViewModel.images.isEmpty {
                Text("No Images Found")
        } else {
            VStack{
                GalleryToolbar(gallerySize: $galleryImageSize, toggleToolbar: toggleToolbar)
                GeometryReader { proxy in
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: proxy.size.width * (galleryImageSize/5)), spacing: 0)], spacing: 0) {
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
            
            
        }
    }
    
    var body: some View {
        VStack{
            
            content
            .navigationDestination(for: GalleryImage.self) { galleryImage in
                DetailView(galleryImage: galleryImage)
            }
        }
           
    }
}



struct GalleryImageView: View {
    let image: GalleryImage
    
    var body: some View {
        KFImage(image.hdThumbnailUrl )
            .placeholder() {
                let image = UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(pointSize: 128))!
                Image(uiImage: image )}
            .resizable()
            .onFailure { error in
                print("Error: \(error)")
            }
            .fade(duration: 0.25)
            .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    @Previewable @State var sessionService = SessionService()
    let viewModel =  AllPhotosViewModel(with: sessionService, images: AllPhotosViewModel.createTestURLList())
    GalleryView(galleryViewModel: viewModel) 
        .environment(sessionService)
}
