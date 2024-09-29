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
        self.gallery = Gallery(imageLocations: [])
    }
    
    var imagePaths: [GalleryImage] {
        gallery.imageLocations
    }
    
    private static func createTestURLList() -> Gallery {
        var imageLocations: [GalleryImage] = [];
//        "https://raw.githubusercontent.com/onevcat/Kingfisher-TestImages/master/DemoAppImage/Loading/kingfisher"
        let urlPrefix = "https://raw.githubusercontent.com/onevcat/Kingfisher-TestImages/master/DemoAppImage/HighResolution"
        for index in 0..<21{
            let name = "\(index + 1).jpg"
            imageLocations.append(GalleryImage(url: URL(string: "\(urlPrefix)/\(name)")!, name: name, hash: String(index)));
        }
        
        return Gallery(imageLocations: imageLocations)
    }
    
    func fetchImageList(with sessionService: SessionService) async throws -> Void {
        
        if let activeSession = sessionService.activeSession {
            let accessToken = activeSession.accessToken
            
            //Fetch Photos List
            let baseURL = activeSession.baseUrl
            let url =  "\(baseURL)/api/v1/photos"
        
            guard let validURL = URL(string: url) else { throw APIError.invalidURL }
            var request = URLRequest(url:  validURL)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(accessToken, forHTTPHeaderField: "X-Auth-Token")
        
        
            let (data, _) =  try await URLSession.shared.data(for: request)
            
            let decodedData = try JSONDecoder().decode([PhotosResponseModel].self, from: data)
        
            //Format photos into GalleryImages
            // - Create thumbnail and raw image URLs programatically
            
        }
    }
    
}

