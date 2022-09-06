//
//  PostProtocol.swift
//  viper-demo-post
//
//  Created by idris yıldız on 1.09.2022.
//

import Foundation

//view and presenter
protocol ViewToPresenterPostProtocol{
    var view: PresenterToViewPostProtocol? {get set}
    var interactor: PresenterToInteractorPostProtocol? {get set}
    var router: PresenterToRouterPostProtocol? {get set}
    func startFetchingPost()
    func addPost(item:PostModel)
}

protocol PresenterToViewPostProtocol {
    func onPostResponseSuccess(items:[PostModel])
    func onPostResponseFailed(error:String)
}
 
protocol PresenterToRouterPostProtocol {
    static func createPostModule()->PostViewController
}


//interactor and presenter
protocol PresenterToInteractorPostProtocol {
    var presenter:InteractorToPresenterPostProtocol? {get set}
    func fetchPost()
    func addPost(item:PostModel)
}

protocol InteractorToPresenterPostProtocol {
    func postFetchSuccess(items:[PostModel])
    func postFetchFailed()
}

