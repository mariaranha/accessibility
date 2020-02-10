//
//  ProfileViewController.swift
//  Accessibility
//
//  Created by Julia Conti Mestre on 03/02/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import Foundation
import UIKit

class ColorModeViewController: UIViewController {
    
    @IBOutlet weak var colorsTableView: UITableView!

    var colors: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.colors = getColors()
        let viewControllerTitle = NSLocalizedString("Color Mode",
                                                           comment: "This represents the title of a view controller a color mode setting")
        self.navigationController?.navigationBar.topItem?.titleView?.largeContentTitle = viewControllerTitle
    }
    
    private func getColors() -> [String] {
            // Returns colors array based on user location
            
            if let locale = NSLocale.current.languageCode {
                switch locale {
                case "pt":
                    return ["Azul", "Amarelo", "Preto", "Verde", "Vermelho", "Colorido"]
                case "en":
                    return ["Blue", "Yellow", "Black", "Green", "Red", "Colorful"]
                default:
                    return ["Blue", "Yellow", "Black", "Green", "Red", "Colorful"]
                }
            }
            return ["Blue", "Yellow", "Black", "Green", "Red", "Colorful"]
        }
}

extension ColorModeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.colors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = colorsTableView.dequeueReusableCell(withIdentifier: "colorCell")
        
        cell?.textLabel?.text = self.colors[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            UserDefaultsStruct.CornerMode.color = .blue
        case 1:
            UserDefaultsStruct.CornerMode.color = .yellow
        case 2:
            UserDefaultsStruct.CornerMode.color = .black
        case 3:
            UserDefaultsStruct.CornerMode.color = .green
        case 4:
            UserDefaultsStruct.CornerMode.color = .red
        default:
            UserDefaultsStruct.CornerMode.color = .colorful
        }

    }
    
}
