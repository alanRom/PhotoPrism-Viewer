//
//  GalleryModel.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 9/26/24.
//

import Foundation

struct Gallery {
    var imageLocations: [GalleryImage]
      
    
    struct GalleryImage: Identifiable {
        let url: URL
        var id: String { url.absoluteString }
    }
}
