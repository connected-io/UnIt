import UIKit

class OverlapViewController: UIViewController {
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var overlappedTableViewLabel: UILabel!
    
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var royalBlueView: UIView!
    
    let canadianCities = ["Mississauga", "Toronto", "Montreal", "Ottawa", "Calgary", "Vancouver"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell")
    }
}

extension OverlapViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return canadianCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        cell.textLabel?.text = canadianCities[indexPath.row]
        return cell
    }
}
