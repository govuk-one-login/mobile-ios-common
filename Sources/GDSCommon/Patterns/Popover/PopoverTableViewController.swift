import Foundation
import UIKit

/// View Controller for the `PopoverTableView` storyboard XIB
/// This screen includes the following views:
///   - `tableView` (type: `UITableView`)
/// This screen provides a list of options for the user, in a popover view.
public final class PopoverTableViewController: UIViewController {
    
    /// tableView label: ``UITableView``
    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.accessibilityIdentifier = "table-view"
        }
    }
    
    var itemsViewModel: [PopoverItemViewModel] = []
    
    /// Initialiser for the `PopoverTableView` view controller.
    /// Requires a single parameter.
    /// - Parameter items: `[PopoverItemViewModel]`
    public init(items: [PopoverItemViewModel]) {
        self.itemsViewModel = items
        super.init(nibName: "PopoverTableView", bundle: .module)
    }
    
    @available(*, unavailable, renamed: "init(viewModel:)")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLayoutSubviews() {
        setContentSize()
    }
    
    // Ensuring that the popover updates in size to accomodate for dynamic type
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setContentSize()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PopoverTableViewCell", bundle: .module), forCellReuseIdentifier: "PopoverTableViewCellIdentifier")
    }
    
    private func setContentSize() {
        self.preferredContentSize = CGSize(width: self.view.frame.width, height: tableView.contentSize.height)
    }
}

extension PopoverTableViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsViewModel.count
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true)
        itemsViewModel[indexPath.row].action()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = itemsViewModel[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PopoverTableViewCellIdentifier", for: indexPath) as? PopoverTableViewCell else { return UITableViewCell() }
        cell.setupView(item: item)
        return cell
    }
}
