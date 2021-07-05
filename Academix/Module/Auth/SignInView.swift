//
//  SignInView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-29.
//

import SwiftUI

struct SignInView: View {
    @State var email = ""
    @State var password = ""
    @State var showAlert = false
    @State var alertMessage: String = "Some thing went wrong"
    @State var isLoading = false
    @State var isSuccessful = false
    let defaults = UserDefaults.standard
    
    @EnvironmentObject var viewModel: AppViewModel
    
    let verticalPaddingForForm = 40.0
    
    func signIn() {
        self.endTextEditing()
        guard !email.isEmpty, !password.isEmpty else {
            self.showAlert.toggle()
            alertMessage = "Fields cannot be empty"
            return
        }
        self.isLoading.toggle()
        viewModel.signIn(email: email, password: password)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if !(viewModel.errorMessage == "" || viewModel.errorMessage == nil) {
                showAlert.toggle()
                alertMessage = viewModel.errorMessage!
            }
            else {
                // success
            }
        }
    }
    
    var body: some View {
        Background {
            VStack {
                Spacer()
                Image("Academix")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .padding(.bottom)
                Text("Welcome to")
                    .font(.title)
                    .bold()
                    .foregroundColor(.primary)
                Text("Academix")
                    .font(.title)
                    .bold()
                    .foregroundColor(.primary)
                    .padding(.bottom)
                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(.secondary)
                    TextField("University Email", text: $email)
                        .foregroundColor(.primary)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.primary, lineWidth: 2)
                )
                .padding(.vertical)
                
                HStack {
                    Image(systemName: "key")
                        .foregroundColor(.secondary)
                    SecureField("Password", text: $password)
                        .foregroundColor(.primary)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.primary, lineWidth: 2)
                )
                .padding(.vertical)
                
                Button(action: {signIn()}) {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .font(.title2)
                        .background(RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color("theme_blue"))
                                        .frame(width: 200, height: 50))
                }
                .padding()
                Spacer()
                NavigationLink(destination: RegisterView()) {
                    Text("Not on Academix yet? Register")
                        .foregroundColor(.blue)
                        .padding()
                }
                Spacer()
            }.padding(.horizontal, CGFloat(verticalPaddingForForm))
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertMessage))
        }
        .onTapGesture {
            self.endTextEditing()
        }
    }
}

struct Background<Content: View>: View {
    private var content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        Color(UIColor.systemBackground)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .overlay(content)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
