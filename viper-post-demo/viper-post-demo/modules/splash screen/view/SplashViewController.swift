//
//  SplashViewController.swift
//  viper-demo-post
//
//  Created by idris yıldız on 2.09.2022.
//

import UIKit

class SplashViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let vc:MainPostTabViewController = UIStoryboard.Main.instantiateViewController(withIdentifier: "MainPostTabViewController") as! MainPostTabViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
