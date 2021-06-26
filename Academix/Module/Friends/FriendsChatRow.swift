//
//  FriendsChatRow.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-26.
//

import SwiftUI

struct FriendsChatRow: View {
    let chat: Chat
    
    var body: some View {
        HStack(spacing: 12) {
            Image(chat.sender.avatar)
                .renderingMode(.original)
                .resizable()
                .frame(width: 48, height: 48)
                .cornerRadius(25)

            VStack(alignment: .leading, spacing: 5) {
                HStack(alignment: .top) {
                    Text(chat.sender.name)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.primary)
                    Spacer()
                    Text(chat.time.formatString)
                        .font(.system(size: 10))
                        .foregroundColor(.secondary)
                }

                Text(chat.desc)
                    .lineLimit(1)
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)
            }
        }
        .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
    }
}

struct FriendsChatRow_Previews: PreviewProvider {
    static var previews: some View {
        FriendsChatRow(chat: .amanda)
    }
}
