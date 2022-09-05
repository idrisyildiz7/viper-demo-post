//
//  UserModel.swift
//  viper-demo-post
//
//  Created by idris yıldız on 2.09.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserModel: NSObject {
    
    var id: Int!
    var name: String!
    var nickName: String!
    var photoUrl: String!
    
    //from json
    init(jsonData: JSON)
    {
        self.id = jsonData["id"].intValue
        self.name = jsonData["name"].stringValue
        self.nickName = jsonData["nickName"].stringValue
        self.photoUrl = jsonData["photoUrl"].stringValue
    }
    
    //dummy
    init(id: Int, name: String, nickName: String, photoUrl: String)
    {
        self.id = id
        self.name = name
        self.nickName = nickName
        self.photoUrl = photoUrl
    }
    
    override init() {
        
    }
}
