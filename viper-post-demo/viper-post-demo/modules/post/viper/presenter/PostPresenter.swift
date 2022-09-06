//
//  PostPresenter.swift
//  viper-demo-post
//
//  Created by idris yıldız on 1.09.2022.
//

import Foundation

class PostPresenter:ViewToPresenterPostProtocol{
   
    var view: PresenterToViewPostProtocol?
    
    var interactor: PresenterToInteractorPostProtocol?
    
    var router: PresenterToRouterPostProtocol?
    
    func startFetchingPost() {
        interactor?.fetchPost()
    }
    
    func addPost(item: PostModel) {
        interactor?.addPost(item: item)
    }
}

extension PostPresenter:InteractorToPresenterPostProtocol {
    
    func postFetchSuccess(items: [PostModel]) {
        view?.onPostResponseSuccess(items: items)
    }
    
    func postFetchFailed() {
        view?.onPostResponseFailed(error: "Some Error message from api response")
    }
}
