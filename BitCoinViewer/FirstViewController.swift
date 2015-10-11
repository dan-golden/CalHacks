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
    
    let url = NSURL(string: "https://blockchain.info/ticker")

    let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
      if(data?.length > 0 && error == nil) {
        let json = NSString(data: data!, encoding: NSASCIIStringEncoding)
        parse_json(json);
      }
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
    let json: AnyObject? = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions())
    if let currencies = json as? NSArray {
      for (var i = 0; i < currencies.count ; i++ ) {
        if let currency_object = currencies[i] as? NSDictionary {
          if let fifteenM = currencies["15m"] as? String {
            if let last = currencies["last"] as? String {
              if let buy = currencies["buy"] as? String {
                if let sell = currencies["sell"] as? String {
                  if let symbol = currencies["symbol"] as? String {
                    
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

