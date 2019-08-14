//
//  mapViewController.swift
//  PhoneNumberKit
//
//  Created by Justin Edwards on 8/12/19.
//

import UIKit
import Mapbox
import MapboxGeocoder

class mapViewController: UIViewController, MGLMapViewDelegate {

    
    var listings = [Listing]()
    
    
    @IBOutlet weak var mapHeaderView: UIView!
    @IBOutlet weak var mapPageView: UIStackView!
    @IBOutlet var mapContainerView: UIView!
    @IBOutlet weak var mapBottomView: UIView!
    var locationManager = CLLocationManager()
    
    var mapListingDetailImage = UIImageView()
    var mapListingConCatDetail1 = UILabel()
    var mapListingConCatDetail2 = UILabel()
    var mapListingDetailPhone = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         mapPageView.frame.size.height = (mapPageView.superview?.frame.size.height)!
        setUpPage()
        loadMap()

        // Do any additional setup after loading the view.
    }
    
    

   
    func loadMap(){
    
        
        let mapView = MGLMapView(frame: mapContainerView.bounds, styleURL: MGLStyle.lightStyleURL)
        
       
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437), zoomLevel: 9, animated: false)
        
        mapView.delegate = self
      
        
        
        let geocoder = Geocoder.shared
        for listing in listings{
            
            let options = ForwardGeocodeOptions(query: listing.dealer.address )
       options.focalLocation = CLLocation(latitude: 34.0522, longitude: -118.2437)
            options.allowedScopes = [.address, .pointOfInterest]
        var listingPoint = MGLPointAnnotation()
            let task = geocoder.geocode(options) { (placemarks, attribution, error) in
                guard let placemark = placemarks?.first else {
                    return
                }
                let coordinate = placemark.location?.coordinate
                print("coor\(coordinate?.latitude), \(coordinate?.longitude)")
                listingPoint.coordinate.latitude = (coordinate?.latitude)!
                listingPoint.coordinate.longitude = (coordinate?.longitude)!
                
                var mapListingConCatDetailString = String()
                mapListingConCatDetailString = "$" + String(listing.currentPrice.withCommas()) + "     " + String(listing.year) + " " + listing.make + " " + listing.model
                
                
                listingPoint.title = mapListingConCatDetailString
                listingPoint.subtitle = String(listing.mileage.withCommas() + " Mi" ) + "     " + listing.dealer.address
                mapView.addAnnotation(listingPoint) }
            
            mapView.allowsZooming = true
            
        }
            mapContainerView.addSubview(mapView)
        mapPageView.addSubview(mapContainerView)
    }
    
        func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        var annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: "placeholder-3")
        
        if annotationImage == nil {
            
            var image = UIImage(named: "placeholder-3")!
       
            annotationImage = MGLAnnotationImage(image: image, reuseIdentifier: "placeholder-3")
        }
        
        return annotationImage
        
    }
    
    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
       print("click")
        // navigateButton.addTarget(self, action: routeCalcMapView(annotation: annotation as! MGLPointAnnotation), for: UIControlEvents.touchUpInside)
        
        let camera = MGLMapCamera(lookingAtCenter: annotation.coordinate, fromDistance: 4500, pitch: 15, heading: 180)
        mapView.fly(to: camera, withDuration: 4,
                    peakAltitude: 3000, completionHandler: nil)
          mapListingConCatDetail1.text = annotation.title!
        
           mapListingConCatDetail2.text = annotation.subtitle!
        
    }
    
    @objc func segueToList() {
        performSegue(withIdentifier: "MapToListing", sender: nil)
    }
    
    func headerSetUp()-> UIView{
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: mapHeaderView.frame.size.width, height: mapHeaderView.frame.size.width))
        headerView.backgroundColor = UIColor.white
        
     
        return headerView
    }
    
    //Very basic UI for the info display, primarily wanted to show basic ability to customize map and display info as user interacts with map
    func setUpPage(){
        NSLayoutConstraint(item: mapHeaderView , attribute: .height, relatedBy: .equal, toItem: mapPageView, attribute: .height, multiplier: 0.12, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: mapHeaderView , attribute: .top, relatedBy: .equal, toItem: mapPageView, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: mapContainerView, attribute: .height, relatedBy: .equal, toItem: mapPageView , attribute: .height, multiplier: 0.55, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: mapContainerView, attribute: .top, relatedBy: .equal, toItem: mapHeaderView , attribute: .bottom, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: mapBottomView, attribute: .height, relatedBy: .equal, toItem: mapPageView, attribute: .height, multiplier: 0.33, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: mapBottomView, attribute: .top, relatedBy: .equal, toItem: mapPageView, attribute: .bottom, multiplier: 0.55, constant: 0.0).isActive = true
        
        
  
        let iconImage = UIImage(named: "carfoxTest")
        let iconImageView = UIImageView()
        iconImageView.image = iconImage
        iconImageView.frame.size = CGSize(width: (mapPageView.frame.size.height * 0.12)/1.25, height: (mapPageView.frame.size.height * 0.12)/1.25 )
        iconImageView.frame.origin = CGPoint(x: mapHeaderView.frame.size.width/16, y: ((mapPageView.frame.size.height * 0.12)/2) - iconImageView.frame.size.height/2 )
        
         let headingContainer = UIView()
         headingContainer.frame.size = CGSize(width: mapPageView.frame.size.width/2.6, height: (mapPageView.frame.size.width * 0.12)/2)
         headingContainer .frame.origin = CGPoint(x: iconImageView.frame.origin.x + iconImageView.frame.width + 15, y:  (mapPageView.frame.size.height * 0.12)/2 - headingContainer .frame.size.height/2 )
         
         let headingLabel = UILabel()
         headingLabel.text = "Find Your Car"
         headingLabel.font.withSize(30)
         headingLabel.frame.size =  headingContainer.frame.size
         headingLabel.frame.origin = CGPoint(x: 0, y:  0)
 
        let back = UIButton()
        back.frame.size = CGSize(width:  mapHeaderView.frame.size.width/11, height: mapHeaderView.frame.size.width/11)
        back.frame.origin = CGPoint(x: mapHeaderView.frame.size.width/1.8, y: (mapPageView.frame.size.height * 0.12)/2 - back.frame.size.height/2)
        let backImg = UIImage(named: "list")
        back.setImage(backImg, for: UIControl.State.normal)
        back.addTarget(self, action: #selector(segueToList), for: UIControl.Event.touchUpInside)
        
        
        mapListingDetailImage.frame.size = CGSize(width:  mapBottomView.frame.size.width * 0.22, height: mapBottomView.frame.size.height/5)
        mapListingDetailImage.frame.origin = CGPoint(x:  mapBottomView.frame.size.width/11, y:  mapBottomView.frame.size.height/2 - mapListingDetailImage.frame.size.height/2)
        
        
        mapListingConCatDetail1.frame.size = CGSize(width:  mapBottomView.frame.size.width/1.5, height: mapBottomView.frame.size.height/5)
        mapListingConCatDetail1.frame.origin = CGPoint(x:  mapBottomView.frame.size.width/8, y:  mapBottomView.frame.size.height * 0.35)
        mapListingConCatDetail1.textColor = UIColor(red: 0, green: 0.3569, blue: 0.7176, alpha: 1.0)
        mapListingConCatDetail1.font = UIFont.boldSystemFont(ofSize: 18)
        
        mapListingConCatDetail2.frame.size = CGSize(width:  mapBottomView.frame.size.width/1.5, height: mapBottomView.frame.size.height/5)
        mapListingConCatDetail2.frame.origin = CGPoint(x:  mapBottomView.frame.size.width/8, y:  mapBottomView.frame.size.height * 0.6)
        mapListingConCatDetail2.textColor = UIColor(red: 0, green: 0.3569, blue: 0.7176, alpha: 1.0)
        mapListingConCatDetail2.font = UIFont.boldSystemFont(ofSize: 16)
        
        mapListingDetailPhone .frame.size = CGSize(width:  mapBottomView.frame.size.width/2, height: mapBottomView.frame.size.height/5)
        mapListingDetailPhone.frame.origin = CGPoint(x:  mapBottomView.frame.size.width/8, y:  mapBottomView.frame.size.height * 0.8)
        mapListingDetailPhone.setTitleColor(UIColor(red: 0, green: 0.3569, blue: 0.7176, alpha: 1.0), for: UIControl.State.normal)
        
        mapListingConCatDetail1.text = "Choose A Map Option"
        mapListingConCatDetail1.textColor = UIColor(red: 0, green: 0.3569, blue: 0.7176, alpha: 1.0)
        
        headingContainer.addSubview(headingLabel)
        mapHeaderView.addSubview(headingContainer)
        mapHeaderView.addSubview(iconImageView)
        mapHeaderView.addSubview(back)
        mapBottomView.addSubview(mapListingConCatDetail1)
        mapBottomView.addSubview(mapListingConCatDetail2)
        mapBottomView.addSubview(mapListingDetailPhone)
        //  mapBottomView.addSubview(mapListingDetailImage)
        
        
    }
    
}


