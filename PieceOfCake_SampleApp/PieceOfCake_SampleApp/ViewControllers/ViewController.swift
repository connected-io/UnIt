import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var firstCollectionView: UICollectionView!
    @IBOutlet weak var torontoLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    
    let statesOfUSAArray = ["Alaska",
                            "Alabama",
                            "Arkansas",
                            "American Samoa",
                            "Arizona",
                            "California",
                            "Colorado",
                            "Connecticut",
                            "District of Columbia",
                            "Delaware",
                            "Florida",
                            "Georgia",
                            "Guam",
                            "Hawaii",
                            "Iowa",
                            "Idaho",
                            "Illinois",
                            "Indiana",
                            "Kansas",
                            "Kentucky",
                            "Louisiana",
                            "Massachusetts",
                            "Maryland",
                            "Maine",
                            "Michigan",
                            "Minnesota",
                            "Missouri",
                            "Mississippi",
                            "Montana",
                            "North Carolina",
                            " North Dakota",
                            "Nebraska",
                            "New Hampshire",
                            "New Jersey",
                            "New Mexico",
                            "Nevada",
                            "New York",
                            "Ohio",
                            "Oklahoma",
                            "Oregon",
                            "Pennsylvania",
                            "Puerto Rico",
                            "Rhode Island",
                            "South Carolina",
                            "South Dakota",
                            "Tennessee",
                            "Texas",
                            "Utah",
                            "Virginia",
                            "Virgin Islands",
                            "Vermont",
                            "Washington",
                            "Wisconsin",
                            "West Virginia",
                            "Wyoming"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        torontoLabel.text = "Montreal."
    }

    // MARK: Setup
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell")
    }
    
    private func setupCollectionView() {
        firstCollectionView.dataSource = self
    }
    
    // Mark: Actions
    @IBAction func leftButtonTapped(_ sender: Any) {
        let nibViewController = NibViewController(nibName: "NibViewController", bundle: nil)
        self.present(nibViewController, animated: true, completion: nil)
    }
    
    @IBAction func rightButtonTapped(_ sender: Any) {
        let viewController = ConstraintBreakViewController(nibName: "ConstraintBreakViewController", bundle: nil)
        self.present(viewController, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statesOfUSAArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell")
        tableViewCell?.textLabel?.text = statesOfUSAArray[indexPath.row]
        return tableViewCell!
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstCollectionView", for: indexPath) as! FirstCollectionViewCell
        return collectionViewCell
    }
}

