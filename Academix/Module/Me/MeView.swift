//
//  MeView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-23.
//

import SwiftUI
import Kingfisher

struct MeView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var avatarURL: String = ""
    @State private var firstLoad = true
    let defaults = UserDefaults.standard
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color("light_gray")
                VStack(spacing: 0) {
                    Separator(color: Color("navigation_separator"))
                    Spacer()
                    KFImage(URL(string: avatarURL))
                        .placeholder { Image("data_avatar0")
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 100, height: 100) }
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 100, height: 100)
                        .overlay(Circle().stroke())
                        .padding()
                        .onTapGesture {
                            self.showingImagePicker = true
                        }
                    Text("Name: \(viewModel.currUser.name)")
                        .padding()
                    Text("My email: \(viewModel.currUser.id)")
                        .padding()
                    Text("University: \(viewModel.currUser.university)")
                        .padding()
                    Button(action: {
                        viewModel.signOut()
                    }) {
                        Text("Sign Out")
                            .padding()
                    }
                    .background(Color.secondary)
                    .foregroundColor(.red)
                    .cornerRadius(10)
                    .padding()
                    Spacer()
                }
            }
            .onAppear {
                self.avatarURL = viewModel.currUser.avatar
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: uploadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    func uploadImage() {
        guard var inputImage = inputImage else { return }
        inputImage = inputImage.cropsToSquare().imageWith(newSize: CGSize(width: 150, height: 150))
        viewModel.uploadAvatar(image: inputImage) { avatar in
            self.avatarURL = avatar
        }
    }
}

//struct MeView_Previews: PreviewProvider {
//    static var previews: some View {
//        MeView()
//    }
//}
