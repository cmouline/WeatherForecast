//
//  SearchViewController.swift
//  WeatherForecast
//
//  Created by Moulinet Chloë on 07/11/2018.
//  Copyright © 2018 Moulinet Chloë. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import NVActivityIndicatorView

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    var presenter: SearchPresenter!
    var alertController: UIAlertController!

    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var submitButton: CustomButton!
    @IBOutlet weak var degreeUnitSelector: UISegmentedControl!
    @IBOutlet weak var loaderOverlayView: UIView!
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = SearchPresenter(view: self)
        self.cityTextField.delegate = self
        setup()
    }
    
    func setup() {
        submitButton.setButtonStyle(.submit)
        submitButton.touchUp = { [weak self] _ in
            
            if let city = self?.cityTextField.text {
                self?.presenter.touchSubmit(city: city)
            }
        }
        degreeUnitSelector.addTarget(self.presenter,
                                     action: #selector(presenter.degreeUnitSelectorValueChanged(_:)),
                                     for: .valueChanged)
        
        let touchMap = UITapGestureRecognizer(target: self.presenter,
                                              action:#selector(presenter.touchMap(_:)))
        mapView.addGestureRecognizer(touchMap)
    }
    
    func pushCityWeatherViewController(destination: CityWeatherViewController) {
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Oops, something went wrong !",
                                                message: "Check if the city name you entered is correct or try again later",
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { action in
            // Do nothing but dismiss alert
        }
        alertController.addAction(okAction)

        present(alertController, animated: true)
    }
    
    func showLoader() {
        loaderOverlayView.alpha = 1
        loaderView.startAnimating()
    }
    
    func hideLoader() {
        loaderOverlayView.alpha = 0
        loaderView.stopAnimating()
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK : - textField Delegate Functions
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let city = self.cityTextField.text {
            self.presenter.touchSubmit(city: city)
        }
        return true
    }
    
}

