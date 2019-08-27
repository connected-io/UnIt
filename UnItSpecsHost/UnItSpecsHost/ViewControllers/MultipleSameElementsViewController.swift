//
//  MultipleSameElementsViewController.swift
//  UnItSpecsHost
//
//  Created by cl-dev on 2019-08-22.
//  Copyright © 2019 cl-dev. All rights reserved.
//

import UIKit

class MultipleSameElementsViewController: UIViewController, UITableViewDataSource, UICollectionViewDataSource {
    
    @IBOutlet var labelCollection: [UILabel]!
    @IBOutlet var buttonCollection: [UIButton]!
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var tableView: UITableView!
    let dataSourceArray = ["Blue", "Red", "Blue", "Turquoise", "Yellow", "Blue", "Green"]
    override func viewDidLoad() {
        super.viewDidLoad()
        labelCollection.forEach { $0.textColor = UIColor.red }
        buttonCollection.forEach { $0.layer.cornerRadius = 5 }
        // Do any additional setup after loading the view.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        
        let nib = UINib.init(nibName: String(describing:LabelCollectionViewCell.self), bundle: Bundle.main)
        collectionView.register(nib, forCellWithReuseIdentifier: String(describing:LabelCollectionViewCell.self))
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        if (indexPath.item%2 == 0) {
            cell.textLabel?.font = UIFont.systemFont(ofSize: 11)
        }
        cell.textLabel?.text = dataSourceArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArray.count
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing:LabelCollectionViewCell.self), for: indexPath) as! LabelCollectionViewCell
        if (indexPath.item%2 == 0) {
            cell.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        }
        cell.configure(with: dataSourceArray[indexPath.row])
        return cell
        
    }

}
