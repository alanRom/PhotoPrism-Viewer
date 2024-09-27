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
    @State private var zoomScale: CGFloat = 1
    @State private var previousZoomScale: CGFloat = 1
    private let minZoomScale: CGFloat = 1
    private let maxZoomScale: CGFloat = 5
    
    func resetImageZoom() {
        withAnimation(.interactiveSpring){
            zoomScale = 1;
        }
    }
    
    func zoomIn() {
        withAnimation(.interactiveSpring()){
            if zoomScale < maxZoomScale {
                zoomScale = min(maxZoomScale, zoomScale * 3)
            } else {
                zoomScale = 1;
            }
            
        }
    }
    
    let galleryImage: GalleryImage
    var content: some View {
       
            KFImage(galleryImage.url)
                .cacheOriginalImage()
                .resizable()
                .aspectRatio(contentMode: .fit)
                
        
    }
    
    var body: some View {
        GeometryReader { proxy in
            Color.black
                .ignoresSafeArea()
                .overlay(content)
                .onTapGesture(count: 2, perform: zoomIn)
                .frame(width: proxy.size.width * max(minZoomScale, zoomScale))
                .frame(maxHeight: .infinity)
        }
    }
        
}

#Preview {
    let testUrl = "https://raw.githubusercontent.com/onevcat/Kingfisher-TestImages/master/DemoAppImage/HighResolution/1.jpg"
    DetailView(galleryImage: GalleryImage(url: URL(string: testUrl)!,name: "1.jpg"))
}
