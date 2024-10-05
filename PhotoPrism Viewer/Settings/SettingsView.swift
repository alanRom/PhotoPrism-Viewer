//
//  SettingsView.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 10/4/24.
//

import SwiftUI

public extension Binding {

    static func convert<TInt, TFloat>(_ intBinding: Binding<TInt>) -> Binding<TFloat>
    where TInt:   BinaryInteger,
          TFloat: BinaryFloatingPoint{

        Binding<TFloat> (
            get: { TFloat(intBinding.wrappedValue) },
            set: { intBinding.wrappedValue = TInt($0) }
        )
    }

    static func convert<TFloat, TInt>(_ floatBinding: Binding<TFloat>) -> Binding<TInt>
    where TFloat: BinaryFloatingPoint,
          TInt:   BinaryInteger {

        Binding<TInt> (
            get: { TInt(floatBinding.wrappedValue) },
            set: { floatBinding.wrappedValue = TFloat($0) }
        )
    }
}

struct SettingsView: View {
    @AppStorage("thumbnailQuality") var thumbnailQuality: Int = 2
    @State private var isEditing = false
    let logout: () -> Void


    var body: some View {
        VStack {
//            Divider()
//            Text("Thumbnail Quality: \(thumbnailQuality)")
//                .foregroundColor( .blue)
//            Slider(value: .convert($thumbnailQuality), in: 1...7, step: 1.0,
//                   onEditingChanged: { editing in
//                       isEditing = editing
//                   })
//            
//            
            Divider()
            Button {
                logout()
            } label: {
                Label("Log Out", systemImage: "rectangle.portrait.and.arrow.right")
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
            .controlSize(.large)
            
        }
    }
     
}

#Preview {
    SettingsView {
        
    }
}
