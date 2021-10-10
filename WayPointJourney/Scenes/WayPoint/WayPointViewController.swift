//
//  WayPointViewController.swift
//  GOGOXCodeChallenge
//
//  Created by ho yin Chan on 8/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import DesignKit
import MapKit
import CoreLocation
import Hero
import Models

protocol WayPointDisplayLogic: AnyObject {
    func displayInitViews(viewModel: WayPoint.InitViews.ViewModel)
    func displayRouteToSelectRouteList(viewModel: WayPoint.RouteToSelectRouteList.ViewModel)
    func displayDidSelectLocation(viewModel: WayPoint.DidSelectLocation.ViewModel)
}

class WayPointViewController: BaseViewController {
    // MARK: Dimen
    private enum Dimen {
        static let editWayPointContainerCornerRadius: CGFloat = 12
        static let editWayPointContainerTopPadding: CGFloat = 16
        static let editWayPointContainerBottomPadding: CGFloat = 32
        static let editWayPointContainerLeadingPadding: CGFloat = 20
        static let editWayPointContainerTrailingPadding: CGFloat = 48
    }

    // MARK: Properties
    var interactor: WayPointBusinessLogic?
    var router: (WayPointRoutingLogic & WayPointDataPassing)?
    let locationManager: CLLocationManager

    // MARK: Object Cycle
    init(
        configuration: Configurable,
        locationManager: CLLocationManager = CLLocationManager()
    ) {
        self.locationManager = locationManager
        super.init(configuration: configuration)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // UI Components
    lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.delegate = self
        view.mapType = .standard
        view.isZoomEnabled = true
        view.isScrollEnabled = true
        return view
    }()

    lazy var editWayPointViewContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Dimen.editWayPointContainerCornerRadius
        view.clipsToBounds = true
        return view
    }()

    lazy var heroAnimationContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Dimen.editWayPointContainerCornerRadius
        view.heroID = "hero.id.editWayPointView"
        view.heroModifiers = [.duration(0.24)]
        return view
    }()

    lazy var editWayPointView: EditWayPointView = {
        let view = EditWayPointView(
            configuration: configuration,
            delegate: self
        )
        return view
    }()
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isHeroEnabled = true
        setupLayout()
        configureMapView()
        setFontsAndColors()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor?.requestInitViews(
            request: WayPoint.InitViews.Request()
        )
    }

    // MARK: UI Methods
    func setupLayout() {
        view.addSubview(mapView)
        view.addSubview(editWayPointViewContainer)
        heroAnimationContainer.addSubview(editWayPointView)
        editWayPointViewContainer.addSubview(heroAnimationContainer)
        mapView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
        editWayPointViewContainer.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
        heroAnimationContainer.snp.makeConstraints { $0.edges.equalToSuperview() }
        editWayPointView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Dimen.editWayPointContainerLeadingPadding)
            make.trailing.equalToSuperview().inset(Dimen.editWayPointContainerTrailingPadding)
            make.top.equalToSuperview().inset(Dimen.editWayPointContainerTopPadding)
            make.bottom.equalToSuperview().inset(Dimen.editWayPointContainerBottomPadding)
        }
    }

    func configureMapView() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        if let coor = mapView.userLocation.location?.coordinate {
            mapView.setCenter(coor, animated: true)
        }
    }

    func setFontsAndColors() {
        let colorLayout = configuration.layout.colorLayout
        heroAnimationContainer.backgroundColor = colorLayout.white
    }
}

// MARK: - WayPointDisplayLogic
extension WayPointViewController: WayPointDisplayLogic {
    func displayInitViews(viewModel: WayPoint.InitViews.ViewModel) {
        navigationItem.title = viewModel.titleString
    }

    func displayRouteToSelectRouteList(
        viewModel: WayPoint.RouteToSelectRouteList.ViewModel
    ) {
        router?.routeToSelectRouteList(firstResponseWayPointType: viewModel.wayPointType)
    }

    func displayDidSelectLocation(viewModel: WayPoint.DidSelectLocation.ViewModel) {
        editWayPointView.setText(
            with: viewModel.wayPointType,
            locationName: viewModel.locationName
        )
    }
}


// MARK: - CLLocationManagerDelegate, MKMapViewDelegate
extension WayPointViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations
        locations: [CLLocation]
    ) {
        guard let locationValue = manager.location?.coordinate else { return }

        mapView.mapType = MKMapType.standard
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locationValue, span: span)
        mapView.setRegion(region, animated: true)
    }
}

// MARK: - WayPointViewDelegate
extension WayPointViewController: WayPointViewDelegate {
    func wayPointViewDidBeginEditing(
        view: WayPointView,
        viewType: WayPointViewType
    ) {
        view.inputField.resignFirstResponder()
        interactor?.requestEditWayPointTextField(
            request: WayPoint.EditWayPointTextField.Request(wayPointType: viewType)
        )
    }
}

// MARK: - SelectRouteListViewControllerDelegate
extension WayPointViewController: SelectRouteListViewControllerDelegate {
    func selectRouteListViewController(
        didTapBackButton controller: SelectRouteListViewController
    ) {
        controller.navigationController?.dismiss(animated: true)
    }

    func selectRouteListViewController(
        _ controller: SelectRouteListViewController,
        didSelect location: Location,
        type: WayPointViewType
    ) {
        interactor?.requestDidSelectLocation(
            request: WayPoint.DidSelectLocation.Request(
                location: location,
                wayPointType: type
            )
        )
        controller.navigationController?.dismiss(animated: true)
    }
}
