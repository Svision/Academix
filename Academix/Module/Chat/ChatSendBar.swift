//
//  ChatSendBar.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-25.
//

import SwiftUI

struct ChatSendBar: View {
    let proxy: GeometryProxy
    
    @State private var text: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            Separator(color: Color("chat_send_line"))
            
            ZStack {
                Color("chat_send_background")
                    .ignoresSafeArea(edges: .bottom)
                
                VStack {
                    HStack(spacing: 12) {
                        Image("chat_send_voice")
                        
                        TextEditor(text: $text)
                            .frame(height: 40)
                            .background(Color("chat_send_text_background"))
                            .cornerRadius(4)
                        
                        Image("chat_send_emoji")
                        Image("chat_send_more")
                    }
                    .frame(height: 56)
                    .padding(.horizontal, 12)
                    
                    Spacer()
                }
            }
            .frame(height: proxy.safeAreaInsets.bottom + 56)
        }
    }
}

struct ChatSendBar_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader {geometry in
            VStack {
                Spacer()
                ChatSendBar(proxy: geometry)
            }
        }
    }
}
