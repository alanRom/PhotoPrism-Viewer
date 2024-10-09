//
//  LoginView.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 9/28/24.
//

import SwiftUI
import LoadingButton



struct LoginView: View {
    @Environment(SessionService.self) var sessionService: SessionService
    let closeLogin: () -> Void
    @State var hasLoginError: Bool = false
    
    @Bindable var viewModel: LoginViewModel = LoginViewModel()
    
    var recentSessionsView: some View {
        VStack {
            if !viewModel.recentSessions.isEmpty {
                Text("Recent Connections")
                ForEach(viewModel.recentSessions){ session in
                    Button {
                        viewModel.setRecentSession(session)
                    } label: {
                        Text(session.baseURL)
                    }
                    .padding(10)
                    .buttonStyle(.bordered)
                    
                }
            }
           
        }
    }
    
    @State var isLoading: Bool = false
    
    var loginButton: some View {
        LoadingButton(action: {
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
                isLoading = false
            }
        }, isLoading: $isLoading, style: LoadingButtonStyle(cornerRadius: 10)) {
            Text("Login")
                .foregroundColor(Color.white)
        }
    }
    
    var body: some View {
        VStack {
            Text("PhotoPrism Viewer")
                .foregroundStyle(.primary)
                .font(.headline)
            
            TextField("Server URL", text: $viewModel.loginDetails.baseURL, prompt:
                        Text("https://server.com:1234"))
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.top, 20)
                
                
                Divider()
            TextField("Username", text: $viewModel.loginDetails.username)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.top, 20)
                
                Divider()
            SecureField("Password", text: $viewModel.loginDetails.password)
                .padding(.top, 20)
                
                
                Divider()
//            Button("Login") {
//                hasLoginError = false
//                Task {
//                    do {
//                        let _ = try await viewModel.login(with: sessionService)
//                        if sessionService.activeSession != nil {
//                            closeLogin()
//                        } else {
//                            hasLoginError = true
//                        }
//                        
//                    } catch {
//                        hasLoginError = true
//                    }
//                    isLoading = false
//                }
//                
//            }
//            .controlSize(.large)
//            .buttonStyle(.borderedProminent)
            
            loginButton
            
            if hasLoginError {
                Text("There was an error logging in")
                    .foregroundStyle(.red)
                    .font(.system(size: 14))
                    .padding(10)
            }
            
            Spacer()
                .frame(minHeight: 10, idealHeight: 100, maxHeight: 200)
                .fixedSize()
            
            recentSessionsView
        }
        .padding(10)
        .interactiveDismissDisabled()
    }
    
   
}

#Preview {
    @Previewable @State var sessionService = SessionService()
    LoginView(closeLogin: {})
        .environment(sessionService)
    
}
