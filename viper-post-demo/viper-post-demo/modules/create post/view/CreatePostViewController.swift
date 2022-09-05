//
//  CreatePostViewController.swift
//  viper-post-demo
//
//  Created by idris yıldız on 5.09.2022.
//

import UIKit
import YPImagePicker

class CreatePostViewController: UIViewController {
    
    var postPresenter:ViewToPresenterPostProtocol?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var postImage: UIImageView!
    var user = Dataholder.shared.currentUser
    var isPhotoSelected = false

    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    func config()
    {
        name.text = user.name
        nickName.text = user.nickName
        photo.image = UIImage(named:user.photoUrl)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(onSelectPostPhoto))
        tap.cancelsTouchesInView = false
        postImage.addGestureRecognizer(tap)
        postImage.isUserInteractionEnabled = true
        
        content.becomeFirstResponder()
    }
    
    @objc func onSelectPostPhoto()
    {
        selecImageSections()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "Create New Post"
    }
    
    @IBAction func onSendPost(_ sender: Any) {
        if !content.text!.isEmpty && isPhotoSelected {
            let post =  PostModel(
                id: "121",
                ownerUser: user,
                name: "Lorem Ipsum is simply dummy text",
                des: content.text!,
                photoUrl: "post",
                likedCount: 2,
                commentCount: 8,
                sharedCount: 12,
                seenCount: 3)
            post.photo = postImage.image
            self.postPresenter?.addPost(item:post)
            self.dismiss(animated: true)
        }
    }
}




extension CreatePostViewController
{
    func selecImageSections()
    {
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title:  "Cancel", style: .cancel) { _ in
            
        }
        actionSheetController.addAction(cancelActionButton)
        
        let camera = UIAlertAction(title: "Camera", style: .default)
        { _ in
            self.selectImage(screens: 1)
        }
        actionSheetController.addAction(camera)
        
        
        let gallery = UIAlertAction(title: "Gallery", style: .default)
        { _ in
            self.selectImage(screens: 2)
        }
        actionSheetController.addAction(gallery)
        
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    func selectImage(screens: Int) {
        
        var config = YPImagePickerConfiguration()
        config.albumName = "TAHTA"
        config.startOnScreen = .photo
        
        if screens == 1 {
            config.screens = [.photo]
        }else if screens == 2{
            config.screens = [.library]
        }
        
        config.showsCrop = .rectangle(ratio: 1)
        config.onlySquareImagesFromCamera = false
        config.hidesStatusBar = false
        config.colors.tintColor = StyleManager.colors.colorPrimary
        config.colors.albumBarTintColor  = StyleManager.colors.colorPrimary
        config.colors.albumTintColor = StyleManager.colors.colorPrimary
        
        let picker = YPImagePicker(configuration: config)
        picker.navigationBar.tintColor = StyleManager.colors.colorPrimary
        picker.didFinishPicking { [unowned picker] items, cancelled in
            if let photo = items.singlePhoto {
                self.postImage.image = photo.image
                self.isPhotoSelected = true
            }
            picker.dismiss(animated: true)
        }
        picker.modalPresentationStyle = .fullScreen
        present(picker, animated: true)
    }
}

