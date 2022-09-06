//
//  PostRouter.swift
//  viper-demo-post
//
//  Created by idris yıldız on 1.09.2022.
//

import Foundation
import UIKit

class PostRouter:PresenterToRouterPostProtocol{
    
    static func createPostModule() -> PostViewController {
        
        //crrate instance
        let view:PostViewController = UIStoryboard.Main.instantiateViewController(withIdentifier: "PostViewController") as! PostViewController
        var presenter: ViewToPresenterPostProtocol & InteractorToPresenterPostProtocol = PostPresenter()
        var interactor: PresenterToInteractorPostProtocol = PostInteractor()
        let router:PresenterToRouterPostProtocol = PostRouter()
        
        //set
        view.postPresenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
}
