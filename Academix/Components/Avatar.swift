//
//  Avatar.swift
//  Academix
//
//  Created by Changhao Song on 2021-10-10.
//

import SwiftUI
import Kingfisher

struct Avatar: View {
    let icon: String
    let size: CGFloat
    
    var body: some View {
        if icon.hasPrefix("https") {
            KFImage(URL(string: icon))
                .resizable()
                .clipShape(Circle())
                .frame(width: size, height: size)
        }
        else {
            Image(icon)
                .resizable()
                .clipShape(Circle())
                .frame(width: size, height: size)
        }
    }
    
    init(icon: String, size: CGFloat = 40.0) {
        self.icon = icon
        self.size = size
    }
}
