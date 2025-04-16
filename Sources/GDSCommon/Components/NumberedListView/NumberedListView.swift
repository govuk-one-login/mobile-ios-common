import UIKit

public final class NumberedListView: UIView {
    let viewModel: NumberedListViewModel
    
    public init(viewModel: NumberedListViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setUp()
    }
    
    @available(*, unavailable, renamed: "init(viewModel:)")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        backgroundColor = .systemBackground
        addSubview(containerStackView)
        containerStackView.bindToSuperviewEdges()
    }
    
    private lazy var containerStackView: UIStackView = {
        let result = UIStackView(
            views: [
                titleLabel,
                listStackView
            ],
            spacing: 12,
            distribution: .fillProportionally
        )
        result.accessibilityIdentifier = "numbered-list-container-stack-view"
        return result
    }()
    
    private lazy var titleLabel: UILabel = {
        let result = UILabel()
        result.text = viewModel.title.value
        result.font = viewModel.titleFont
        result.adjustsFontForContentSizeCategory = true
        result.textAlignment = .left
        result.numberOfLines = 0
        result.accessibilityIdentifier = "numbered-list-title"
        return result
    }()
    
    private lazy var listStackView: UIStackView = {
        let result = UIStackView(
            views: listRows,
            spacing: 8
        )
        result.isLayoutMarginsRelativeArrangement = true
        result.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        result.accessibilityIdentifier = "numbered-list-stack-view"
        return result
    }()
    
    private lazy var listRows: [UIStackView] = {
        viewModel.listItemStrings
            .enumerated()
            .map { index, string in
                UIStackView(
                    views: [
                        {
                            let number = UILabel()
                            number.text = "\(index + 1)."
                            number.font = .body
                            number.textAlignment = .right
                            number.adjustsFontForContentSizeCategory = true
                            number.adjustsFontSizeToFitWidth = true
                            return number
                        }(),
                        {
                            let content = UILabel()
                            content.text = string.value
                            content.font = .body
                            content.numberOfLines = 0
                            content.textAlignment = .left
                            content.adjustsFontForContentSizeCategory = true
                            return content
                        }()
                    ],
                    axis: .horizontal,
                    spacing: 20,
                    alignment: .top,
                    distribution: .fillProportionally
                )
            }
    }()
}
