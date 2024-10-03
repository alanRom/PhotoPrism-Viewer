//
//  PhotoPrism_ViewerApp.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 9/26/24.
//

import SwiftUI

@main
struct PhotoPrism_ViewerApp: App {
    @State var sessionService = SessionService()
   
    
    var body: some Scene {
        
        WindowGroup {
//            if sessionService.activeSession != nil {
            let galleryViewModel = GalleryViewModel(with: sessionService)
                GalleryView(galleryViewModel: galleryViewModel)
                    .environment(sessionService)
//            } else {
//                LoginView()
//                    .environmentObject(sessionService)
//            }
            

            
        }
    }
}
