//
//  SplashScreen.swift
//  MoneyTracker
//
//  Created by TechExtensor PVT LTD on 27/04/23.
//

import UIKit

class SplashScreen: UIViewController {
    var userInfo:[User] = []
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        userInfo = DBManager.getAllUsers()
        
        if !userInfo.isEmpty {
//            DispatchQueue.main.async {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                self.navigationController?.pushViewController(vc, animated: true)
//            }
        }
        else{
//            DispatchQueue.main.async {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                self.navigationController?.pushViewController(vc, animated: true)
         //   }
        }
    }
        
    }

        
    

  
