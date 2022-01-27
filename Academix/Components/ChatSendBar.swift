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
    static private let normalHeight: CGFloat = 56
    static private let liftHeight: CGFloat = 216
    @State var height: CGFloat = ChatSendBar.normalHeight
    
    @State private var text: String = ""
    
    var ChatBarMore: some View {
        HStack {
            GeometryReader { hstack in
                if text.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                    HStack {
                        Button(action: {
                            // TODO: emoji
                        }, label: {
                            Image("chat_send_emoji")
                        })
                        Button(action: {
                            // TODO: more
                            // height = ChatSendBar.liftHeight
                        }, label: {
                            Image("chat_send_more")
                        })
                    }
                    .frame(width: hstack.size.width, height: hstack.size.height)
                }
                else {
                    Button(action: {
                        sendMsg(message: Message(timestamp: Date(), sender: viewModel.currUser, text: text))
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
    
    var Attachment: some View {
        Button(action: {
            
        }, label: {
            Image(systemName: "paperclip.circle")
                .foregroundColor(Color("symbol_color"))
                .font(Font.system(size: 28, weight: .ultraLight))
        })
    }
    
    var moreFunctions: some View {
        // TODO
        EmptyView()
    }
    
    private var sendImage: some View {
        Image("photo")
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Separator(color: Color("chat_send_line"))
            
            ZStack {
                Color("chat_send_background")
                    .ignoresSafeArea(edges: .bottom)
                
                VStack {
                    HStack(spacing: 12) {
                        Attachment
                        
                        TextEditor(text: $text)
                            .frame(height: 40)
                            .background(Color("chat_send_text_background"))
                            .accentColor(Color("theme_blue"))
                            .cornerRadius(15)
                            .onTapGesture {
                                height = ChatSendBar.normalHeight
                            }

                        ChatBarMore
                    }
                    .frame(height: 56)
                    .padding(.horizontal, 12)
                    
                    Spacer()
                }
            }
            .frame(height: proxy.safeAreaInsets.bottom + height)
        }
        .onTapGesture {
            height = ChatSendBar.normalHeight
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
