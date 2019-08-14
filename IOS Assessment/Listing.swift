//
//  Listing.swift
//  IOS Assessment
//
//  Created by Justin Edwards on 8/7/19.
//  Copyright © 2019 apps. All rights reserved.
//

import UIKit



class Listings: Codable {
    var listings: [Listing]
    
    init(listings: [Listing]) {
       self.listings = listings
    }
}

class Listing: Codable {
    var images: Images?
    var year: Int
     var make: String
     var model: String
     var trim: String
    var currentPrice: Int
    var mileage: Int
    var dealer: dealer
    
    
    
    init( images: Images?,year: Int, make: String, model:String, trim:String, currentPrice:Int, mileage:Int,  dealer: dealer){
        self.images = images
        self.year = year
        self.make = make
        self.model = model
        self.trim = trim
        self.currentPrice = currentPrice
        self.mileage = mileage
        self.dealer = dealer
       
        
    }
    
}

class Images: Codable {
    var firstPhoto: FirstPhoto
    init( firstPhoto: FirstPhoto){
        self.firstPhoto = firstPhoto
    }}

class FirstPhoto: Codable {
    var large: String
    
    init( large: String){
        self.large = large
    }}


class dealer: Codable {
    var address:String
    var city: String
    var state: String
    var phone: String
    init( address:String, city: String, state: String, phone:String){
        self.address = address
        self.city = city
        self.state = state
        self.phone = phone
    }}


