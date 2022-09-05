//
//  PostInteractor.swift
//  viper-demo-post
//
//  Created by idris yıldız on 1.09.2022.
//

import Foundation
import Alamofire

class PostInteractor:PresenterToInteractorPostProtocol{
   
    var presenter: InteractorToPresenterPostProtocol?
    
    //fatch from server
    func fetchPostFromServer() {
        var items = [PostModel]()
        APIRequests.shared.request(method: .get, url: getPosts_url , parameters:  ["":""] ) {
            (jsonObject, success) in
            if success
            {
                let json = jsonObject!["objectname"]
                if !json.isEmpty {
                    if  let arr = jsonObject!["objectname"].array
                    {
                        for item in arr {
                            items.append(PostModel(jsonData: item))
                        }
                    }
                }
                self.presenter?.postFetchSuccess(items: items)
            }else{
                self.presenter?.postFetchFailed()
            }
        }
    }
    
    //dummy data
    func fetchPost() {
        if  Dataholder.shared.postItems.count <= 0
        {
            for i in 1..<4 {
                Dataholder.shared.postItems.append(PostModel(
                    id: "\(i)",
                    ownerUser: Dataholder.shared.users[i-1],
                    name: "Lorem Ipsum is simply dummy text - \(i)",
                    des: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer...",
                    photoUrl: "post",
                    likedCount: 2*i,
                    commentCount: 8*i,
                    sharedCount: 12*i,
                    seenCount: 3*i))
            }
        }
        
        if Dataholder.shared.showAllPost {
            presenter?.postFetchSuccess(items: Dataholder.shared.postItems)
        }else{
            var currentUserPosts = [PostModel]()
            for i in 0..<Dataholder.shared.postItems.count {
                if Dataholder.shared.currentUser.id == Dataholder.shared.postItems[i].ownerUser.id  {
                    currentUserPosts.append(Dataholder.shared.postItems[i])
                }
            }
            presenter?.postFetchSuccess(items: currentUserPosts)
        }
    }

    func addPost(item: PostModel) {
        Dataholder.shared.postItems.append(item)
         
        if Dataholder.shared.showAllPost {
            presenter?.postFetchSuccess(items: Dataholder.shared.postItems)
        }else{
            var currentUserPosts = [PostModel]()
            for i in 0..<Dataholder.shared.postItems.count {
                if Dataholder.shared.currentUser.id == Dataholder.shared.postItems[i].ownerUser.id  {
                    currentUserPosts.append(Dataholder.shared.postItems[i])
                }
            }
            presenter?.postFetchSuccess(items: currentUserPosts)
        }
    }
}
