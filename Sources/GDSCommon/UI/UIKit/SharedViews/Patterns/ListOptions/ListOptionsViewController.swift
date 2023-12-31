import UIKit

/// View controller for `ListOptions` screen.
///   - `titleLabel` (type: `UILabel`)
///   - `bodyLabel` (type: `UILabel`)
///   - `tableViewList` (type: `UITableView`)
///   - `footerLabel` (type: `UILabel`)
///   - `primaryButton`  (type: ``RoundedButton`` inherits from SecondaryButton)
///
/// Two navigation items can be configured:
/// - Back button via setting the `hideBackButton` boolean property on the view controller
/// - Right bar button can be configured by setting the optional `rightBarButtonTitle` view
/// model property to the required title. If this is set to `nil` then the button is not visible.
/// The action can be customised by configuring the `didDismiss` method.
/// `footerLabel` is configured separately from the `UITableView` to address some
/// dynamic type issues with multi-line footers.
public final class ListOptionsViewController: BaseViewController, TitledViewController {
    public override var nibName: String? { "ListOptions" }
    public let viewModel: ListOptionsViewModel

    public init(viewModel: ListOptionsViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel as? BaseViewModel, nibName: "ListOptions", bundle: .module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewList.register(ListTableViewCell.self, forCellReuseIdentifier: "listTableViewCell")
        tableViewList.dataSource = self
        tableViewList.delegate = self
        tableViewList.isScrollEnabled = false
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableViewList.redraw()
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableViewList.redraw()
    }

    @IBOutlet private(set) var titleLabel: UILabel! {
        didSet {
            titleLabel.text = viewModel.title.value
            titleLabel.font = .largeTitleBold
            titleLabel.accessibilityTraits = .header
            titleLabel.accessibilityIdentifier = "titleLabel"
        }
    }
    
    @IBOutlet private var bodyLabel: UILabel! {
        didSet {
            bodyLabel.text = viewModel.body
            bodyLabel.font = .body
            bodyLabel.isHidden = viewModel.body == nil
            bodyLabel.accessibilityIdentifier = "bodyLabel"
        }
    }
    
    @IBOutlet private var tableViewList: UITableView! {
        didSet {
            tableViewList.accessibilityIdentifier = "tableViewList"
        }
    }
    
    @IBOutlet private var footerLabel: UILabel! {
        didSet {
            footerLabel.text = viewModel.listFooter
            footerLabel.font = .footnote
            footerLabel.textColor = .secondaryLabel
            footerLabel.accessibilityIdentifier = "footerLabel"
            footerLabel.isHidden = viewModel.listFooter == nil
        }
    }
    
    @IBOutlet private var primaryButton: RoundedButton! {
        didSet {
            primaryButton.setTitle(viewModel.buttonViewModel.title, for: .normal)
            primaryButton.accessibilityIdentifier = "primaryButton"
            primaryButton.isEnabled = false
        }
    }
    
    @IBAction private func primaryButton(_ sender: Any) {
        guard let selectedIndex = tableViewList.indexPathForSelectedRow,
              let cell = tableViewList.cellForRow(at: selectedIndex) as? ListTableViewCell else { return }
        
        viewModel.resultAction(cell.gdsLocalisedString)
        viewModel.buttonViewModel.action()
    }
}


extension ListOptionsViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.listRows.count
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let descriptor = viewModel.listRows[indexPath.row]
        let cell = ListTableViewCell(gdsLocalisedString: descriptor)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        cell.selectionStyle = .none
        cell.textLabel?.textColor = .label
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}

extension ListOptionsViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewWillLayoutSubviews()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        primaryButton.isEnabled = true
    }
}
