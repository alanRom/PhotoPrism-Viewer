//
//  SessionModel.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 9/28/24.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let untitled1 = try Untitled1(json)

import Foundation

// MARK: - Untitled1
struct SessionResponse: Codable {
    let accessToken: String
    let config: Config
    let data: DataClass
    let expiresIn: Int
    let id, provider, scope, sessionID: String
    let status, tokenType: String
    let user: User
}

// MARK: - Config
struct Config: Codable {
    let mode, name, about, edition: String
    let version, copyright, flags, baseURI: String
    let staticURI, cssURI, jsURI, manifestURI: String
    let apiURI, contentURI, videoURI, wallpaperURI: String
    let siteURL: String
    let siteDomain, siteAuthor, siteTitle, siteCaption: String
    let siteDescription: String
    let sitePreview: String
    let legalInfo, legalURL, appName, appMode: String
    let appIcon, appColor: String
    let restart, debug, trace, test: Bool
    let demo, sponsor, readonly, uploadNSFW: Bool
    let configPublic: Bool
    let authMode, usersPath, loginURI, registerURI: String
    let passwordLength: Int
    let passwordResetURI: String
    let experimental: Bool
//    let albumCategories: NSNull
//    let albums: [Any?]
    let cameras, lenses: [Camera]
    let countries: [Country]
//    let people: [Any?]
    let thumbs: [Thumb]
    let tier: Int
    let membership, customer, mapKey, downloadToken: String
    let previewToken: String
    let disable: [String: Bool]
    let count: [String: Int]
    let pos: Pos
    let years: [Int]
    let colors: [SessionColor]
    let categories: [Category]
    let clip: Int
    let server: Server
    let settings: ConfigSettings
//    let acl: ACL
    let ext: EXT
}

// MARK: - ACL
//struct ACL: Codable {
//    let albums, calendar: Albums
//    let config, aclDefault, favorites, feedback: NSNull
//    let files: NSNull
//    let folders: Albums
//    let labels, logs, metrics: NSNull
//    let moments: Albums
//    let passcode: Passcode
//    let password: Password
//    let people: NSNull
//    let photos, places: Albums
//    let services: NSNull
//    let sessions: Sessions
//    let settings: UsersClass
//    let shares: NSNull
//    let users: UsersClass
//    let videos: Albums
//    let webdav: NSNull
//}

// MARK: - Albums
struct Albums: Codable {
    let accessShared, download: Bool
    let react: Bool?
    let search, view: Bool
}

// MARK: - Passcode
struct Passcode: Codable {
    let accessOwn, create, delete, update: Bool
}

// MARK: - Password
struct Password: Codable {
    let accessOwn, update: Bool
}

// MARK: - Sessions
struct Sessions: Codable {
    let accessOwn, create, delete, manageOwn: Bool
    let subscribe, update, view: Bool
}

// MARK: - UsersClass
struct UsersClass: Codable {
    let accessOwn, update, view: Bool
}

// MARK: - Camera
struct Camera: Codable {
    let id: Int
    let slug, name: String
    let make: String
    let model: String
    let type: String?
}


// MARK: - Category
struct Category: Codable {
    let uid, slug, name: String
}

// MARK: - Color
struct SessionColor: Codable {
    let example, name, slug: String
}

// MARK: - Country
struct Country: Codable {
    let id, slug, name: String
}

// MARK: - EXT
struct EXT: Codable {
    let oidc: Oidc
    let plus: Plus
}

// MARK: - Oidc
struct Oidc: Codable {
    let enabled: Bool
    let icon, loginURI, provider: String
    let redirect, register: Bool
}

// MARK: - Plus
struct Plus: Codable {
}

// MARK: - Pos
struct Pos: Codable {
    let uid, cid: String
    let utc: Date
    let lat, lng: Int
}

// MARK: - Server
struct Server: Codable {
    let cores, routines: Int
    let memory: Memory
}

// MARK: - Memory
struct Memory: Codable {
    let total, free, used, reserved: Int
    let info: String
}

// MARK: - ConfigSettings
struct ConfigSettings: Codable {
    let ui: UI
    let search: Search
    let maps: Maps
    let features: [String: Bool]
    let settingsImport: Import
    let index: Index
    let stack: Stack
    let share: Share
    let download: Download
    let templates: Templates
}

// MARK: - Download
struct Download: Codable {
    let name: String
    let disabled, originals, mediaRaw, mediaSidecar: Bool
}

// MARK: - Index
struct Index: Codable {
    let path: String
    let convert, rescan, skipArchived: Bool
}

// MARK: - Maps
struct Maps: Codable {
    let animate: Int
    let style: String
}

// MARK: - Search
struct Search: Codable {
    let batchSize: Int
}

// MARK: - Import
struct Import: Codable {
    let path: String
    let move: Bool
}

// MARK: - Share
struct Share: Codable {
    let title: String
}

// MARK: - Stack
struct Stack: Codable {
    let uuid, meta, name: Bool
}

// MARK: - Templates
struct Templates: Codable {
    let templatesDefault: String
}

// MARK: - UI
struct UI: Codable {
    let scrollbar, zoom: Bool
    let theme, language, timeZone: String
}

// MARK: - Thumb
struct Thumb: Codable {
    let size, usage: String
    let w, h: Int
}

// MARK: - DataClass
struct DataClass: Codable {
    let tokens, shares: Optional<String>
}

// MARK: - User
struct User: Codable {
    let id: Int
    let uid, authProvider, authMethod, authID: String
    let name, displayName, email, role: String
    let attr: String
    let superAdmin, canLogin: Bool
    let loginAt: Date
    let webDAV: Bool
    let basePath, uploadPath: String
    let canInvite: Bool
    let details: Details
    let settings: Settings
    let thumb, thumbSrc: String
    let createdAt, updatedAt: Date
}

// MARK: - Details
struct Details: Codable {
    let birthYear, birthMonth, birthDay: Int
    let nameTitle, givenName, middleName, familyName: String
    let nameSuffix, nickName, nameSrc, gender: String
    let about, bio, location, country: String
    let phone, siteURL, profileURL, orgTitle: String
    let orgName, orgEmail, orgPhone, orgURL: String
    let createdAt, updatedAt: Date
}

// MARK: - Settings
struct Settings: Codable {
    let createdAt, updatedAt: Date
}
