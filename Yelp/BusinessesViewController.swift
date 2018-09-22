//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil{
            return businesses.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        cell.business = businesses[indexPath.row]
        
        return cell
    }
    
   /* func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = myTableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - myTableView.bounds.size.height - 1000;
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && myTableView.dragging) {
                isMoreDataLoading = true
                reloadSearch(++offset);
            }
        }
    } */
    
   /* func reloadTable() {
        loadingSpinner.stopAnimating();
        myTableView.reloadData();
        myTableView.alpha = 1;
    }
    
    func reloadSearch(offset: Int = 0) {
        self.offset = offset;
        var completion = { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.searchLoadComplete();
        };
        if(self.offset > 0) {
            completion = { (businesses: [Business]!, error: NSError!) -> Void in
                self.businesses.appendContentsOf(businesses);
                self.searchLoadComplete();
            };
        } else {
            myTableView.alpha = 0;
            loadingSpinner.startAnimating();
        }
        if let query = searchBar.text {
            searchTerm = query;
        }
        
        appDelegate.search_term = searchTerm;
        Business.search(searchTerm, offset: offset, completion: completion);
    } */

    
    @IBOutlet var myTableView: UITableView!
    var businesses: [Business]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.rowHeight = UITableViewAutomaticDimension
        myTableView.estimatedRowHeight = 120
        myTableView.separatorInset = UIEdgeInsets.zero
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        
        navigationItem.titleView = searchBar
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
                self.businesses = businesses
                self.myTableView.reloadData()
                if let businesses = businesses {
                    for business in businesses {
                        print(business.name!)
                        print(business.address!)
                    }
                }
            
            }
        )
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm(term: "Restaurants", sort: .distance, categories: ["asianfusion", "burgers"]) { (businesses, error) in
                self.businesses = businesses
                 for business in self.businesses {
                     print(business.name!)
                     print(business.address!)
                 }
         }
         */
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
}
