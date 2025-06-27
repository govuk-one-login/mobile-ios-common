import UIKit

class InfoHeaderView: UIView {
    let viewModel: InfoHeaderViewModel
    
    private lazy var containerStackView: UIStackView = {
        let result = UIStackView(
            views: [
                titleLabel,
                subtitleLabel
            ],
            spacing: 0,
            distribution: .fill
        )
        result.accessibilityIdentifier = "information-screen-header-stackview"
        result.backgroundColor = viewModel.backgroundColor
        return result
    }()
    
    lazy var titleLabel: UILabel = {
        let result = UILabel()
        result.font = viewModel.titleFont
        result.text = viewModel.subtitle.value
        result.accessibilityIdentifier = "information-screen-header-title"
        result.adjustsFontForContentSizeCategory = true
        result.textAlignment = viewModel.alignment
        result.numberOfLines = 0
        return result
    }()
    
    lazy var subtitleLabel: UILabel = {
        let result = UILabel()
        result.font = viewModel.subtitleFont
        result.text = viewModel.subtitle.value
        result.accessibilityIdentifier = "information-screen-header-subtitle"
        result.adjustsFontForContentSizeCategory = true
        result.textAlignment = viewModel.alignment
        result.numberOfLines = 0
        return result
    }()
    
    
    public init(viewModel: InfoHeaderViewModel) {
        self.viewModel = viewModel
        super.init()
        
        self.addSubview(containerStackView)
        self.containerStackView.bindToSuperviewEdges()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
