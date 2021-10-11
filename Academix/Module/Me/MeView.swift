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
    @State private var avatarURL: String = "data_avatar0"
    @State private var firstLoad = true
    @State private var coursePrivacy = false
    let defaults = UserDefaults.standard
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
//                Color("light_gray")
//                    .edgesIgnoringSafeArea(.top)
                ScrollView {
                    VStack  {
                        // Header
                        Group {
                            Image("me_bg")
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
                        
                        // coursePrivacy
                        HStack {
                            if coursePrivacy {
                                Text("Anyone cannot see common courses.")
                                    .foregroundColor(.secondary)
                                Text("Turn on")
                                    .foregroundColor(.blue)
                                    .onTapGesture {
                                        coursePrivacy.toggle()
                                    }
                            }
                            else {
                                Text("Anyone can see common courses.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("Turn off")
                                    .foregroundColor(.blue)
                                    .onTapGesture {
                                        coursePrivacy.toggle()
                                    }
                            }
                        }
                        .font(.caption)
                        .padding(.top, proxy.size.height / 11)

                        // Courses Taking
                        VStack {
                            HStack {
                                Text("Courses Taking:")
                                    .padding(.horizontal)
                                    .padding(.top, 5)
                                Spacer()
                            }
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(viewModel.currUser.courses, id: \.id) { course in
                                        CourseCardView(course: course)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }

                        // Contributions
                        VStack {
                            HStack {
                                Text("Contributions:")
                                    .padding(.horizontal)
                                    .padding(.top, 5)
                                Spacer()
                            }
                            HStack {
                                Text("\(viewModel.currUser.contributions) ").foregroundColor(.black)
                                + Text("Contributions").foregroundColor(.black)
                                Text("|")
                                    .foregroundColor(Color("theme_blue"))
                                Text("\(viewModel.currUser.receivedLikes) ").foregroundColor(.black)
                                + Text("Likes").foregroundColor(.black)
                            }
                            .padding()
                            .background(Rectangle()
                                            .stroke(Color.secondary)
                                            .frame(width: 300)
                                            .background(Color("course_card_bg"))
                                            .shadow(color: .primary.opacity(0.3),
                                                    radius: 3, x: 3, y: 3))
                        }
                        
                        // Interests
                        VStack {
                            HStack {
                                Text("Interests & Projects:")
                                    .padding(.horizontal)
                                    .padding(.top, 5)
                                Spacer()
                            }
                            // TODO
                            Text("Imagine a really cool UI here 😄")
                                .font(.title2)
                                .padding()
                            Text("Implementing...")
                                .font(.caption)
                                .padding()
                        }
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
