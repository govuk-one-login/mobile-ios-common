import UIKit

/// View controller for `GDSListOptions` screen.
///   - `titleLabel` (type: `UILabel`)
///   - `bodyLabel` (type: `UILabel`)
///   - `stackView` (type: `UIStackView`)
///   - `tableTitleLabel` (type: `UILabel`)
///   - `tableViewList` (type: `UITableView`)
///   - `footerLabel` (type: `UILabel`)
///   - `primaryButton`  (type: ``RoundedButton`` inherits from SecondaryButton)
///   - `secondaryButton`  (type: ``SecondaryButton`` inherits from ``UIButton``)
///
/// Two navigation items can be configured:
/// - Back button via setting the `hideBackButton` boolean property on the view controller
/// - Right bar button can be configured by setting the optional `rightBarButtonTitle` view
/// model property to the required title. If this is set to `nil` then the button is not visible.
/// The action can be customised by configuring the `didDismiss` method.
/// `footerLabel` is configured separately from the `UITableView` to address some
/// dynamic type issues with multi-line footers.
public final class GDSListOptionsViewController: BaseViewController, TitledViewController {
    public override var nibName: String? { "GDSListOptions" }
    public let viewModel: GDSListOptionsViewModel

    public init(viewModel: GDSListOptionsViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel as? BaseViewModel, nibName: "GDSListOptions", bundle: .module)
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
            titleLabel.accessibilityIdentifier = "list-title-label"
        }
    }
    
    @IBOutlet private var bodyLabel: UILabel! {
        didSet {
            bodyLabel.text = viewModel.body?.value
            bodyLabel.font = .body
            bodyLabel.isHidden = viewModel.body == nil
            bodyLabel.accessibilityIdentifier = "list-body-label"
        }
    }
    
    @IBOutlet private var stackView: UIStackView! {
        didSet {
            stackView.accessibilityIdentifier = "list-child-stack-view"
            
            if let childView = viewModel.childView {
                stackView.addArrangedSubview(childView)
            } else {
                stackView.isHidden = true
            }
        }
    }
    @IBOutlet private var tableTitleLabel: UILabel! {
        didSet {
            tableTitleLabel.font = UIFont.bodyBold
            tableTitleLabel.accessibilityIdentifier = "list-tabel-title"
            tableTitleLabel.text = viewModel.listTitle?.value
        }
    }
    @IBOutlet private var tableViewList: UITableView! {
        didSet {
            tableViewList.accessibilityIdentifier = "list-table-view"
        }
    }
    
    @IBOutlet private var footerLabel: UILabel! {
        didSet {
            footerLabel.text = viewModel.listFooter?.value
            footerLabel.font = .footnote
            footerLabel.textColor = .secondaryLabel
            footerLabel.accessibilityIdentifier = "list-footer-label"
            footerLabel.isHidden = viewModel.listFooter == nil
        }
    }
    
    @IBOutlet private var primaryButton: RoundedButton! {
        didSet {
            primaryButton.setTitle(viewModel.buttonViewModel.title, for: .normal)
            primaryButton.accessibilityIdentifier = "list-primary-button"
            primaryButton.isEnabled = false
        }
    }
    
    @IBAction private func primaryButton(_ sender: Any) {
        guard let selectedIndex = tableViewList.indexPathForSelectedRow,
              let cell = tableViewList.cellForRow(at: selectedIndex) as? ListTableViewCell else { return }
        
        viewModel.resultAction(cell.gdsLocalisedString)
        viewModel.buttonViewModel.action()
    }
    
    @IBOutlet private var secondaryButton: SecondaryButton! {
        didSet {
            secondaryButton.accessibilityIdentifier = "list-secondary-button"
            if let buttonViewModel = viewModel.secondaryButtonViewModel {
                secondaryButton.titleLabel?.textAlignment = .center
                secondaryButton.setTitle(buttonViewModel.title, for: .normal)
                secondaryButton.isHidden = false
                
                if let icon = viewModel.secondaryButtonViewModel?.icon {
                    secondaryButton.symbolPosition = icon.symbolPosition
                    secondaryButton.icon = icon.iconName
                }
            } else {
                secondaryButton.isHidden = true
            }
        }
    }
    
    @IBAction private func didTapSecondaryButton(_ sender: Any) {
        if let buttonViewModel = viewModel.secondaryButtonViewModel {
            buttonViewModel.action()
        }
    }
}


extension GDSListOptionsViewController: UITableViewDataSource {
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

extension GDSListOptionsViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewWillLayoutSubviews()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        primaryButton.isEnabled = true
    }
}
