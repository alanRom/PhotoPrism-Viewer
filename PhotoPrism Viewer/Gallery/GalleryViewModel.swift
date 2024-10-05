//
//  GalleryViewModel.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 9/26/24.
//

import SwiftUI

 

protocol GalleryViewModel {
    var images: [GalleryImage] { get  set}
    
    func fetchNextBatch(with sessionService: SessionService, offset: Int) async throws -> Void
}

