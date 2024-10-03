//
//  LoginView.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 9/28/24.
//

import SwiftUI

struct LoginView: View {
    @Environment(SessionService.self) var sessionService: SessionService
    let closeLogin: () -> Void
    @State var hasLoginError: Bool = false
    
    @Bindable var viewModel: LoginViewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            Text("PhotoPrism Viewer")
                .foregroundStyle(.primary)
                .font(.headline)
            
            TextField("Server URL", text: $viewModel.loginDetails.baseURL)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.top, 20)
                
                Divider()
            TextField("Username", text: $viewModel.loginDetails.username)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.top, 20)
                
                Divider()
            TextField("Password", text: $viewModel.loginDetails.password)
                .padding(.top, 20)
                
                Divider()
            Button("Login") {
                hasLoginError = false
                Task {
                    do {
                        let _ = try await viewModel.login(with: sessionService)
                        if sessionService.activeSession != nil {
                            closeLogin()
                        } else {
                            hasLoginError = true
                        }
                    } catch {
                        hasLoginError = true
                    }
                }
                
            }
            if hasLoginError {
                Text("There was an error logging in")
                    .foregroundStyle(.red)
            }
        }
        .padding(10)
    }
    
   
}

#Preview {
    LoginView(closeLogin: {})
}
