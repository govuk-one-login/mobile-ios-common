import GDSCommon
import UIKit

class DemoViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
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
        self.navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "ellipsis.circle"),
                                                       style: .plain,
                                                       target: self,
                                                       action: #selector(openDetailView(_:)))
    }
    
    @objc func openDetailView(_ sender: Any) {
        let mockItem = MockPopoverItemViewModel(title: "First Item",
                                                titleFont: .body,
                                                icon: "1.circle",
                                                tint: .accent) {
            print("first item tapped")
        }
        
        let mockItem2 = MockPopoverItemViewModel(title: "Second Item",
                                                titleFont: .body,
                                                icon: "2.circle",
                                                tint: .accent) {
            print("second item tapped")
        }
        let vc = PopoverTableViewController(items: [mockItem, mockItem2] )
        vc.modalPresentationStyle = .popover
        
        let presentationController = vc.popoverPresentationController
        presentationController?.permittedArrowDirections = .any
        presentationController?.delegate = self
        presentationController?.sourceView = sender as? UIView
        presentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
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
