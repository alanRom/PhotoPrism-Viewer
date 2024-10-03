//
//  GalleryViewModel.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 9/26/24.
//

import SwiftUI

@MainActor
@Observable
class GalleryViewModel {
    let sessionService: SessionService
    var gallery: Gallery
    typealias GalleryImage = Gallery.GalleryImage;
    
    init(with sessionService: SessionService) {
        self.sessionService = sessionService
        self.gallery = Gallery(imageLocations: [])
        
        Task {
            do {
                try await fetchImageList(with: self.sessionService)
            } catch {
                print(error)
            }
        }
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
            imageLocations.append(GalleryImage(url: URL(string: "\(urlPrefix)/\(name)")!, name: name, hash: String(index), thumbnailUrl: URL(string: "\(urlPrefix)/\(name)")!));
        }
        
        return Gallery(imageLocations: imageLocations)
    }
    
    func fetchImageList(with sessionService: SessionService, offset:Int = 0,  count:Int = 100, quality: Int = 2) async throws -> Void {
        
        if let activeSession = sessionService.activeSession {
            let accessToken = activeSession.accessToken
            let previewToken = activeSession.previewToken
            let downloadToken = activeSession.downloadToken
            
            //Fetch Photos List
            let baseURL = activeSession.baseUrl
            let url =  "\(baseURL)/api/v1/photos?count=\(count)&quality=\(quality)&offset=\(offset)&public=true"
        
            guard let validURL = URL(string: url) else { throw APIError.invalidURL }
            var request = URLRequest(url:  validURL)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(accessToken, forHTTPHeaderField: "X-Auth-Token")
            print(url, accessToken)
        
        
            let (data, _) =  try await URLSession.shared.data(for: request)
            
//            if let prettyJSON = data.prettyPrintedJSONString {
//                print(prettyJSON)
//            }
            
              
            let decodedData = try JSONDecoder().decode([PhotosResponseModel].self, from: data)
            
            
            //Format photos into GalleryImages
            // - Create thumbnail and raw image URLs programatically
            for photoResponse in decodedData {
                let hash = photoResponse.Hash
                let name = photoResponse.Name
//                let fileName = photoResponse.FileName
                let thumbnailSize = "tile_224"
                let thumbnailURL = "\(baseURL)/api/v1/t/\(hash)/\(previewToken)/\(thumbnailSize)"
                let rawURL = "\(baseURL)/api/v1/dl/\(hash)?t=\(downloadToken)"
                self.gallery.imageLocations.append(GalleryImage(url: URL(string: rawURL)!, name: name, hash: hash, thumbnailUrl: URL(string: thumbnailURL)!))
            }
            
        }
    }
    
}

