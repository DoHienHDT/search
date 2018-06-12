//
//  TableViewController.swift
//  search
//
//  Created by dohien on 6/11/18.
//  Copyright © 2018 hiền hihi. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController , UISearchResultsUpdating{
    var tableData = ["hihi","huhu","haha","hoho","hyhy"]
    var filteredTableData = [String]()
    let controller = UISearchController(searchResultsController : nil)
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller.searchBar.placeholder = "hihi"
        controller.searchResultsUpdater = self
        controller.dimsBackgroundDuringPresentation = false
        controller.searchBar.sizeToFit()
                    self.tableView.tableHeaderView = controller.searchBar
                    controller.hidesNavigationBarDuringPresentation = false
        tableView.tableHeaderView = controller.searchBar
        // truyền sang mất nút search
        definesPresentationContext = true
        
        
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if controller.isActive{
            return filteredTableData.count
        }
            
        else{
            return filteredTableData.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        // có thể tabledata
        if controller.isActive{
            cell.textLabel?.text = filteredTableData[indexPath.row]
            return cell
        }else{
            cell.textLabel?.text = filteredTableData[indexPath.row]
            return cell
        }
        
        
    }
    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll(keepingCapacity: false)
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (tableData as NSArray).filtered(using: searchPredicate)
        filteredTableData = array as! [String]
        self.tableView.reloadData()
    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            if controller.textInputMode != nil{
                if let index = filteredTableData.index(of: filteredTableData[indexPath.row]) {
                    tableData.remove(at: index)
                    filteredTableData.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with:.fade )
                } else{
                    tableData.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        default:
            print("hehe")
        }
        
        //        if editingStyle == .delete {
        //            if(self.resultSearchController.isActive){
        //                filteredTableData.remove(at: indexPath.row)
        //            }else{
        //                tableData.remove(at: indexPath.row)
        //            }
        //            tableView.deleteRows(at: [indexPath], with: .fade)
        //        }
        //        tableView.reloadData()
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        let detailviewcontroller = unwindSegue.source as? DetailViewController
        if let index = tableView.indexPathForSelectedRow{
            tableData[index.row] = detailviewcontroller?.name ?? ""
        }else {
            tableData.append(detailviewcontroller?.name ?? "")
        }
        tableView.reloadData()
    }
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailviewcontroller = segue.destination as? DetailViewController
        if let index = tableView.indexPathForSelectedRow{
            detailviewcontroller?.name = tableData[index.row]
        }
    }
    
    
}
