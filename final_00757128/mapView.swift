//
//  mapView.swift
//  final_00757128
//
//  Created by User18 on 2021/1/2.
//

import SwiftUI
import CoreLocation
import MapKit

struct mapView: UIViewRepresentable {
    
    @Binding var coordinate: CLLocationCoordinate2D
    var locationManager = CLLocationManager()
    var stopName: String?
    
    func setupManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: mapView

        init(_ parent: mapView) {
            self.parent = parent
        }
        
        func navigation() {
            // 終點座標
            let targetCoordinate = parent.coordinate
            // 初始化 MKPlacemark
            let targetPlacemark = MKPlacemark(coordinate: targetCoordinate)
            // 透過 targetPlacemark 初始化一個 MKMapItem
            let targetItem = MKMapItem(placemark: targetPlacemark)
            // 使用當前使用者當前座標初始化 MKMapItem
            let userMapItem = MKMapItem.forCurrentLocation()
            // 建立導航路線的起點及終點 MKMapItem
            let routes = [userMapItem,targetItem]
            // 我們可以透過 launchOptions 選擇我們的導航模式，例如：開車、走路等等...
            MKMapItem.openMaps(with: routes, launchOptions: [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving])
        }
        
        func mapView(_ mapView: MKMapView,
                     didSelect view: MKAnnotationView) {
            navigation()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        setupManager()
        
        let mapView = MKMapView(frame: UIScreen.main.bounds)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        mapView.delegate = context.coordinator
        /*
        let pos = MKPointAnnotation()
        pos.title = "NTOU"
        pos.coordinate = coordinate
        mapView.addAnnotation(pos)*/
        
        return mapView
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        }
        else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if stopName != nil {
            let pos = MKPointAnnotation()
            pos.title = stopName
            pos.coordinate = coordinate
            uiView.addAnnotation(pos)
            
        }
    }
    
}
