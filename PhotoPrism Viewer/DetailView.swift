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
    typealias CGOffset = CGSize
    
    @State private var zoomScale: CGFloat = 1
    @State private var previousZoomScale: CGFloat = 1
    private let minZoomScale: CGFloat = 1
    private let maxZoomScale: CGFloat = 5
    
    @State private var dragOffset: CGOffset = .zero
    
    func onDragGestureStarted(value: DragGesture.Value) {
           withAnimation(.easeIn(duration: 0.1)) {
               dragOffset =  CGSize(width: value.translation.width * zoomScale, height: value.translation.height * zoomScale)
           }
       }

       // Declare the `DragGesture` object, and assign the drag changed
       // behaviour above.
   var panGesture: some Gesture {
       DragGesture()
           .onChanged(onDragGestureStarted)
   }
    
    func onZoomGestureStarted(value: MagnificationGesture.Value) {
           withAnimation(.easeIn(duration: 0.1)) {
               let delta = value / previousZoomScale
               previousZoomScale = value
               let zoomDelta = zoomScale * delta
               var minMaxScale = max(minZoomScale, zoomDelta)
               minMaxScale = min(maxZoomScale, minMaxScale)
               zoomScale = minMaxScale
           }
       }
    func resetImageState() {
            withAnimation(.interactiveSpring()) {
                zoomScale = 1
            }
        }
       
    func onZoomGestureEnded(value: MagnificationGesture.Value) {
           previousZoomScale = 1
           if zoomScale <= 1 {
               resetImageState()
           } else if zoomScale > 5 {
               zoomScale = 5
           }
       }
    
    var zoomGesture: some Gesture {
            MagnificationGesture()
                .onChanged(onZoomGestureStarted)
                .onEnded(onZoomGestureEnded)
        }
    
   
    
    func onDoubleTapZoomIn() {
        withAnimation(.spring){
            if zoomScale < maxZoomScale {
                zoomScale = min(maxZoomScale, zoomScale * 3)
            } else {
                zoomScale = 1;
                dragOffset = .zero
            }
            
        }
    }
    
    let galleryImage: GalleryImage
    var content: some View {
        
        GeometryReader { proxy in
//            ScrollView(
//                [.vertical, .horizontal],
//                showsIndicators: false
//            ) {
                KFImage(galleryImage.url)
                    .cacheOriginalImage()
                    .resizable()
                    .aspectRatio(contentMode: .fit)
//                    .onTapGesture(count: 2, perform: onDoubleTapZoomIn)
                    .gesture(panGesture.simultaneously(with: zoomGesture))
                    .frame(width: proxy.size.width * min(minZoomScale, zoomScale))
                    .scaleEffect(zoomScale)
                    .offset(dragOffset)
                    
//            }
            
        }
    }
    
    var body: some View {
            Color.black
                .ignoresSafeArea()
                .overlay(content)
                 
    }
        
}

#Preview {
    let testUrl = "https://raw.githubusercontent.com/onevcat/Kingfisher-TestImages/master/DemoAppImage/HighResolution/1.jpg"
    DetailView(galleryImage: GalleryImage(url: URL(string: testUrl)!,name: "1.jpg"))
}
