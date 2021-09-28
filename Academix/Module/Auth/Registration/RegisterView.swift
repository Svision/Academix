//
//  RegisterView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-29.
//

import SwiftUI

struct RegisterView: View {
    @State var selectedUniversity = "-"
    @State var name = ""
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
    
    private func nameToDefaultEmail(name: String) -> String {
        var email = ""
        for ch in name {
            if ch.isLetter {
                email += ch.lowercased()
            }
            else {
                if ch == " " {
                    email += "."
                }
            }
        }
        email += "@academix.com"
        return email
    }
    
    private func register() {
        self.endTextEditing()
        self.isLoading.toggle()
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty, !verifiedPassword.isEmpty else {
            self.showAlert.toggle()
            alertMessage = "Fields cannot be empty!"
            return
        }
        guard selectedUniversity != "-" else {
            self.showAlert.toggle()
            alertMessage = "Please choose your university!"
            return
        }
        if verifiedPassword != password {
            self.showAlert.toggle()
            alertMessage = "Password does not match!"
            return
        }
        viewModel.signUp(name: name, university: selectedUniversity, email: email, password: password)
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
            VStack {
                Spacer()
//                Image("Academix")
//                    .resizable()
//                    .frame(width: 120, height: 120)
//                    .padding(.bottom)
                Text("Register")
                    .font(.title)
                    .bold()
                    .foregroundColor(.primary)
                
                VStack {
                    // Personal Info
                    HStack {
                        Image(systemName: "person")
                            .foregroundColor(.secondary)
                        TextField("Name", text: $name)
                            .foregroundColor(.primary)
                            .disableAutocorrection(true)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.primary, lineWidth: 2)
                    )
                }
                .padding(.vertical)
                
                VStack {
                    // University Info
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(.secondary)
                        TextField("University Email", text: $email)
                            .foregroundColor(.primary)
                            .keyboardType(.asciiCapable)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .simultaneousGesture(TapGesture().onEnded {
                                email = nameToDefaultEmail(name: name)
                            })
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.primary, lineWidth: 2)
                    )
                    HStack {
                        Image(systemName: "graduationcap")
                            .foregroundColor(.secondary)
                        if selectedUniversity == "-" {
                            Text("University")
                                .foregroundColor(.secondary)
                        }
                        else {
                            Text(selectedUniversity)
                                .foregroundColor(.primary)
                        }
                        Spacer()
                        NavigationLink(destination: UniversityPickerView(selectedUniversity: $selectedUniversity)) {
                            Image(systemName: "arrow.right.circle")
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.primary, lineWidth: 2)
                    )
                }
                .padding(.vertical)
                                
                VStack(spacing: 10){
                    // Password
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
                .padding(.vertical)

                Button(action: {register()}) {
                    Text("Register")
                        .foregroundColor(.white)
                        .font(.title2)
                        .background(RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color("theme_blue"))
                                        .frame(width: 200, height: 50))
                }
                .padding()
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


struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
