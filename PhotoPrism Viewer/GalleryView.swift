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
    
    var body: some View {
        
        
        NavigationStack {
            AspectVGrid(galleryViewModel.imagePaths, aspectRatio: aspectRatio){galleryImage in
                NavigationLink(value: galleryImage) {
                    KFImage(galleryImage.url)
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
            .navigationDestination(for: GalleryImage.self) { galleryImage in
                DetailView(galleryImage: galleryImage)
            }
            .onAppear(){
                if sessionService.activeSession == nil {
                    showingLoginSheet = true
                }
            }
            
            .sheet(isPresented: $showingLoginSheet){
                LoginView(closeLogin: closeLogin)
                    .environmentObject(sessionService)
                    .onDisappear(){
                        if sessionService.activeSession != nil {
                            showingLoginSheet = false
                        }
                    }
            }
        }
        
        
    }
}

#Preview {
    GalleryView(galleryViewModel: GalleryViewModel())
}
