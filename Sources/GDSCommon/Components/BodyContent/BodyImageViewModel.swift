import UIKit

public struct BodyImageViewModel: ScreenBodyItem {
    let image: UIImage
    private var aspectRatio: CGFloat {
        image.size.height / image.size.width
    }

    public let horizontalPadding: CGFloat?
    
    public init(
        image: UIImage,
        horizontalPadding: CGFloat? = 0
    ) {
        self.image = image
        self.horizontalPadding = horizontalPadding
    }
}

extension BodyImageViewModel {
    public var uiView: UIView {
        let result = UIImageView()
        result.image = image
        result.contentMode = .scaleAspectFit
        result.backgroundColor = .yellow

        NSLayoutConstraint.activate(
            [
                result.heightAnchor.constraint(equalTo: result.widthAnchor, multiplier: aspectRatio)
            ]
        )

        return result
    }
}
