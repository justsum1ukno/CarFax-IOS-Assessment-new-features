//
//  ListViewController.swift
//  IOS Assessment
//
//  Created by Justin Edwards on 8/6/19.
//  Copyright © 2019 apps. All rights reserved.
//

import UIKit

class ListingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   

   
    @IBOutlet weak var LTableView: UITableView!
    
   
    var listings = [Listing]()
    var sortedListings = Array<Listing>()
    var phoneNumber = String()
    var selectedSortOption = String()


    override func viewDidLoad() {
        super.viewDidLoad()
      
        LTableView.delegate = self
       LTableView.dataSource = self
        
       
    getRequest()
    sortListings()
    }
    
  
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        let headerView = headerSetUp()
        
        return headerView
    }
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 65.0
    }
    
     func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return listings.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // Dequeue the cell with identifier
      guard  let cell = LTableView.dequeueReusableCell(withIdentifier: "ListingTableViewCell", for: indexPath)
            as? listingViewTableCell else {
                fatalError()
        }
       
        
        let dataListing = listings[indexPath.row]
        
        if dataListing.images?.firstPhoto.large == nil{
            LTableView.scrollToRow(at: IndexPath(row: indexPath.row - 1, section: 0) , at: .none, animated: false)
        }else{
        cell.listingPhoto.load(urlString: (dataListing.images?.firstPhoto.large)!)
        cell.listingYear_Label.text = String(dataListing.year)
        cell.listingYear_Label.font = UIFont.boldSystemFont(ofSize: 13)
        cell.listingMake_Label.text = dataListing.make
        cell.listingMake_Label.font = UIFont.boldSystemFont(ofSize: 13)
        cell.listingModel_Label.text = dataListing.model
        cell.listingModel_Label.font = UIFont.boldSystemFont(ofSize: 13)
        cell.listingPrice_Label.text = "$" + dataListing.currentPrice.withCommas()
        cell.listingPrice_Label.font = UIFont.boldSystemFont(ofSize: 13)
        cell.listingMileage_Label.text = dataListing.mileage.withCommas() + " Mi"
        cell.listingLocation_Label.text = dataListing.dealer.city + " , " + dataListing.dealer.state
        cell.phoneButton.setTitle(formatPhoneNumber(phoneNumber: dataListing.dealer.phone), for: UIControl.State.normal)
            cell.phoneButton.addTarget(self, action: #selector(callNumber), for: UIControl.Event.touchUpInside)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "CarFax"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.LTableView.frame.height * 0.38
    }
    
    func getRequest(){
     //get json from URL and sort only if the user previously went to sortOptionViewController and came back to this VC - ListingViewContoller
        
        guard let url = URL(string: "https://carfax-for-consumers.firebaseio.com/assignment.json") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                
                let decoder = try JSONDecoder()
                let decodedListings = try decoder.decode(Listings.self, from: dataResponse)
                self.listings = decodedListings.listings
            DispatchQueue.main.async{
                if self.selectedSortOption == "" || self.selectedSortOption == nil {
                    
                }else if self.selectedSortOption == "Price: High to Low"{  self.listings.sort (by:{ $0.currentPrice > $1.currentPrice})
                    print("count", self.listings.count)
                    //MiddeTwo options have bug I did not recall how to fix today but you can see the path I was on
                }else if self.selectedSortOption == "Price: Low to High"{  self.listings.sort (by:{ $0.currentPrice < $1.currentPrice})
                    print("count2", self.listings.count)
                }else if self.selectedSortOption == "Mileage: High to Low"{  self.listings.sort (by:{ $0.mileage > $1.mileage})
                }else if self.selectedSortOption == "Mileage: Low to High"{ self.listings.sort (by:{ $0.mileage < $1.mileage})
                }
                self.selectedSortOption = ""
                //the user can only set selectedSortOption by returning to the sortOptionViewController
                print("option",self.selectedSortOption)
                
                
               
                self.LTableView.reloadData()
                self.LTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
     
       
}
    
    func sortListings(){
     
      
    }
    
    @IBAction func callNumber(_ sender: UIButton) {
        print("phone1",sender.titleLabel?.text)
        let phone_Number = sender.titleLabel?.text?.undoFormating()
        guard let numberString = phone_Number , let phoneCallURL = URL(string: "telprompt://\(numberString)") else {
            return}
        print("phone2",phoneCallURL)
        UIApplication.shared.open(phoneCallURL)
    }

   
    
    func formatPhoneNumber(phoneNumber: String, shouldRemoveLastDigit: Bool = false) -> String {
        guard !phoneNumber.isEmpty else { return "" }
        guard let regex = try? NSRegularExpression(pattern: "[\\s-\\(\\)]", options: .caseInsensitive) else { return "" }
        let r = NSString(string: phoneNumber).range(of: phoneNumber)
        var number = regex.stringByReplacingMatches(in: phoneNumber, options: .init(rawValue: 0), range: r, withTemplate: "")
        
        if number.count > 10 {
            let tenthDigitIndex = number.index(number.startIndex, offsetBy: 10)
            number = String(number[number.startIndex..<tenthDigitIndex])
        }
        
        if shouldRemoveLastDigit {
            let end = number.index(number.startIndex, offsetBy: number.count-1)
            number = String(number[number.startIndex..<end])
        }
        
        if number.count < 7 {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{3})(\\d+)", with: "($1) $2", options: .regularExpression, range: range)
            
        } else {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1) $2-$3", options: .regularExpression, range: range)
        }
        
        return number
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ListingToMap"{
            var MController = segue.destination as! mapViewController
            MController.listings.append(contentsOf: listings)
            
        }
    }
    
    @objc func segueToSort() {
        performSegue(withIdentifier: "ListingToSort", sender: nil)
        }
    
    @objc func segueToMap() {
        performSegue(withIdentifier: "ListingToMap", sender: nil)
    }
    
    func headerSetUp()-> UIView{
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: LTableView.frame.size.width, height: 65))
        headerView.backgroundColor = UIColor.white
        let iconImage = UIImage(named: "carfoxTest")
        let iconImageView = UIImageView()
        iconImageView.image = iconImage
        iconImageView.frame.size = CGSize(width: headerView.frame.size.width/6.5, height: headerView.frame.size.height/1.25 )
        iconImageView.frame.origin = CGPoint(x: headerView.frame.size.width/16, y: headerView.frame.size.height/2 - iconImageView.frame.size.height/2 )
        let headingContainer = UIView()
       
      //  headingContainer .font.withSize(19)
        headingContainer .frame.size = CGSize(width: headerView.frame.size.width/2.6, height: headerView.frame.size.height/2)
        headingContainer .frame.origin = CGPoint(x: iconImageView.frame.origin.x + iconImageView.frame.width + 15, y:  headerView.frame.size.height/2 - headingContainer .frame.size.height/2 )
        
        let headingLabel = UILabel()
        headingLabel.text = "CarFax"
        headingLabel.font.withSize(30)
        headingLabel.frame.size =  headingContainer.frame.size
        headingLabel.frame.origin = CGPoint(x: 0, y:  0)
        
        let sort = UIButton()
        sort.frame.size = CGSize(width:  headerView.frame.size.width/12.5, height: headerView.frame.size.width/12.5)
        sort.frame.origin = CGPoint(x: headerView.frame.size.width/4 * 2.5, y: headerView.frame.size.height/2 - sort.frame.size.height/2)
        let sortImage = UIImage(named: "sort")
        sort.setImage(sortImage, for: UIControl.State.normal)
        sort.addTarget(self, action: #selector(segueToSort), for: UIControl.Event.touchUpInside)
        
        let map = UIButton()
       map.frame.size = CGSize(width:  headerView.frame.size.width/12.5, height: headerView.frame.size.width/12.5)
        map.frame.origin = CGPoint(x: headerView.frame.size.width/4 * 3 + 15
            , y: headerView.frame.size.height/2 - sort.frame.size.height/2)
        let mapImage = UIImage(named: "mapIcon")
        map.setImage(mapImage, for: UIControl.State.normal)
        map.addTarget(self, action: #selector(segueToMap), for: UIControl.Event.touchUpInside)
        
        headingContainer.addSubview(headingLabel)
        headerView.addSubview(iconImageView)
        headerView.addSubview(headingContainer)
        headerView.addSubview(sort)
        headerView.addSubview(map)
        return headerView
    }
    
}

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}

extension String {
    func undoFormating()-> String{
    let unFormattedPhone1 = self.replacingOccurrences(of: "(", with: "")
    let unFormattedPhone2 = unFormattedPhone1.replacingOccurrences(of: ")", with: "")
    let unFormattedPhone3 = unFormattedPhone2.replacingOccurrences(of: "-", with: "")
    let unFormattedPhoneFinal = unFormattedPhone3.replacingOccurrences(of: " ", with: "")
    print("uf",unFormattedPhoneFinal)
    return unFormattedPhoneFinal }}

extension UIImageView {
    func load(urlString: String) {
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                //here dataResponse received from a network request
                
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.image = image
                        }
                    }
                }
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
       
    }
}

