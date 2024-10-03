//
//  AllPhotosView.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 10/3/24.
//

import SwiftUI

struct AllPhotosView: View {
    @Environment(SessionService.self) var sessionService: SessionService
    var galleryViewModel: AllPhotosViewModel
    
    var body: some View {
        GalleryView(galleryViewModel: galleryViewModel)
    }
}

#Preview {
@Previewable @State var sessionService = SessionService()
let viewModel =  AllPhotosViewModel(with: sessionService, images: AllPhotosViewModel.createTestURLList())
GalleryView(galleryViewModel: viewModel)
    .environment(sessionService)
}
