//
//  DetailViewModel.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 10/4/24.
//

import SwiftUI
import Kingfisher


@Observable
class DetailViewModel {
    let galleryImage: GalleryImage
    init(galleryImage: GalleryImage) {
        self.galleryImage = galleryImage
    }

    private let folderName = "downloaded_photos"
       
             
   private func createFolderIfNeeded(){
       guard let url = getFolderPath() else {return}
       
       if !FileManager.default.fileExists(atPath: url.path){
           do{
               try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
           }catch let error{
               print("Error:- \(error.localizedDescription)")
           }
       }
   }
    
    private func getSavedFilePath() -> URL? {
        let key = galleryImage.hash
        let filename = "\(key).png"
        do {
            let documentsDirectoryURL = try FileManager().url(for:
                 .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            if !FileManager.default.fileExists(atPath: documentsDirectoryURL.path){
                do{
                    try FileManager.default.createDirectory(at: documentsDirectoryURL, withIntermediateDirectories: true)
                }catch let error{
                    print("Error:- \(error.localizedDescription)")
                }
            }
            
            let fileURL =
                      documentsDirectoryURL.appendingPathComponent(filename)
            
            return fileURL
        } catch {
            print(error)
            return nil
        }
    }
    
    var isImageSaved: Bool {
        guard let savedName = getSavedFilePath() else { return false}
        
        return FileManager.default.fileExists(atPath: savedName.path)
    }
   
   private func getFolderPath() -> URL?{
       return FileManager
           .default
           .urls(for: .cachesDirectory, in: .userDomainMask)
           .first?
           .appendingPathComponent(folderName)
   }
   
       
   func downloadImage(){
       let downLoader = ImageDownloader.default
      downLoader.downloadImage(with: galleryImage.url, completionHandler:  { result in
          switch result {
              case .success(let value):                  do{
                      guard let data = value.image.pngData(), let fileURL = self.getSavedFilePath() else {return}
                      
                      try data.write(to: fileURL)
                      print("Wrote to \(fileURL)")
                  }catch let error{
                      print("ERROR SAVING FM")
                      print(error.localizedDescription)
                  }
              case .failure(let error):
                  print(error)
              }
      })
      
   }
}
