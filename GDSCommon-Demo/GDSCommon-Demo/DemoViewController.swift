import GDSCommon
import UIKit

class DemoViewController: UIViewController {
    
    let tableview: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.systemBackground
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        self.navigationController?.navigationItem.title = "Demo App"
    }

    func setupTableView() {
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
        view.addSubview(tableview)
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableview.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableview.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
    }
}

extension DemoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Screens.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        var content = cell.defaultContentConfiguration()
        content.text = Screens.allCases[indexPath.row].rawValue
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let screen = Screens.allCases[indexPath.row]
        if screen.isModal {
            let navigationController = UINavigationController()
            let viewController = screen.create(in: navigationController)
            navigationController
                .pushViewController(viewController, animated: false)
            self.navigationController?
                .present(navigationController, animated: true)
        } else if let navigationController {
            let viewController = screen.create(in: navigationController)
            navigationController
                .pushViewController(viewController, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
