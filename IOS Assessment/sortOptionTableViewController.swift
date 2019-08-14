//
//  sortOptionTableViewController.swift
//  IOS Assessment
//
//  Created by Justin Edwards on 8/12/19.
//  Copyright © 2019 apps. All rights reserved.
//

import UIKit




class sortOptionTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var sortOptions = [String]()
    var phoneNumber = String()
    var selectedSortOption = String()
     @IBOutlet var sortTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        sortTable.dataSource = self
        sortTable.delegate = self
        loadOptions()
    }
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       let headerView = setUpOptionHeader()
        return headerView
    }

     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 65.0
    }
    
    

   
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sortOptions.count
    }

  
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = sortTable.dequeueReusableCell(withIdentifier: "sortOptionTableViewCell", for: indexPath) as? sortOptionTableViewCell else{
            fatalError()
        }

        let option = sortOptions[indexPath.row]
        
        cell.sortLabel.text = option

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.sortTable.frame.height * 0.08
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     selectedSortOption = sortOptions[indexPath.row]
        print ("select", selectedSortOption)
       
    }
    
    func loadOptions(){
        sortOptions.append("Price: High to Low")
        sortOptions.append("Price: Low to High")
        sortOptions.append("Mileage: High to Low")
        sortOptions.append("Mileage: Low to High")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SortToListing"{
            var LController = segue.destination as! ListingViewController
            LController.selectedSortOption = selectedSortOption
            
        }
    }
    
    @objc func segueToListing() {
        //selectedSortOption.removeAll()
        performSegue(withIdentifier: "SortToListing", sender: nil)
    }
    
    func setUpOptionHeader()->UIView{
    let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: sortTable.frame.size.width, height: 65))
    headerView.backgroundColor = UIColor.white
    
        let confirm = UIButton()
        confirm.frame.size = CGSize(width:  headerView.frame.size.width/3, height: headerView.frame.size.height/2)
        confirm.frame.origin = CGPoint(x: headerView.frame.size.width/4 * 2, y: headerView.frame.size.height/2 - confirm.frame.size.height/2)
        
        confirm.setTitle("Confirm", for: UIControl.State.normal)
        confirm.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        confirm.backgroundColor = UIColor.cyan
        confirm.addTarget(self, action: #selector(segueToListing), for: UIControl.Event.touchUpInside)
        
        headerView.addSubview(confirm)
        return headerView
    }
 
    
    
 

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
