//
//  ContentView.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 9/26/24.
//

import SwiftUI
import Kingfisher

struct GalleryView: View {
    @EnvironmentObject var sessionService: SessionService
    @ObservedObject var galleryViewModel: GalleryViewModel
    @State private var showingLoginSheet = false
    
    private let aspectRatio: CGFloat = 1
    
    func closeLogin() {
        showingLoginSheet = false
    }
    
    @ViewBuilder
    var content: some View {
        if galleryViewModel.imagePaths.isEmpty {
                Text("No Images Found")
        } else {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 224), spacing: 0)], spacing: 0) {
                    ForEach(galleryViewModel.imagePaths) { galleryImage in
                        NavigationLink(value: galleryImage) {
                            KFImage(galleryImage.thumbnailUrl )
                                .placeholder() { Image(systemName: "photo" )}
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
            }
        }
    }
    
    var body: some View {
        
        NavigationStack {
            content
            .navigationDestination(for: GalleryImage.self) { galleryImage in
                DetailView(galleryImage: galleryImage)
            }
            .onAppear(){
                if sessionService.activeSession == nil {
                    showingLoginSheet = true
                } else {
                    Task {
                        do {
                            try await galleryViewModel.fetchImageList(with: sessionService)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            .sheet(isPresented: $showingLoginSheet){
                LoginView(closeLogin: closeLogin)
                    .environmentObject(sessionService)
                    .onDisappear(){
                        if sessionService.activeSession != nil {
                            showingLoginSheet = false
                            Task {
                                try await galleryViewModel.fetchImageList(with: sessionService)
                            }
                            
                        }
                    }
            }
        }
        
        
    }
}

#Preview {
    GalleryView(galleryViewModel: GalleryViewModel())
}
