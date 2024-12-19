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
    @State private var zoomAnchor: UnitPoint = .zero
    @State private var previousZoomScale: CGFloat = 1
    private let minZoomScale: CGFloat = 1
    private let maxZoomScale: CGFloat = 10
    let detailViewModel: DetailViewModel
    
    
    @State private var dragOffset: CGOffset = .zero
    @State private var previousDragOffset: CGOffset = .zero
     
    init(galleryImage: GalleryImage) {
        let vm = DetailViewModel(galleryImage: galleryImage)
        self.detailViewModel = vm
    }
    
    func onZoomGestureStarted(value: MagnifyGesture.Value) {
           withAnimation(.linear(duration: 0.1)) {
               let delta = value.magnification / previousZoomScale
               previousZoomScale = value.magnification
               let zoomDelta = zoomScale * delta
               var minMaxScale = max(minZoomScale, zoomDelta)
               minMaxScale = min(maxZoomScale, minMaxScale)
               zoomScale = minMaxScale
               zoomAnchor = value.startAnchor
           }
       }
    func resetImageState() {
            withAnimation(.linear(duration: 0.1)) {
                zoomScale = 1
            }
        }
       
    func onZoomGestureEnded(value: MagnifyGesture.Value) {
           previousZoomScale = 1
            zoomAnchor = .zero
            if zoomScale <= minZoomScale {
                   resetImageState()
            } else if zoomScale > maxZoomScale {
                zoomScale = maxZoomScale
            }
       }
    func onDoubleTapZoomIn() {
        withAnimation(.spring){
            if zoomScale < maxZoomScale {
                zoomScale = min(maxZoomScale, zoomScale * 4)
            } else {
                zoomScale = 1;
                dragOffset = .zero
            }
            
        }
    }
    
    var zoomGesture: some Gesture {
        MagnifyGesture()
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
                .placeholder() {
                    Image(systemName: "photo" )
                        .resizable()
                           .frame(width: 80)
                }
                    .cacheOriginalImage()
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: proxy.size.width * min(minZoomScale, zoomScale))
                    .position(proxy.frame(in: .local).center)
                    .offset(dragOffset)
                    .scaleEffect(zoomScale)
                    .onTapGesture(count: 2, perform: onDoubleTapZoomIn)
                    .gesture(
                        DragGesture()
                        .onChanged() { value in
                            withAnimation(.linear(duration: 0.1)) {
                                let rect = proxy.frame(in: .local)
                                    .inset(by: .init(top: proxy.size.height, left: proxy.size.width, bottom: proxy.size.height, right: proxy.size.width))
                                if rect.contains(value.location) {
                                    let steppedZoom : CGFloat =  zoomScale > maxZoomScale / 2 ? 0.15 : 0.4
                                    dragOffset =  previousDragOffset + CGSize(width: value.translation.width * steppedZoom, height: value.translation.height * steppedZoom)
                                }
                               
                            }
                        }
                        .onEnded(){ _ in
                            previousDragOffset = dragOffset
                        }
                        .simultaneously(with: zoomGesture))
                    
                 
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
        hdThumbnailUrl: URL(string: testUrl)!,
        takenOn: "2020-06-09T14:32:20Z",
        originalFileName: "HighResolution/1.jpg",
        title: "Test"
    ))
}
