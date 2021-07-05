//
//  PushNotificaiotnSender.swift
//  Academix
//
//  Created by Changhao Song on 2021-07-04.
//

import UIKit

class PushNotificationSender {
    let SERVERKEY = "AAAAvoziMhw:APA91bHwEwWdZFvoUGQ9VwFxOwnnuvcwh5BaH4SQKmrMc8Xg9Gi1w6rHYYQivb65QPq0ZqkRHEj9-590U7WJ1O7AbzWIh67Ji-4gSKf2WZOap9JxAQf4Itu6fN_LvP9GCDX6xDrwvsNn"
    
    func sendPushNotification(to token: String, title: String, body: String) {
        let urlString = "https://fcm.googleapis.com/fcm/send"
        let url = NSURL(string: urlString)!
        let paramString: [String : Any] = ["to" : token,
                                           "notification" : ["title" : title, "body" : body],
                                           "data" : ["user" : "test_id"]
        ]
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject:paramString, options: [.prettyPrinted])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=\(SERVERKEY)", forHTTPHeaderField: "Authorization")
        let task =  URLSession.shared.dataTask(with: request as URLRequest)  { (data, response, error) in
            do {
                if let jsonData = data {
                    if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                        NSLog("Received data:\n\(jsonDataDict))")
                    }
                }
            } catch let err as NSError {
                print(err.debugDescription)
            }
        }
        task.resume()
    }
}
