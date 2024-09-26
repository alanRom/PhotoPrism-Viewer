//
//  GalleryViewModel.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 9/26/24.
//

import SwiftUI

class GalleryViewModel: ObservableObject {
    @Published private var gallery: Gallery
    
    init(gallery: Gallery) {
        self.gallery = gallery
    }
    
    var imagePaths: [URL] {
        gallery.imageLocations
    }
    
}

