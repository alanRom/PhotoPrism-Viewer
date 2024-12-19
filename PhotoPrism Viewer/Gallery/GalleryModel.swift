//
//  GalleryModel.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 9/26/24.
//

import Foundation


struct Gallery {
    var imageLocations: [GalleryImage]
      
    
    struct GalleryImage: Identifiable, Hashable {
        let url: URL
        let name: String
        var id: String { hash }
        let hash: String;
        let thumbnailUrl: URL;
        let hdThumbnailUrl: URL;
        let takenOn: Date?;
        let originalFileName: String;
        let title: String;
        static private var dateFormatter: DateFormatter?
        
        init(url: URL, name: String, hash: String, thumbnailUrl: URL, hdThumbnailUrl: URL, takenOn: String, originalFileName: String, title: String) {
            self.url = url
            self.name = name
            self.hash = hash
            self.thumbnailUrl = thumbnailUrl
            self.hdThumbnailUrl = hdThumbnailUrl
            
            self.originalFileName = originalFileName
            self.title = title
            
            
            if let validTakenOn = GalleryImage.getDateFromString(datetime: takenOn) {
                self.takenOn = validTakenOn
            } else {
                self.takenOn = nil
            }
            
        }
        
        static func getDateFromString(datetime: String) -> Date? {
            if self.dateFormatter == nil {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-ddTHH:mm:ssZ" //2020-06-09T14:32:20Z
                dateFormatter.timeZone = TimeZone.gmt
                self.dateFormatter = dateFormatter
                return self.dateFormatter?.date(from: datetime)
            } else {
                return self.dateFormatter?.date(from: datetime)
            }
            
        }
    }
}
