//
//  SecondViewController.swift
//  BitCoinViewer
//
//  Created by Daniel Golden on 10/10/15.
//  Copyright © 2015 AndrewDanPatrickCalHacks. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

  override func viewDidLoad() {
    let url = NSURL(string: "https://blockchain.info/ticker")
    
    let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
      print(NSString(data: data!, encoding: NSUTF8StringEncoding))
    }
    
    task.resume()
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

