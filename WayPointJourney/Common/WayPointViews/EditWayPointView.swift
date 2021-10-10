//
//  EditWayPointView.swift
//  WayPointJourney
//
//  Created by ho yin Chan on 9/10/2021.
//

import UIKit
import Models

class EditWayPointView: UIView {
    // MARK: Properties
    lazy var startWayPointView: WayPointView = {
        let startWayPointView = WayPointView(
            configuration: configuration,
            wayPointType: .pickUp,
            delegate: delegate
        )
        return startWayPointView
    }()

    lazy var endWayPointView: WayPointView = {
        let endWayPointView = WayPointView(
            configuration: configuration,
            wayPointType: .dropOff,
            delegate: delegate
        )
        return endWayPointView
    }()

    lazy var overallStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [startWayPointView, endWayPointView])
        stack.axis = .vertical
        return stack
    }()

    let configuration: Configurable

    weak var delegate: WayPointViewDelegate?

    // MARK: Object cycle
    init(
        configuration: Configurable,
        delegate: WayPointViewDelegate?
    ) {
        self.configuration = configuration
        self.delegate = delegate
        super.init(frame: .zero)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: UI methods
    func setupLayout() {
        addSubview(overallStack)
        overallStack.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    func setFirstResponder(with type: WayPointViewType) {
        switch type {
        case .pickUp:
            startWayPointView.inputField.becomeFirstResponder()
            endWayPointView.isUserInteractionEnabled = false
        case .dropOff:
            endWayPointView.inputField.becomeFirstResponder()
            startWayPointView.isUserInteractionEnabled = false
        }
    }

    func setText(with type: WayPointViewType, locationName: String) {
        switch type {
        case .pickUp:
            startWayPointView.inputField.text = locationName
        case .dropOff:
            endWayPointView.inputField.text = locationName
        }
    }

    func setText(with wayPointInfo: [WayPointViewType: String]) {
        startWayPointView.inputField.text = wayPointInfo[.pickUp]
        endWayPointView.inputField.text = wayPointInfo[.dropOff]
    }
}
