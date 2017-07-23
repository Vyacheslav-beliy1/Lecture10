//
//  userPost.swift
//  Lecture10_Networking_Animation
//
//  Created by bws2007 on 23.07.17.
//  Copyright © 2017 bws2007. All rights reserved.
//

import Foundation

class UserPost {
    let title: String
    let body: String
    let id: Int
    let userId: Int
    
    init(title:String, body:String, id: Int, userId: Int) {
        self.title = title
        self.body = body
        self.id = id
        self.userId = userId
    }
}
