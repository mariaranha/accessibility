//
//  SportMatchesViewController.swift
//  Accessibility
//
//  Created by Julia Conti Mestre on 31/01/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import UIKit

class SportMatchesViewController: UIViewController {
    
    @IBOutlet weak var matchesTableView: UITableView!
    
    //Navigation bar title - CHANGE
    var sportTitle: String = "Boxe"
    
    //Card View Model
    var cardsViewModel: [CardView.ViewModel] = []
    
    //Sport Matches Presenter
    private let presenter = SportMatchesPresenter()
    
    var emptyFlag = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        cardsViewModel = presenter.formatCards()
        matchesTableView.reloadData()
        
        let nib = UINib.init(nibName: "CardView", bundle: nil)
        self.matchesTableView.register(nib, forCellReuseIdentifier: "cardView")
        
        emptyFlag = UIImage(named: "empty-flag") ?? UIImage()
        
        //Changing status bar color
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
            navBarAppearance.backgroundColor = UIColor.white
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
        
        //Removing line in navigation bar
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //Navigatin Bar Title
        self.title = sportTitle
    }
}


extension SportMatchesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return matchTitle.count
        return cardsViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = matchesTableView.dequeueReusableCell(withIdentifier: "cardCell") as? CardTableViewCell else { return UITableViewCell() }

        let viewModel = cardsViewModel[indexPath.row]
        
        cell.configure(with: viewModel)

        return cell
    }
    
}
