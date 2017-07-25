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
        
        let newPost = UserPost(title: "my title", body: "my body", id: 11, userId: 1)
        
        if let url = URL(string: "http://jsonplaceholder.typicode.com/posts")
        {
            let json:[String:Any] = ["title":newPost.title,
                                     "body":newPost.body,
                                     "userId":newPost.userId,
                                     "id":newPost.id]
            
            let dataForServer = try? JSONSerialization.data(withJSONObject: json, options: [])
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = dataForServer
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let taskError = error
                {
                    print(taskError.localizedDescription)
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                    response.statusCode != 201
                    else
                {
                    print("🔴")
                    return
                }
            }
            task.resume()
        }
        
    }
    
    @IBAction func downloadRequest(_ sender: UIButton) {
        
        let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
        let destinationFileUrl = documentsUrl.appendingPathComponent("downloadedFile.jpg")
        
        let fileURL = URL(string: "https://www.w3schools.com/css/img_lights.jpg")

        let request = URLRequest(url:fileURL!)
        
        let task = URLSession.shared.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
                
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                }
                
            } else {
                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription);
            }
        }
        task.resume()

        
    }
    
    
    
    
    
    @IBOutlet weak var animatingView: UIView!
    
    @IBOutlet weak var animatingViewLabel: UILabel!
    
    @IBAction func animation1(_ sender: Any) {
        
        UIView.animate(withDuration: 2.0,
                       animations: {self.animatingView.alpha = 0}) { isFinished in
                        if isFinished
                        {
                            UIView.animate(withDuration: 2.0) {
                                self.animatingView.alpha = 1.0
                            }
                        }
        }
        
        
    }
    
    @IBAction func animatino2(_ sender: Any) {
        
        let oldFrame = animatingView.frame
        
        
        
        
        UIView.animate(withDuration: 4.0,
                       delay: 0.5,
                       options: [.curveEaseInOut],
                       animations: {
                        let newFrame = CGRect(x: 20, y: 20, width: 60, height: 30)
                        self.animatingView.frame = newFrame
                        }) { isFinished in
                            if isFinished
                            {
                                UIView.animate(withDuration: 4.0) {
                                    self.animatingView.frame = oldFrame
                                }
                            }
                           }
    }
    
    @IBAction func animation3(_ sender: Any) {
        
        UIView.transition(with: animatingView,
                          duration: 2.0,
                          options: [.transitionFlipFromLeft],
                          animations: { 
                            self.animatingViewLabel.isHidden = !self.animatingViewLabel.isHidden
        },
                          completion: nil)
        
    }
    
    @IBAction func animation4(_ sender: Any) {
       
        let newView = UIView(frame: CGRect(x: 30, y: 30, width: 40, height: 40))
        newView.backgroundColor = UIColor.green
        view.addSubview(newView)
        
        let item:UIDynamicItem = newView
        
        gravity.addItem(item)
        colision.addItem(item)
        itemBehaviour.addItem(item)
    }
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var colision: UICollisionBehavior!
    var itemBehaviour: UIDynamicItemBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: self.view)
        
        gravity = UIGravityBehavior()
        colision = UICollisionBehavior()
        itemBehaviour = UIDynamicItemBehavior()
        
        colision.translatesReferenceBoundsIntoBoundary = true
        colision.collisionMode = .everything
        
        itemBehaviour.allowsRotation = true
        itemBehaviour.elasticity = 0.9
        itemBehaviour.friction = 0.5

        animator.addBehavior(gravity)
        animator.addBehavior(colision)
        animator.addBehavior(itemBehaviour)
        
        
    }
    
}




















































