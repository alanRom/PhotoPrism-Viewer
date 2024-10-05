//
//  AllPhotosViewModel.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 10/3/24.
//

import SwiftUI

@MainActor
@Observable
class AllPhotosViewModel: @preconcurrency GalleryViewModel {
 
    let sessionService: SessionService
    var images: [GalleryImage]
    
    typealias GalleryImage = Gallery.GalleryImage;
    
    init(with sessionService: SessionService, images: [GalleryImage] = []) {
        self.sessionService = sessionService
        self.images = images
        Task {
            do {
                try await fetchImageList(with: self.sessionService)
            } catch {
                print(error)
            }
        }
    }
     
    
    static func createTestURLList() -> [GalleryImage] {
        var imageLocations: [GalleryImage] = [];
//        "https://raw.githubusercontent.com/onevcat/Kingfisher-TestImages/master/DemoAppImage/Loading/kingfisher"
        let urlPrefix = "https://raw.githubusercontent.com/onevcat/Kingfisher-TestImages/master/DemoAppImage/HighResolution"
        for index in 0..<20{
            let name = "\(index + 1).jpg"
            imageLocations.append(GalleryImage(
                url: URL(string: "\(urlPrefix)/\(name)")!,
                name: name, hash: String(index),
                thumbnailUrl: URL(string: "\(urlPrefix)/\(name)")!,
                takenOn: "2020-06-09T14:32:20Z",
                originalFileName: "HighResolution/\(name)",
                title: "Test\(index)"
            )
            );
        }
        
        return imageLocations
    }
    
    func fetchNextBatch(with sessionService: SessionService, offset: Int ) async throws -> Void {
        try await fetchImageList(with: sessionService, offset: offset)
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
                self.images.append(GalleryImage(
                    url: URL(string: rawURL)!,
                    name: name, hash: hash,
                    thumbnailUrl: URL(string: thumbnailURL)!,
                    takenOn: photoResponse.TakenAt,
                    originalFileName: photoResponse.OriginalName,
                    title: photoResponse.Title
                ))
            }
            
        }
    }
}
