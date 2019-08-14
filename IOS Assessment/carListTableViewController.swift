//
//  carListTableViewController.swift
//  IOS Assessment
//
//  Created by Justin Edwards on 8/6/19.
//  Copyright © 2019 apps. All rights reserved.
//
/*
import UIKit

class carListTableViewController: UITableViewController, CellDelegate {
@IBOutlet var myTableView: UITableView!
    var listings = [Listing]()
    var iterativeListing = Listing(year: 0, make: "", model: "", trim: "", price: 0, mileage: 0, location: "", dealerPhone: 0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
     /*   let nib = UINib(nibName: "listingCell", bundle: nil)
        myTableView.register(nib, forCellReuseIdentifier: "ListingTableViewCell")*/
      getRequest()
        
        
      //  myTableView.register(carListTableViewController.self, forCellReuseIdentifier: "ListingTableViewCell")
        NSLog("contact")
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 205.0
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listings.count
        print("Called")
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = myTableView.dequeueReusableCell(withIdentifier: "ListingTableViewCell", for: indexPath)
        as? listingViewTableCell else {
            fatalError()
        }
        cell.delegate = self

       
       cell.listingYear_Label.text = String(listings[indexPath.row].year)
        cell.listingMake_Label.text = listings[indexPath.row].make
        cell.listingModel_Label.text = listings[indexPath.row].model
        cell.listingPrice_Label.text = String(listings[indexPath.row].price)
        cell.listingMileage_Label.text = String(listings[indexPath.row].mileage)
        cell.listingLocation_Label.text = listings[indexPath.row].location
        return cell
    }
    
    func getRequest(){
        guard let url = URL(string: "https://carfax-for-consumers.firebaseio.com/assignment.json") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse) as? [String: Any]
                
                if let items = jsonResponse?["listings"] as? [[String:Any]] {
                    for item in items {
                        if let swYear = item["year"] as? Int {
                            self.iterativeListing.year = swYear
                        }
                        if let swMake = item["make"] as? String {
                            self.iterativeListing.make = swMake
                        }
                        if let swModel = item["model"] as? String {
                            self.iterativeListing.model = swModel
                        }
                        if let swTrim = item["trim"] as? String {
                            self.iterativeListing.trim = swTrim
                        }
                        if let swPrice = item["currentPrice"] as? Int {
                            self.iterativeListing.price = swPrice
                        }
                        if let swMileage = item["mileage"] as? Int {
                            self.iterativeListing.mileage = swMileage
                        }
                        if let swLocation = item["location"] as? String {
                            self.iterativeListing.location = swLocation
                        }
                        if let swDealerPhone = item["dealerPhone"] as? Int {
                            self.iterativeListing.dealerPhone = swDealerPhone
                        }
                        self.listings.append(self.iterativeListing)
                        self.iterativeListing = Listing(year: 0, make: "", model: "", trim: "", price: 0, mileage: 0, location: "", dealerPhone: 0)
                        print(self.listings.count)
                        
                    }
                   
                }
                //  print(jsonArray)
                //print(jsonResponse) //Response result
                //    let convertedString = String(data: dataResponse, encoding: String.Encoding.utf8) // the data will be converted to the string
                //    print(convertedString ?? "defaultvalue")
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
         self.myTableView.beginUpdates()
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
*/
