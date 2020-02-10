//
//  TabBarViewController.swift
//  Accessibility
//
//  Created by Matheus Oliveira on 10/02/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let items = tabBar.items else { return }

        items[0].title = NSLocalizedString("Home", comment: "This represents the home item at the tab bar")
        items[1].title = NSLocalizedString("Sports", comment: "This represents the sports item at the tab bar")
        items[2].title = NSLocalizedString("Rankings", comment: "This represents the rankings item at the tab bar")
        items[3].title = NSLocalizedString("Profile", comment: "This represents the profile item at the tab bar")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
