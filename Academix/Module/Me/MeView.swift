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
                    .edgesIgnoringSafeArea(.top)
                ScrollView {
                    VStack {
                        Image("me_background")
                            .resizable()
                            .frame(width: proxy.size.width, height: proxy.size.height / 4)
                            .overlay(
                                HStack(spacing: 8) {
                                    // avatar
                                    KFImage(URL(string: avatarURL))
                                        .placeholder { Image("data_avatar0")
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(Circle())
                                            .frame(width: 120, height: 120) }
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(Circle())
                                        .frame(width: 120, height: 120)
                                        .overlay(Circle().stroke())
                                        .padding()
                                        .onTapGesture {
                                            self.showingImagePicker = true
                                        }
                                    // info
                                    VStack(spacing: 5){
                                        Text(viewModel.currUser.name)
                                            .font(.title)
                                        if viewModel.currUser.university == "UofT" {
                                            Text("University of Toronto")
                                        }
                                        else if viewModel.currUser.university == "McMaster" {
                                            Text("McMaster University")
                                        }
                                        else {
                                            Text(viewModel.currUser.university)
                                        }
                                    }
                                    .padding()
                                }
                                    .padding(.top, proxy.size.height / 4)
                            )
                    }

                }
                .edgesIgnoringSafeArea(.top)
                .padding(.bottom, 1)
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
