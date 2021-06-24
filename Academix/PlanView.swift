//
//  PlanView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-23.
//

import SwiftUI

struct PlanView: View {
    var body: some View {
        ZStack {
            Color(red: 241 / 255, green: 241 / 255, blue: 241 / 255)
                .edgesIgnoringSafeArea(.top)
            Text("Plan")
        }
    }
}

struct PlanView_Previews: PreviewProvider {
    static var previews: some View {
        PlanView()
    }
}
