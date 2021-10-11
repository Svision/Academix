//
//  ChatSendBar.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-25.
//

import SwiftUI
import Firebase
//import Introspect

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
                        if text.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                            sendMsg(message: Message(timestamp: Date(), sender: viewModel.currUser, text: text))
                        }
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
                        TextField("", text: $text)
                            .frame(height: 40)
                            .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))
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
        let sender = PushNotificationSender()
        let to = toCourses ? "Courses" : "DMs"
        let dbMsg = Firestore.firestore().collection("Messages").document("Messages").collection(to)
        let dest = toCourses ? receiver : (message.sender.id < receiver ? "\(message.sender.id)&\(receiver)" : "\(receiver)&\(message.sender.id)")
        let tmpText = text
                
        dbMsg.document(dest).collection(dest).document().setData([
            "sender": message.sender.id,
            "text": message.text,
            "timestamp": Timestamp(date: message.timestamp)
        ]) { err in
            if err != nil {
                print(err!.localizedDescription)
                return
            } else {
                print("successfully send message")
                if to == "DMs" {
                    // notification
                }
                if !toCourses {
                    DispatchQueue.main.async {
                        let ref = Firestore.firestore()
                        ref.collection("Users").document(receiver).getDocument { doc, err in
                            if let doc = doc, doc.exists {
                                let fcmToken = doc.get("fcmToken") as! String
                                sender.sendPushNotification(to: fcmToken, title: viewModel.currUser.name, body: tmpText)
                            }
                            else {
                                print("No user fcmToken")
                            }
                        }
                    }
                }
                text = ""
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
