//
//  RegisterView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-29.
//

import SwiftUI

struct RegisterView: View {
    @State var email = ""
    @State var password = ""
    @State var verifiedPassword = ""
    @State var showAlert = false
    @State var alertMessage: String = "Some thing went wrong"
    @State var isLoading = false
    @State var isSuccessful = false
    let defaults = UserDefaults.standard
    
    @EnvironmentObject var viewModel: AppViewModel
    
    let verticalPaddingForForm = 40.0
    
    func register() {
        self.endTextEditing()
        self.isLoading.toggle()
        guard !email.isEmpty, !password.isEmpty, !verifiedPassword.isEmpty else {
            self.showAlert.toggle()
            alertMessage = "Fields cannot be empty"
            return
        }
        if verifiedPassword != password {
            self.showAlert.toggle()
            alertMessage = "Password does not match!"
            return
        }
        viewModel.signUp(email: email, password: password)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showAlert.toggle()
            if !(viewModel.errorMessage == "" || viewModel.errorMessage == nil) {
                alertMessage = viewModel.errorMessage!
            } else {
                alertMessage = "Account created"
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
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.primary, lineWidth: 2)
                )
                
                VStack(spacing: 10){
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
                    
                    HStack {
                        Image(systemName: "key")
                            .foregroundColor(.secondary)
                        SecureField("Enter Password Again", text: $verifiedPassword)
                            .foregroundColor(.primary)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.primary, lineWidth: 2)
                    )
                }

                
                Button(action: {
                    register()
                }) {
                    Text("Register")
                        .padding()
                }
                .frame(width: 100, height: 50)
                .background(Color.primary)
                .foregroundColor(Color(UIColor.systemBackground))
                .cornerRadius(10)
            }.padding(.horizontal, CGFloat(verticalPaddingForForm))
            
        }
        .navigationTitle("Register")
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertMessage))
        }
        .onTapGesture {
            self.endTextEditing()
        }
    }
}


struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}