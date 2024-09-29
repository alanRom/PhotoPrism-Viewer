//
//  PhotosResponseModel.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 9/29/24.
//

import Foundation

struct PhotosResponseModel: Codable {
    
    let ID:            String;
    let UID:           String;
    let `Type`:          String;
    let TypeSrc:       String;
    let TakenAt:       String;
    let TakenAtLocal:  String;
    let TakenSrc:      String;
    let TimeZone:      String;
    let Path:          String;
    let Name:          String;
    let OriginalName:  String;
    let Title:         String;
    let Description:   String;
    let Year:          Int;
    let Month:         Int;
    let Day:           Int;
    let Country:       String;
    let Stack:         Int;
    let Favorite:      Bool;
    let Private:       Bool;
    let Iso:           Int;
    let FocalLength:   Int;
    let FNumber:       Double;
    let Exposure:      String;
    let Quality:       Int;
    let Resolution:    Int;
    let Color:         Int;
    let Scan:          Bool;
    let Panorama:      Bool;
    let CameraID:      Int;
    let CameraModel:   String;
    let LensID:        Int;
    let LensModel:     String;
    let Lat:           Double;
    let Lng:           Double;
    let CellID:        String;
    let PlaceID:       String;
    let PlaceSrc:      String;
    let PlaceLabel:    String;
    let PlaceCity:     String;
    let PlaceState:    String;
    let PlaceCountry:  String;
    let InstanceID:    String;
    let FileUID:       String;
    let FileRoot:      String;
    let FileName:      String;
    let Hash:          String;
    let Width:         Int;
    let Height:        Int;
    let Portrait:      Bool;
    let Merged:        Bool;
    let CreatedAt:     Date;
    let UpdatedAt:     Date;
    let EditedAt:      Date;
    let CheckedAt:     Date;
    let Files:        [String]? ;
    let CameraSrc:   String?;
    let CameraSerial: String?;
    let CameraMake:   String?;
    let Altitude:     Int?;
}
