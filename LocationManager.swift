//
//  LocationManager.swift
//  Created by Yehya El Zein on 12/5/18.

import Foundation
import CoreLocation

class LocationManager:NSObject{
    
    private let locationManager = CLLocationManager();
    
    public var exposedLocation: CLLocation?{
        return self.locationManager.location;
    }
    override init() {
        super.init();
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.requestWhenInUseAuthorization();
    }
    func IsLocationEnabled()->Bool{
        return CLLocationManager.locationServicesEnabled();
    }
}
extension LocationManager:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch(status){
             case .notDetermined: print("location not determined");
             case .authorizedWhenInUse: print("location authorizedWhenInUse");
             case .authorizedAlways: print("location authorizedAlways");
             case .restricted: print("location restricted");
             case .denied: print("location denied");
            
        }
    }
    func GetPlace(for location:CLLocation, completition: @escaping (CLPlacemark?)-> Void){
        let geocoder = CLGeocoder();
        let localeLocation = Locale(identifier: LocalRepository.GetCulture());

        geocoder.reverseGeocodeLocation(location, preferredLocale: localeLocation) { (placemarks, error) in
            guard error == nil else{
                print("Error in \(#function): \(error?.localizedDescription)");
                completition(nil);
                return;
            }
            guard let placemark = placemarks?[0] else{
                print("Error in  \(#function): placemark is nil");
                completition(nil);
                return;
            }
            completition(placemark);
        }
    }
}
