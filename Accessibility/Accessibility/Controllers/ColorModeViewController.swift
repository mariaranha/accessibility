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
    
    let colors = ["Azul", "Amarelo", "Preto", "Verde", "Vermelho", "Colorido"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension ColorModeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = colorsTableView.dequeueReusableCell(withIdentifier: "colorCell")
        
        cell?.textLabel?.text = colors[indexPath.row]
        
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
