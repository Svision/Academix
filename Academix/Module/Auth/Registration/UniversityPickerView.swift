//
//  UniversityPickerView.swift
//  Academix
//
//  Created by Changhao Song on 2021-09-27.
//

import SwiftUI

struct UniversityPickerView: View {
    var universities = ["-", "UofT", "McMaster", "Other"]
    @Binding var selectedUniversity: String
    var body: some View {
        Picker("University", selection: $selectedUniversity) {
            ForEach(universities, id: \.self) {
                Text($0)
            }
        }
        .pickerStyle(.wheel)
        .navigationTitle("University")
    }
}

struct UniversityPickerView_Previews: PreviewProvider {
    static var previews: some View {
        UniversityPickerView(selectedUniversity: .constant("-"))
    }
}
