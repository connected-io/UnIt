//
//  NibTopViewController.swift
//  pieceofcake
//
//  Created by cl-dev on 2019-01-03.
//  Copyright © 2019 cl-dev. All rights reserved.
//

import UIKit

class NibTopViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let someBrazilStates = ["Acre", "Alagoas", "Amazonas", "Amapá", "Bahia", "Ceará", "Distrito Federal", "Espírito Santo", "Goiás", "Maranhão", "Minas Gerais", "Mato Grosso do Sul", "Mato Grosso", "Pará", "Paraíba", "Pernambuco"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("nibTop: viewDidLoad")
        collectionView.register(UINib.init(nibName: "LabelCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LabelCollectionViewCell")
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NSLog("nibTop: viewWillAppear:")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NSLog("nibTop: viewDidAppear:")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NSLog("nibTop: viewWillDisappear:")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NSLog("nibTop: viewDidDisappear:")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        NSLog("nibTop: viewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLog("nibTop: viewDidLayoutSubviews")
    }
}

extension NibTopViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LabelCollectionViewCell", for: indexPath) as! LabelCollectionViewCell
        cell.configure(with: someBrazilStates[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return someBrazilStates.count
    }
}
