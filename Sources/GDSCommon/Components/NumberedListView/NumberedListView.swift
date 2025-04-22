import UIKit

public final class NumberedListView: UIView {
    let viewModel: ListViewModel
    
    public init(viewModel: ListViewModel, frame: CGRect = .zero) {
        self.viewModel = viewModel
        super.init(frame: frame)
        setUp()
    }
    
    @available(*, unavailable, renamed: "init(viewModel:)")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
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
        return result
    }()
    
    private lazy var titleLabel: UILabel = {
        let result = UILabel()
        if let title = viewModel.title {
            result.text = title.value
            result.font = viewModel.titleConfig?.font
            result.adjustsFontForContentSizeCategory = true
            result.textAlignment = .left
            result.numberOfLines = 0
            if let isHeader = viewModel.titleConfig?.isHeader,
               isHeader {
                result.accessibilityTraits = [.header]
            }
        } else {
            result.isHidden = true
        }
        result.accessibilityIdentifier = "numbered-list-title"
        return result
    }()
    
    private lazy var listStackView: UIStackView = {
        let result = UIStackView(
            views: listRows,
            spacing: 8,
            distribution: .fillProportionally
        )
        result.isLayoutMarginsRelativeArrangement = true
        result.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return result
    }()
    
    private lazy var listRows: [UIStackView] = {
        viewModel.listItemStrings
            .enumerated()
            .map { index, string in
                let indexIncremented = index + 1
                let listRowStack = UIStackView(
                    views: [
                        {
                            let number = UILabel()
                            number.text = "\(indexIncremented)."
                            number.font = .body
                            number.textAlignment = .right
                            number.adjustsFontForContentSizeCategory = true
                            number.widthAnchor.constraint(equalToConstant: maxNumberWidth).isActive = true
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
                listRowStack.isAccessibilityElement = true
                listRowStack.accessibilityLabel = {
                    let listLabel = "\(indexIncremented), \(string.value)"
                    return indexIncremented == 1 ?
                    "Numbered list, \(viewModel.listItemStrings.count) items. \(listLabel)"
                    : listLabel
                }()
                listRowStack.accessibilityIdentifier = "numbered-list-row-stack-view-\(index)"
                return listRowStack
            }
    }()
    
    private lazy var maxNumberWidth: CGFloat = {
        viewModel.listItemStrings
            .indices
            .map { index in
                let number = UILabel()
                number.text = "\(index + 1)."
                number.font = .body
                return number
            }
            .map(\UILabel.intrinsicContentSize.width)
            .max() ?? 0
    }()
}
