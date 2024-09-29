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
    let access_token: String
    let config: Config
    let data: DataClass
    let expires_in: Int
    let id, provider, scope, session_id: String
    let status, token_type: String
    let user: User
}

// MARK: - Config
struct Config: Codable {
    let mode, name, about, edition: String
    let version, copyright, flags, baseUri: String
    let staticUri, cssUri, jsUri, manifestUri: String
    let apiUri, contentUri, videoUri, wallpaperUri: String
    let siteUrl: String
    let siteDomain, siteAuthor, siteTitle, siteCaption: String
    let siteDescription: String
    let sitePreview: String
    let legalInfo, legalUrl, appName, appMode: String
    let appIcon, appColor: String
    let restart, debug, trace, test: Bool
    let demo, sponsor, readonly, uploadNSFW: Bool
    let configPublic: Bool?
    let authMode, usersPath, loginUri, registerUri: String
    let passwordLength: Int
    let passwordResetUri: String
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
    let access_shared, download: Bool
    let react: Bool?
    let search, view: Bool
}

// MARK: - Passcode
struct Passcode: Codable {
    let access_own, create, delete, update: Bool
}

// MARK: - Password
struct Password: Codable {
    let access_own, update: Bool
}

// MARK: - Sessions
struct Sessions: Codable {
    let access_own, create, delete, manage_own: Bool
    let subscribe, update, view: Bool
}

// MARK: - UsersClass
struct UsersClass: Codable {
    let access_own, update, view: Bool
}

// MARK: - Camera
struct Camera: Codable {
    let ID: Int
    let Slug, Name: String
    let Make: String
    let Model: String
    let `Type`: String?
}


// MARK: - Category
struct Category: Codable {
    let UID, Slug, Name: String
}

// MARK: - Color
struct SessionColor: Codable {
    let Example, Name, Slug: String
}

// MARK: - Country
struct Country: Codable {
    let ID, Slug, Name: String
}

// MARK: - EXT
struct EXT: Codable {
    let oidc: Oidc
    let plus: Plus
}

// MARK: - Oidc
struct Oidc: Codable {
    let enabled: Bool
    let icon, loginUri, provider: String
    let redirect, register: Bool
}

// MARK: - Plus
struct Plus: Codable {
}

// MARK: - Pos
struct Pos: Codable {
    let uid, cid: String
    let utc: String
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
    let `import`: Import
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
    let `default`: String
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
    let ID: Int
    let UID, AuthProvider, AuthMethod, AuthID: String
    let Name, DisplayName, Email, Role: String
    let Attr: String
    let SuperAdmin, CanLogin: Bool
    let LoginAt: String
    let WebDAV: Bool
    let BasePath, UploadPath: String
    let CanInvite: Bool
    let Details: Details
    let Settings: Settings
    let Thumb, ThumbSrc: String
    let CreatedAt, UpdatedAt: String
}

// MARK: - Details
struct Details: Codable {
    let BirthYear, BirthMonth, BirthDay: Int
    let NameTitle, GivenName, MiddleName, FamilyName: String
    let NameSuffix, NickName, NameSrc, Gender: String
    let About, Bio, Location, Country: String
    let Phone, SiteURL, ProfileURL, OrgTitle: String
    let OrgName, OrgEmail, OrgPhone, OrgURL: String
    let CreatedAt, UpdatedAt: String
}

// MARK: - Settings
struct Settings: Codable {
    let CreatedAt, UpdatedAt: String
}
