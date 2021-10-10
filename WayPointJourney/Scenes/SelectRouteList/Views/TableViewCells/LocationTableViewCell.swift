//
//  LocationTableViewCell.swift
//  WayPointJourney
//
//  Created by ho yin Chan on 9/10/2021.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    // MARK: Dimen
    private enum Dimen {
        static let cellHorizontalPadding: CGFloat = 16
        static let cellVerticalPadding: CGFloat = 12
        static let horizontalStackSpacing: CGFloat = 12
        static let imageViewSize: CGFloat = 22
    }

    // MARK: Properties
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var detailLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var verticalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, detailLabel])
        stack.alignment = .leading
        stack.axis = .vertical
        return stack
    }()

    lazy var horizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [logoImageView, verticalStack])
        stack.alignment = .center
        stack.spacing = Dimen.horizontalStackSpacing
        return stack
    }()

    // MARK: Object cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: UI Methods
    func setupLayout() {
        contentView.addSubview(horizontalStack)
        horizontalStack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Dimen.cellVerticalPadding)
            make.leading.trailing.equalToSuperview().inset(Dimen.cellHorizontalPadding)
        }
        logoImageView.snp.makeConstraints { $0.width.height.equalTo(Dimen.imageViewSize) }
    }

    func configure(
        with configuration: Configurable,
        displayItem: SelectRouteList.LocationDisplayItem
    ) {
        titleLabel.text = displayItem.title
        detailLabel.text = displayItem.detail
        logoImageView.image = displayItem.logoImage

        let colorLayout = configuration.layout.colorLayout
        let fontLayout = configuration.layout.fontLayout
        titleLabel.font = fontLayout.title1
        titleLabel.textColor = colorLayout.black
        detailLabel.font = fontLayout.title2
        detailLabel.textColor = colorLayout.lightGrey
    }
}
