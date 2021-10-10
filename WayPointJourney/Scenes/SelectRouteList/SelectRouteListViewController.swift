//
//  SelectRouteListViewController.swift
//  GOGOXCodeChallenge
//
//  Created by ho yin Chan on 9/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Hero
import Models

protocol SelectRouteListViewControllerDelegate: AnyObject {
    func selectRouteListViewController(
        didTapBackButton controller: SelectRouteListViewController
    )
    func selectRouteListViewController(
        _ controller: SelectRouteListViewController,
        didSelect location: Location,
        type: WayPointViewType
    )
}

protocol SelectRouteListDisplayLogic: AnyObject {
    func displayInitViews(viewModel: SelectRouteList.InitViews.ViewModel)
    func displayTapBackButton(viewModel: SelectRouteList.TapBackButton.ViewModel)
    func displayFetchLocations(viewModel: SelectRouteList.FetchLocations.ViewModel)
    func displaySelectLocation(viewModel: SelectRouteList.SelectLocation.ViewModel)
}

class SelectRouteListViewController: BaseViewController {
    static let locationCellReuseId = "com.gogox.location.cell.reuse.id"

    // MARK: Dimen
    private enum Dimen {
        static let editWayPointContainerLeadingPadding: CGFloat = 20
        static let editWayPointContainerTrailingPadding: CGFloat = 48
        static let editWayPointContainerTopPadding: CGFloat = 16
        static let editWayPointContainerBottomPadding: CGFloat = 32
        static let separateLineHeight: CGFloat = 1
        static let separateLineShadowCornerRadius: CGFloat = 9
        static let overallStackSpacingAfterEditViews: CGFloat = 20
    }

    // MARK: Properties
    weak var delegate: SelectRouteListViewControllerDelegate?
    var interactor: SelectRouteListBusinessLogic?
    var router: (SelectRouteListRoutingLogic & SelectRouteListDataPassing)?
    let firstResponseWayPointType: WayPointViewType
    var locationDisplayItems = [SelectRouteList.LocationDisplayItem]() {
        didSet {
            tableView.reloadData()
        }
    }

    lazy var editWayPointViewContainer: UIView = {
        let view = UIView()
        return view
    }()

    lazy var heroAnimationContainer: UIView = {
        let view = UIView()
        view.heroID = "hero.id.editWayPointView"
        return view
    }()

    lazy var editWayPointView: EditWayPointView = {
        let view = EditWayPointView(
            configuration: configuration,
            delegate: nil
        )
        return view
    }()

    lazy var separateLine: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = Dimen.separateLineShadowCornerRadius
        return view
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            LocationTableViewCell.self,
            forCellReuseIdentifier: SelectRouteListViewController.locationCellReuseId
        )
        return tableView
    }()

    lazy var overallStack: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                editWayPointViewContainer,
                separateLine,
                tableView
            ])
        stack.setCustomSpacing(
            Dimen.overallStackSpacingAfterEditViews,
            after: editWayPointViewContainer
        )
        stack.axis = .vertical
        return stack
    }()

    // MARK: Object cycle
    init(
        firstResponseWayPointType: WayPointViewType,
        configuration: Configurable
    ) {
        self.firstResponseWayPointType = firstResponseWayPointType
        super.init(configuration: configuration)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setFontsAndColors()
        setNavigationItems()
        editWayPointView.setFirstResponder(with: firstResponseWayPointType)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.requestInitViews(request: SelectRouteList.InitViews.Request())
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor?.requestFetchLocations(request: SelectRouteList.FetchLocations.Request())
    }

    // MARK: UI methods
    func setNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(assetIdentifier: .back).withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(backButtonDidTap)
        )
    }

    func setupLayout() {
        editWayPointViewContainer.addSubview(heroAnimationContainer)
        heroAnimationContainer.addSubview(editWayPointView)
        view.addSubview(overallStack)
        heroAnimationContainer.snp.makeConstraints { $0.edges.equalToSuperview() }
        editWayPointView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Dimen.editWayPointContainerLeadingPadding)
            make.trailing.equalToSuperview().inset(Dimen.editWayPointContainerTrailingPadding)
            make.top.bottom.equalToSuperview()
        }
        separateLine.snp.makeConstraints { make in
            make.height.equalTo(Dimen.separateLineHeight)
        }
        overallStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    func setFontsAndColors() {
        let colorLayout = configuration.layout.colorLayout
        separateLine.backgroundColor = colorLayout.separateLineColor2
        editWayPointView.backgroundColor = colorLayout.white
    }

    // MARK: Selectors
    @objc func backButtonDidTap() {
        view.endEditing(true)
        interactor?.requestTapBackButton(request: SelectRouteList.TapBackButton.Request())
    }
}

// MARK: - SelectRouteListDisplayLogic
extension SelectRouteListViewController: SelectRouteListDisplayLogic {
    func displayInitViews(viewModel: SelectRouteList.InitViews.ViewModel) {
        editWayPointView.setText(with: viewModel.wayPointInfo)
    }

    func displayTapBackButton(viewModel: SelectRouteList.TapBackButton.ViewModel) {
        delegate?.selectRouteListViewController(
            didTapBackButton: self
        )
    }

    func displayFetchLocations(viewModel: SelectRouteList.FetchLocations.ViewModel) {
        locationDisplayItems = viewModel.locationDisplayItems
    }

    func displaySelectLocation(viewModel: SelectRouteList.SelectLocation.ViewModel) {
        delegate?.selectRouteListViewController(
            self,
            didSelect: viewModel.location,
            type: viewModel.wayPointType
        )
    }
}

// MARK: - UITableViewDataSource
extension SelectRouteListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locationDisplayItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SelectRouteListViewController.locationCellReuseId,
            for: indexPath
        ) as? LocationTableViewCell else {
            fatalError("not registered cell yet")
        }
        let displayItem = locationDisplayItems[indexPath.row]
        cell.configure(with: configuration, displayItem: displayItem)
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SelectRouteListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        interactor?.requestSelectLocation(
            request: SelectRouteList.SelectLocation.Request(
                index: indexPath.row)
        )
    }
}
