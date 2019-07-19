import UIKit

class TwoListViewController: UIViewController {
    
    @IBOutlet var nestedCollectionView: UICollectionView!
    @IBOutlet var tableView: UITableView!
    
    let players = ["Federer", "Roddick", "Murray", "Isner", "Blake", "Hewitt"]
    
    let foods = ["Pizza", "Burger", "Lasagna", "Lentil soup", "Philly steak", "Orange chicken"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCollectionView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell")
    }
    
    private func setupCollectionView() {
        nestedCollectionView.dataSource = self
    }
}

extension TwoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell")
        tableViewCell?.textLabel?.text = foods[indexPath.row]
        return tableViewCell!
    }
}

extension TwoListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstCollectionView", for: indexPath) as! FirstCollectionViewCell
        return collectionViewCell
    }
}
