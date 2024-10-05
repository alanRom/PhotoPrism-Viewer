//
//  PhotoPrism_ViewerApp.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 9/26/24.
//

import SwiftUI

@main
struct PhotoPrism_ViewerApp: App {
    @State var sessionService = SessionService()
    
    
    var body: some Scene {
        
        WindowGroup {
            NavigationStack {
                SessionHostView()
                    .environment(sessionService)
            }
            
        }
    }
}
