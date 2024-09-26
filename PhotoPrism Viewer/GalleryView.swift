//
//  ContentView.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 9/26/24.
//

import SwiftUI
import Kingfisher

struct GalleryView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .onAppear() {
                    print(KingfisherManager.shared)
                }
        }
        .padding()
    }
}

#Preview {
    GalleryView()
}
