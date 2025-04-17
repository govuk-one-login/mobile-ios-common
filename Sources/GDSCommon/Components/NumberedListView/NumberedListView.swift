import UIKit

public final class NumberedListView: UIView {
    let viewModel: NumberedListViewModel
    
    public init(viewModel: NumberedListViewModel, frame: CGRect = .zero) {
        self.viewModel = viewModel
        super.init(frame: frame)
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
        if let title = viewModel.title {
            result.text = title.value
            result.font = viewModel.titleFont
            result.adjustsFontForContentSizeCategory = true
            result.textAlignment = .left
            result.numberOfLines = 0
            result.accessibilityTraits = [.header]
        } else {
            result.isHidden = true
        }
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
                let listRowStack = UIStackView(
                    views: [
                        {
                            let number = UILabel()
                            number.text = "\(index + 1)."
                            number.font = .body
                            number.textAlignment = .right
                            number.adjustsFontForContentSizeCategory = true
                            number.widthAnchor.constraint(equalToConstant: viewModel.maxNumberWidth).isActive = true
                            return number
                        }(),
                        {
                            let content = UILabel()
                            content.font = .body
                            if let attributedString = string.attributedValue {
                                content.attributedText = attributedString
                            } else {
                                content.text = string.value
                            }
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
                listRowStack.accessibilityIdentifier = "numbered-list-row-stack-view-\(index)"
                return listRowStack
            }
    }()
}
