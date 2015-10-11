//
//  FirstViewController.swift
//  BitCoinViewer
//
//  Created by Daniel Golden on 10/10/15.
//  Copyright © 2015 AndrewDanPatrickCalHacks. All rights reserved.
//

import UIKit

var TableData:Array< String > = Array < String >()

class FirstViewController: UITableViewController {

  override func viewDidLoad() {
    
    let url:NSURL = NSURL(string: "https://blockchain.info/ticker")!
    let session = NSURLSession.sharedSession()
    
    let request = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "GET"

    let task = session.dataTaskWithRequest(request) { (let data, let response, let error) in
      dispatch_async(dispatch_get_main_queue(), {
        let json = NSString(data: data!, encoding: NSASCIIStringEncoding)
        self.parse_json(json!)
        return
      })
    }
    
    task.resume()
    
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func parse_json(data:NSString) {
    let jsonData:NSData = data.dataUsingEncoding(NSUTF8StringEncoding)!
    let json: AnyObject?
    do {
      json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
    } catch let error as NSError {
      json = nil
      print("error")
    }
    if let currencies = json as? NSDictionary {
      for (var i = 0; i < currencies.count ; i++ ) {
        if let currency_object = currencies[i] as? NSDictionary {
          if let fifteenM = currency_object["15m"] as? String {
            if let last = currency_object["last"] as? String {
              if let buy = currency_object["buy"] as? String {
                if let sell = currency_object["sell"] as? String {
                  if let symbol = currency_object["symbol"] as? String {
                    TableData.append(fifteenM)
                  }
                }
              }
            }
          }
        }
      }
    }
    do_table_refresh();
  }
  
  func do_table_refresh()
  {
    dispatch_async(dispatch_get_main_queue(), {
      self.tableView.reloadData()
      return
    })
  }

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return TableData.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
    cell.textLabel?.text = TableData[indexPath.row]
    return cell
  }
  
}

