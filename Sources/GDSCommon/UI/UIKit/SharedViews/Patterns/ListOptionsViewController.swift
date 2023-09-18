import UIKit

public final class ListOptionsViewController: UIViewController {
    public override var nibName: String? { "ListOptions" }
    let viewModel: ListOptionsViewModel
    
    public init(viewModel: ListOptionsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "ListOptions", bundle: .module)
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
        setBackButtonTitle()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableViewList.redraw()
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableViewList.redraw()
    }
    
    @IBOutlet private var titleLabel: UILabel! {
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
    
    @IBOutlet private var primaryButton: RoundedButton! {
        didSet {
            primaryButton.setTitle(viewModel.buttonViewModel.title, for: .normal)
            primaryButton.accessibilityIdentifier = "primaryButton"
        }
    }
    
    @IBAction private func primaryButton(_ sender: Any) {
        guard let selectedIndex = tableViewList.indexPathForSelectedRow,
              let cell = tableViewList.cellForRow(at: selectedIndex) as? ListTableViewCell else { return }
        
        viewModel.resultAction(cell.gdsLocalisedString)
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
        cell.selectionStyle = .none
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
