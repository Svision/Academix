//
//  Separator.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-25.
//

import SwiftUI

struct Separator: View {
    let color: Color
    
    var body: some View {
        Divider()
            .overlay(color)
            .padding(.zero)
    }
    
    init(color: Color = Color("separator")) {
        self.color = color
    }
}


struct Separator_Previews: PreviewProvider {
    static var previews: some View {
        Separator()
    }
}
