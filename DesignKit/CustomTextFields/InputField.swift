//
//  InputField.swift
//  DesignKit
//
//  Created by ho yin Chan on 9/10/2021.
//

import UIKit

public class InputField: UITextField {
    private enum Dimen {
        static let roundedCornerRadius: CGFloat = 12
        static let textFieldVerticalPadding: CGFloat = 4
        static let textFieldHorizontalPadding: CGFloat = 8
    }

    let padding = UIEdgeInsets(
        top: Dimen.textFieldVerticalPadding,
        left: Dimen.textFieldHorizontalPadding,
        bottom: Dimen.textFieldVerticalPadding,
        right: Dimen.textFieldHorizontalPadding
    )

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        layer.cornerRadius = Dimen.roundedCornerRadius
    }
}
