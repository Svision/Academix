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
            VStack(spacing: CGFloat(verticalPaddingForForm)) {
                Text("Academix")
                    .font(.title)
                    .foregroundColor(.primary)
                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(.secondary)
                    TextField("Enter Email", text: $email)
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
                
                HStack {
                    Image(systemName: "key")
                        .foregroundColor(.secondary)
                    SecureField("Enter Password", text: $password)
                        .foregroundColor(.primary)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.primary, lineWidth: 2)
                )
                
                Button(action: {signIn()}) {
                    Text("Sign In")
                }
                .frame(width: 100, height: 50)
                .background(Color.primary)
                .foregroundColor(Color(UIColor.systemBackground))
                .cornerRadius(10)
                
                NavigationLink(destination: RegisterView()) {
                    Text("Register")
                        .padding()
                }
                .background(Color.secondary)
                .foregroundColor(Color(UIColor.systemBackground))
                .cornerRadius(10)
            }.padding(.horizontal, CGFloat(verticalPaddingForForm))
            
        }
        .navigationTitle("Sign In")
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
