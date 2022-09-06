//
//  ViewController.swift
//  viper-demo-post
//
//  Created by idris yıldız on 5.09.2022.
//

import Tabman
import Pageboy
import UIKit
import SwiftEventBus

class MainPostTabViewController: TabmanViewController{
    
    @IBOutlet weak var currentUserImage: UIImageView!
    var titles = [String]()
    var parentNavigaition: UINavigationController!
    var postView:PostViewController!
    var postPresenter:ViewToPresenterPostProtocol?

    lazy var viewControllers: [UIViewController] = {
        var viewControllers = [UIViewController]()
        for i in 0 ..< 2 {
            viewControllers.append(makeChildViewController(at: i))
        }
        return viewControllers
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        configureTabMan()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func configureTabMan(){
        
        currentUserImage.image = UIImage(named: Dataholder.shared.currentUser.photoUrl)
        
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        
        bar.buttons.customize { (bt) in
            bt.selectedTintColor = StyleManager.colors.white
            bt.font = UIFont.systemFont(ofSize: 11)
            bt.selectedFont = UIFont.systemFont(ofSize: 14, weight: .bold)
            bt.tintColor = StyleManager.colors.white
        }
        
        bar.indicator.tintColor = StyleManager.colors.blue
        bar.indicator.cornerStyle = .rounded
        bar.indicator.overscrollBehavior = .bounce
        bar.indicator.weight = .custom(value: 2)
        bar.backgroundColor = StyleManager.colors.black
        bar.backgroundView.style = .flat(color: StyleManager.colors.black)
        bar.layout.contentMode = .fit
        bar.layout.contentInset = UIEdgeInsets(top: 5, left: 15, bottom: 10, right: 15)
        
        addBar(bar, dataSource: self, at: .top)
    }
    
    func makeChildViewController(at index: Int?) -> UIViewController {
        if index == 0 {
            Dataholder.shared.showAllPost = false
            postView = PostRouter.createPostModule()
            postPresenter = postView.postPresenter
            return postView
        }
        else  {
            Dataholder.shared.showAllPost = true
            postView = PostRouter.createPostModule()
            postPresenter = postView.postPresenter
            return postView
        }
    }
    
    //change user action
    @IBAction func changeUser(_ sender: Any) {
        generator.impactOccurred()
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title:  "Cancel", style: .cancel) { _ in
           
        }
        let user1 = UIAlertAction(title:  Dataholder.shared.users[0].name, style: .default) { _ in
            Dataholder.shared.currentUser = Dataholder.shared.users[0]
            self.currentUserImage.image = UIImage(named: Dataholder.shared.currentUser.photoUrl)
            SwiftEventBus.post("reloadPost")
            //postPresenter?.startFetchingPost()//when reload tableview return nil so we use swiftevent bus, because it will took to much time to solve this
        }
        let user2 = UIAlertAction(title:  Dataholder.shared.users[1].name, style: .default) { _ in
            Dataholder.shared.currentUser = Dataholder.shared.users[1]
            self.currentUserImage.image = UIImage(named: Dataholder.shared.currentUser.photoUrl)
            SwiftEventBus.post("reloadPost")
            //postPresenter?.startFetchingPost()//when reload tableview return nil so we use swiftevent bus, because it will took to much time to solve this
        }
        let user3 = UIAlertAction(title:  Dataholder.shared.users[2].name, style: .default) { _ in
            Dataholder.shared.currentUser = Dataholder.shared.users[2]
            self.currentUserImage.image = UIImage(named: Dataholder.shared.currentUser.photoUrl)
            SwiftEventBus.post("reloadPost")
            //postPresenter?.startFetchingPost()//when reload tableview return nil so we use swiftevent bus, because it will took to much time to solve this
        }
        actionSheetController.addAction(cancel)
        actionSheetController.addAction(user1)
        actionSheetController.addAction(user2)
        actionSheetController.addAction(user3)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    @IBAction func addPost(_ sender: Any) {
        generator.impactOccurred()
        let vc:CreatePostViewController = UIStoryboard.CreatePost.instantiateViewController(withIdentifier: "CreatePostViewController") as! CreatePostViewController
        vc.postPresenter = postView.postPresenter
        self.navigationController?.present(vc, animated: true)
    }
}

extension MainPostTabViewController: PageboyViewControllerDataSource,TMBarDataSource{
   
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        
        if index == 0 {
            Dataholder.shared.showAllPost = false
        }
        else  {
            Dataholder.shared.showAllPost = true
        }
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        titles = ["My Posts", "All Posts"]
        return TMBarItem(title: titles[index])
    }
}
