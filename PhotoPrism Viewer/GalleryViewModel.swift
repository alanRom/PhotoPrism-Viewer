//
//  GalleryViewModel.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 9/26/24.
//

import SwiftUI

class GalleryViewModel: ObservableObject {
    @Published private var gallery: Gallery
    typealias GalleryImage = Gallery.GalleryImage;
    
    init() {
        self.gallery = GalleryViewModel.createTestURLList();
    }
    
    var imagePaths: [GalleryImage] {
        gallery.imageLocations
    }
    
    private static func createTestURLList() -> Gallery {
        var imageLocations: [GalleryImage] = [];
//        "https://raw.githubusercontent.com/onevcat/Kingfisher-TestImages/master/DemoAppImage/Loading/kingfisher"
        let urlPrefix = "https://raw.githubusercontent.com/onevcat/Kingfisher-TestImages/master/DemoAppImage/HighResolution"
        for index in 0..<21{
            imageLocations.append(GalleryImage(url: URL(string: "\(urlPrefix)/\(index + 1).jpg")!));
        }
        
        return Gallery(imageLocations: imageLocations)
    }
    
}

