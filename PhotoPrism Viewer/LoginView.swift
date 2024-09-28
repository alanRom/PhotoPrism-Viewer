//
//  LoginView.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 9/28/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var sessionService: SessionService
    
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            TextField("Server URL", text: $viewModel.baseURL)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.top, 20)
                
                Divider()
            TextField("Username", text: $viewModel.username)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.top, 20)
                
                Divider()
            TextField("Password", text: $viewModel.password)
                .padding(.top, 20)
                
                Divider()
            Button("Login") {
                viewModel.login(with: sessionService)
            }
        }
        .padding(10)
    }
    
   
}

#Preview {
    LoginView()
}
