//
//  ChatSendBar.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-25.
//

import SwiftUI
import Firebase

struct ChatSendBar: View {
    @EnvironmentObject var viewModel: AppViewModel
    let proxy: GeometryProxy
    let toCourses: Bool
    let receiver: String
    
    @State private var text: String = ""
    
    func chatBarMore() -> some View {
        HStack {
            GeometryReader { hstack in
                if text == "" {
                    HStack {
                        Button(action: {
                            // TODO: emoji
                        }, label: {
                            Image("chat_send_emoji")
                        })
                        Button(action: {
                            // TODO: more
                        }, label: {
                            Image("chat_send_more")
                        })
                    }
                    .frame(width: hstack.size.width, height: hstack.size.height)
                }
                else {
                    Button(action: {
                        sendMsg(message: Message(timestamp: Date(), sender: viewModel.currUser.id, text: text))
                        text = ""
                    }, label: {
                        Text("Send")
                            .frame(width: hstack.size.width, height: hstack.size.height)
                            .background(RoundedRectangle(
                                cornerRadius: 10.0)
                                            .stroke()
                                            .frame(width: hstack.size.width, height: 30)
                            )
                    })
                }
            }
        }
        .frame(width: proxy.size.width / 6) // 1/6 of the chat bar width
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Separator(color: Color("chat_send_line"))
            
            ZStack {
                Color("chat_send_background")
                    .ignoresSafeArea(edges: .bottom)
                
                VStack {
                    HStack(spacing: 12) {
                        TextEditor(text: $text)
                            .frame(height: 40)
                            .background(Color("chat_send_text_background"))
                            .cornerRadius(4)
                        chatBarMore()
                    }
                    .frame(height: 56)
                    .padding(.horizontal, 12)
                    
                    Spacer()
                }
            }
            .frame(height: proxy.safeAreaInsets.bottom + 56)
        }
    }
    
    func sendMsg(message: Message) {
        let to = toCourses ? "Courses" : "DMs"
        let dbMsg = Firestore.firestore().collection("Messages").document("Messages").collection(to)
        let dest = toCourses ? receiver : (message.sender < receiver ? "\(message.sender)&\(receiver)" : "\(receiver)&\(message.sender)")
                
        dbMsg.document(dest).collection(dest).document().setData([
            "sender": message.sender,
            "text": message.text,
            "timestamp": Timestamp(date: message.timestamp)
        ]) { err in
            if err != nil {
                print(err!.localizedDescription)
                return
            } else {
                print("successfully send")
                if to == "DMs" {
                    // notification
                }
            }
        }

    }
}





//struct ChatSendBar_Previews: PreviewProvider {
//    static var previews: some View {
//        GeometryReader {geometry in
//            VStack {
//                Spacer()
//                ChatSendBar(proxy: geometry)
//            }
//        }
//    }
//}
