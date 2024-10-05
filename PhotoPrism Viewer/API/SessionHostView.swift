//
//  SessionHostView.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 10/3/24.
//

import SwiftUI

struct SessionHostView: View {
    @Environment(SessionService.self) var sessionService: SessionService
    @State private var showingLoginSheet = false
    
    func closeLogin() {
        showingLoginSheet = false
    }
    
    @ViewBuilder
    var content: some View {
        if sessionService.activeSession == nil {
            Text("Logged Off")
        } else {
            let galleryViewModel = AllPhotosViewModel(with: sessionService)
            AllPhotosView(galleryViewModel: galleryViewModel)
        }
    }
    
    var body: some View {
        content
        .onAppear(){
            if sessionService.activeSession == nil {
                showingLoginSheet = true
            }
        }
        .sheet(isPresented: $showingLoginSheet){
            LoginView(closeLogin: closeLogin)
                .onDisappear(){
                    if sessionService.activeSession != nil {
                        showingLoginSheet = false
                    }
                }
        }
        .toolbar {
            Button {
                sessionService.endSession()
                showingLoginSheet = true
            } label: {
                Label("Logout", systemImage: "rectangle.portrait.and.arrow.right")
            }
        }
        
    }
}

#Preview {
    @Previewable @State var sessionService = SessionService()
    SessionHostView()
        .environment(sessionService)
}
