//
//  ViewController.swift
//  viper-demo-post
//
//  Created by idris yıldız on 1.09.2022.
//

import UIKit
import JGProgressHUD
import YPImagePicker
import SwiftEventBus

class PostViewController: UIViewController {
    
    var postPresenter:ViewToPresenterPostProtocol?
    @IBOutlet weak var myTableView: UITableView!
    var posts = [PostModel]()
    var HUD : JGProgressHUD = JGProgressHUD(style: JGProgressHUDStyle.light)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        config()
    }
    
    func config() {
        postPresenter?.startFetchingPost()
        registerCell()
        SwiftEventBus.onMainThread(self, name:"reloadPost") { result in
            self.postPresenter?.startFetchingPost()
        }
    }
    
    func registerCell() {
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.rowHeight = UITableView.automaticDimension
        myTableView.estimatedRowHeight = 300
        myTableView.register(nib: PostTableViewCell.self, nibName: PostTableViewCell.reuseIdentifier, identifier: PostTableViewCell.reuseIdentifier)
    }
}

extension PostViewController:PresenterToViewPostProtocol{
    
    func onPostResponseSuccess(items: [PostModel]) {
        posts = items
        myTableView.reloadData()
    }
    
    func onPostResponseFailed(error: String) {
        showToastMessage(title: "Erorr", msg: error, color: .red)
    }
}

extension PostViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.myTableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath) as! PostTableViewCell
        cell.selectionStyle = .none
        cell.config(item: posts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
