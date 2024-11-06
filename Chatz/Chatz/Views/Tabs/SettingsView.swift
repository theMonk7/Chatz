//
//  SettingsView.swift
//  Chatz
//
//  Created by Utkarsh Raj on 05/11/24.
//

import SwiftUI
import FirebaseAuth
import PhotosUI

struct SettingsConfig {
    var showPhotoOption: Bool = false
    var sourceType: UIImagePickerController.SourceType?
    var selectedImage: Image?
    var displayName: String = ""
    
}

struct SettingsView: View {
    @State private var settingsConfig = SettingsConfig()
    @FocusState private var isEditing: Bool
    @State private var photoItem: PhotosPickerItem?
    @EnvironmentObject private var appState: AppState
    
    private var displayName: String {
        guard let currentUser = Auth.auth().currentUser else { return "Guest" }
        return currentUser.displayName ?? "Guest"
    }
    var body: some View {
        VStack {
            (settingsConfig.selectedImage ?? Image(systemName: "person.circle.fill"))
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .clipShape(.circle)
                .onTapGesture {
                    settingsConfig.showPhotoOption = true
                }
                .confirmationDialog("Select", isPresented: $settingsConfig.showPhotoOption) {
                    Button("Photo Library") {
                        settingsConfig.sourceType = .photoLibrary
                    }
                }
            PhotosPicker(selection: $photoItem, matching: .images, preferredItemEncoding: .current) {
                Text("Select Image")
            }
            .onChange(of: photoItem) {
                Task {
                    if let loaded = try? await photoItem?.loadTransferable(type: Image.self) {
                        settingsConfig.selectedImage = loaded
                    } else {
                        print("Failed")
                    }
                }
            }
            
            TextField(settingsConfig.displayName, text: $settingsConfig.displayName)
                .textFieldStyle(.roundedBorder)
                .focused($isEditing)
                .textInputAutocapitalization(.never)
            Spacer()
            Button("Signout") {
                Task {
                    do {
                        try Auth.auth().signOut()
                        appState.routes.removeAll()
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
            }
            .foregroundStyle(.red)
            .buttonStyle(.borderless)
            .frame(maxWidth: .infinity)

        }
        .padding()
        .onAppear {
            settingsConfig.displayName = displayName
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppState())
}
