//
//  MeSettingView.swift
//  Academix
//
//  Created by Changhao Song on 2021-10-02.
//

import SwiftUI

struct MeSettingView: View {
    @EnvironmentObject var viewModel: AppViewModel
    var body: some View {
        VStack {
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
        }
    }
}

struct MeSettingView_Previews: PreviewProvider {
    static var previews: some View {
        MeSettingView()
    }
}
