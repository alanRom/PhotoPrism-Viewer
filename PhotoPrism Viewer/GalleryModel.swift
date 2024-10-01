//
//  GalleryModel.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 9/26/24.
//

import Foundation

struct Gallery {
    var imageLocations: [GalleryImage]
      
    
    struct GalleryImage: Identifiable, Hashable {
        let url: URL
        let name: String
        var id: String { hash }
        let hash: String;
        
        let thumbnailUrl: URL;
    }
}
