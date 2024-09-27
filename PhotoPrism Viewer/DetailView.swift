//
//  DetailView.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 9/27/24.
//

import SwiftUI
import Kingfisher
typealias GalleryImage = Gallery.GalleryImage

struct DetailView: View {
    let galleryImage: GalleryImage
    var content: some View {
        KFImage(galleryImage.url)
            .cacheOriginalImage()
            .resizable()
            .scaledToFit()
    }
    
    var body: some View {
        Color.black
            .ignoresSafeArea()
            .overlay(content)
    }
        
}

#Preview {
    let testUrl = "https://raw.githubusercontent.com/onevcat/Kingfisher-TestImages/master/DemoAppImage/HighResolution/1.jpg"
    DetailView(galleryImage: GalleryImage(url: URL(string: testUrl)!))
}
