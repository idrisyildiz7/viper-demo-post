//
//  TypeModel.swift

//  Created by idris yıldız on 13.11.2021.
//  Copyright © 2021 gidysoft. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PostModel: NSObject {
    
    var id: String!
    var ownerUser: UserModel!
    var name: String!
    var des: String!
    var photoUrl: String!
    var photo: UIImage!
    
    var likedCount: Int!
    var commentCount: Int!
    var sharedCount: Int!
    var seenCount: Int!
    
    //from json
    init(jsonData: JSON)
    {
        self.id = jsonData["id"].stringValue
        self.ownerUser = UserModel(jsonData: jsonData["ownerUser"])
        self.name = jsonData["name"].stringValue
        self.des = jsonData["des"].stringValue
        self.photoUrl = jsonData["photoUrl"].stringValue
        
        self.likedCount = jsonData["likedCount"].intValue
        self.commentCount = jsonData["commentCount"].intValue
        self.sharedCount = jsonData["sharedCount"].intValue
        self.seenCount = jsonData["seenCount"].intValue
    }
    
    //dummy
    init(id: String, ownerUser: UserModel, name: String, des: String, photoUrl: String, likedCount: Int, commentCount: Int, sharedCount: Int, seenCount: Int)
    {
        self.id = id
        self.ownerUser = ownerUser
        self.name = name
        self.des = des
        self.photoUrl = photoUrl
        self.likedCount = likedCount
        self.commentCount = commentCount
        self.sharedCount = sharedCount
        self.seenCount = seenCount
        
        self.photo = UIImage(named: photoUrl)
    }
    
    override init() {
        
    }
}
