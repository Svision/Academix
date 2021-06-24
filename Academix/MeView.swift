//
//  MeView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-23.
//

import SwiftUI

struct MeView: View {
    var body: some View {
        ZStack {
            Color(red: 241 / 255, green: 241 / 255, blue: 241 / 255)
                .edgesIgnoringSafeArea(.top)
            Text("Me")
        }
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
