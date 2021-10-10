//
//  WayPointView.swift
//  WayPointJourney
//
//  Created by ho yin Chan on 9/10/2021.
//

import DesignKit
import UIKit
import SnapKit

enum WayPointViewType {
    case pickUp
    case dropOff
}

protocol WayPointViewDelegate: AnyObject {
    func wayPointViewDidBeginEditing(view: WayPointView, viewType: WayPointViewType)
}

class WayPointView: UIView {
    // Dimen
    private enum Dimen {
        static let wayPointLogoImageViewSize: CGFloat = 20
        static let horizontalStackSpacing: CGFloat = 20
        static let textFieldHeight: CGFloat = 40
        static let sparateLineHeight: CGFloat = 15
        static let separateLineWidth: CGFloat = 1
    }

    // MARK: Properties
    weak var delegate: WayPointViewDelegate?

    lazy var wayPointLogoImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()

    lazy var upperVerticalLine: UIView = {
        let view = UIView()
        return view
    }()

    lazy var lowerVerticalLine: UIView = {
        let view = UIView()
        return view
    }()

    lazy var inputField: InputField = {
        let textField = InputField()
        textField.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)
        textField.addTarget(
            self,
            action: #selector(inputFieldDidBeginEditing),
            for: .editingDidBegin
        )
        return textField
    }()

    lazy var verticalStack: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                upperVerticalLine,
                wayPointLogoImageView,
                lowerVerticalLine
            ]
        )
        stack.axis = .vertical
        stack.alignment = .center
        return stack
    }()

    lazy var horizontalStack: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                verticalStack,
                inputField
            ]
        )
        stack.spacing = Dimen.horizontalStackSpacing
        stack.alignment = .center
        return stack
    }()

    let configuration: Configurable

    let wayPointType: WayPointViewType

    // MARK: Object Cycle
    init(
        configuration: Configurable,
        wayPointType: WayPointViewType,
        delegate: WayPointViewDelegate?
    ) {
        self.configuration = configuration
        self.wayPointType = wayPointType
        self.delegate = delegate
        super.init(frame: .zero)
        setupLayout()
        setFontsAndColors()
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // UI methods
    func setupLayout() {
        addSubview(horizontalStack)
        horizontalStack.snp.makeConstraints { $0.edges.equalToSuperview() }
        [upperVerticalLine, lowerVerticalLine].forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(Dimen.sparateLineHeight)
                make.width.equalTo(Dimen.separateLineWidth)
            }
        }
        inputField.snp.makeConstraints { make in
            make.height.equalTo(Dimen.textFieldHeight)
        }
        wayPointLogoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(Dimen.wayPointLogoImageViewSize)
        }
        verticalStack.snp.makeConstraints { $0.width.equalTo(Dimen.wayPointLogoImageViewSize) }
    }

    func configure() {
        let stringProvider = configuration.stringProvider
        switch wayPointType {
        case .pickUp:
            wayPointLogoImageView.image = UIImage(assetIdentifier: .pickUp)
            inputField.placeholder = stringProvider.selectPickUpPointString()
            upperVerticalLine.alpha = 0
        case .dropOff:
            wayPointLogoImageView.image = UIImage(assetIdentifier: .dropOff)
            inputField.placeholder = stringProvider.selectDropOffPointString()
            lowerVerticalLine.alpha = 0
        }
    }

    func setFontsAndColors() {
        let colorLayout = configuration.layout.colorLayout
        [upperVerticalLine, lowerVerticalLine].forEach {
            $0.backgroundColor = colorLayout.separateLineColor
        }
        inputField.backgroundColor = colorLayout.textFieldBackgroundColor
    }

    // MARK: selectors
    @objc func inputFieldDidBeginEditing() {
        delegate?.wayPointViewDidBeginEditing(
            view: self,
            viewType: wayPointType
        )
    }
}
