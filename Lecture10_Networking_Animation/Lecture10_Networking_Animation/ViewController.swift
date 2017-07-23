//
//  ViewController.swift
//  Lecture10_Networking_Animation
//
//  Created by bws2007 on 23.07.17.
//  Copyright © 2017 bws2007. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func getRequest(_ sender: UIButton) {
        
        if let url = URL(string: "http://jsonplaceholder.typicode.com/posts/1")
        {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let taskError = error
                {
                    print(taskError.localizedDescription)
                    return
                }
                
                if let downloadetData = data
                {
                    if let json = (try? JSONSerialization.jsonObject(with: downloadetData, options: [])) as? [String:Any]
                    {
                        guard let userID = json["userId"] as? Int,
                            let id = json["id"] as? Int,
                            let title = json["title"] as? String,
                            let body = json["body"] as? String else { return }
                        
                        
                        print("userID = \(userID), id = \(id), title = \(title), body = \(body)")
                        
                        let post = UserPost(title: title, body: body, id: id, userId: userID)
                    }
                }
                
            }
            task.resume()
        }
    }

    @IBAction func postRequest(_ sender: UIButton) {
    }
    
    @IBAction func downloadRequest(_ sender: UIButton) {
    }
    
}




















































