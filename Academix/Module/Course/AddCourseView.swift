//
//  AddCourseView.swift
//  Academix
//
//  Created by Changhao Song on 2021-07-05.
//

import SwiftUI

struct AddCourseView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var university = "UofT"
    @State var department = ""
    @State var courseCode = ""
    @State var showingAlert: Bool = false
    @State var alertMessage: String = "Something went wrong"
    
    var body: some View {
        VStack {
//            HStack {
            Text("Enter the course")
                .font(.title)
            TextField("Department (e.g. CSC, MAT)", text: $department)
                .foregroundColor(.primary)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.primary, lineWidth: 2)
                )
                .padding()
            TextField("Course Code (e.g. 108, C10)", text: $courseCode)
                .foregroundColor(.primary)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.primary, lineWidth: 2)
                )
                .padding()
//            }
            Button(action: {
                addCourse()
            }) {
                Text("Add")
                    .foregroundColor(.white)
                    .font(.title2)
                    .background(RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color("theme_blue"))
                                    .frame(width: 150, height: 50))
            }
            .padding(.vertical, 30)
            
        }
        .onTapGesture { self.endTextEditing() }
        .navigationTitle("Add Course")
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Bad Format"),
                  message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .onChange(of: department, perform: { value in
            department = department.uppercased()
            if department.count > 3 {
                department = department.subString(to: 3)
                showingAlert = true
                alertMessage = "Department should be exactly three letters, e.g. CSC, MAT"
            }
        })
        .onChange(of: courseCode, perform: { value in
            courseCode = courseCode.uppercased()
            if courseCode.count > 3 {
                courseCode = courseCode.subString(to: 3)
                showingAlert = true
                alertMessage = "Course code should be exactly three letters, e.g. 108, C10"
            }
        })
    }
    
    func addCourse() {
        if department.count != 3 || courseCode.count != 3 {
            showingAlert = true
            alertMessage = "Both Department and Course code should be exactly three letters"
            return
        }
        if !department.isAlpha {
            showingAlert = true
            alertMessage = "Department should only contain letters"
            return
        }
        if !courseCode.isAlphanumeric {
            showingAlert = true
            alertMessage = "Course code should only contain letters and numbers"
            return
        }
        let newCourse = Course(
            university: university,
            department: department,
            courseCode: courseCode
        )
        viewModel.addNewCourse(newCourse)
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddCourseView_Previews: PreviewProvider {
    static var previews: some View {
        AddCourseView()
    }
}
