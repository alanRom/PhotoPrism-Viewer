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
    let detailViewModel: DetailViewModel
    
    
    @State private var dragOffset: CGOffset = .zero
    @State private var previousDragOffset: CGOffset = .zero
     
    init(galleryImage: GalleryImage) {
        let vm = DetailViewModel(galleryImage: galleryImage)
        self.detailViewModel = vm
    }
    
    func onZoomGestureStarted(value: MagnificationGesture.Value) {
           withAnimation(.linear(duration: 0.1)) {
               let delta = value / previousZoomScale
               previousZoomScale = value
               let zoomDelta = zoomScale * delta
               var minMaxScale = max(minZoomScale, zoomDelta)
               minMaxScale = min(maxZoomScale, minMaxScale)
               zoomScale = minMaxScale
           }
       }
    func resetImageState() {
            withAnimation(.linear(duration: 0.1)) {
                zoomScale = 1
            }
        }
       
    func onZoomGestureEnded(value: MagnificationGesture.Value) {
           previousZoomScale = 1
        if zoomScale <= minZoomScale {
               resetImageState()
        } else if zoomScale > maxZoomScale {
            zoomScale = maxZoomScale
           }
       }
    
    var zoomGesture: some Gesture {
            MagnificationGesture()
                .onChanged(onZoomGestureStarted)
                .onEnded(onZoomGestureEnded)
        }
    var saveImageButton: some View {
        Button {
            detailViewModel.downloadImage()
        } label: {
            if detailViewModel.isImageSaved {
                Label("Save Photo", systemImage: "arrow.down.circle.fill")
            } else {
                Label("Save Photo", systemImage: "arrow.down.circle")
                
            }
            
        }
        
    }
    
 
    var content: some View {
        
        GeometryReader { proxy in
 
            KFImage(detailViewModel.galleryImage.url)
                    .placeholder() { Image(systemName: "photo" )}
                    .cacheOriginalImage()
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .gesture(
                        DragGesture()
                        .onChanged() { value in
                            withAnimation(.linear(duration: 0.1)) {
                                let rect = proxy.frame(in: .local)
                                    .inset(by: .init(top: proxy.size.height, left: proxy.size.width, bottom: proxy.size.height, right: proxy.size.width))
                                if rect.contains(value.location) {
                                    dragOffset =  previousDragOffset + CGSize(width: value.translation.width * zoomScale, height: value.translation.height * zoomScale)
                                }
                               
                            }
                        }
                        .onEnded(){ _ in
                            previousDragOffset = dragOffset
                        }
                        .simultaneously(with: zoomGesture))
                    .frame(width: proxy.size.width * min(minZoomScale, zoomScale))
                    .scaleEffect(zoomScale)
                    .offset(dragOffset)
                    .position(proxy.frame(in: .local).center)
                 
        }
    }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            content
                .navigationTitle(detailViewModel.galleryImage.name)
                .toolbar {
                    saveImageButton
                }
        }
    }
        
}

#Preview {
    let testUrl = "https://raw.githubusercontent.com/onevcat/Kingfisher-TestImages/master/DemoAppImage/HighResolution/1.jpg"
    DetailView(galleryImage: GalleryImage(
        url: URL(string: testUrl)!,
        name: "1.jpg", hash: "",
        thumbnailUrl: URL(string: testUrl)!,
        takenOn: "2020-06-09T14:32:20Z",
        originalFileName: "HighResolution/1.jpg",
        title: "Test"
    ))
}
