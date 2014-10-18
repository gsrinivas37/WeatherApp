//
//  ViewController.swift
//  WeatherApp
//
//  Created by Gudla Srinivas on 10/18/14.
//  Copyright (c) 2014 sgudla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var city: UITextField!
    
    @IBOutlet weak var message: UILabel!
    
    @IBAction func getWeather(sender: AnyObject) {
        var trimmedCity = city.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        trimmedCity = (trimmedCity as NSString).stringByReplacingOccurrencesOfString(" ", withString: "")
        var urlStr = "http://www.weather-forecast.com/locations/\(trimmedCity)/forecasts/latest"
    
        var url = NSURL(string: urlStr)
        
        var task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            var urlContent: NSString = NSString(data: data, encoding: NSUTF8StringEncoding)
            
            if(urlContent.containsString("<span class=\"phrase\">")) {
                var array = urlContent.componentsSeparatedByString("<span class=\"phrase\">")
            
                var weather = (array[1].componentsSeparatedByString("</span>")[0]) as NSString
            
            
                dispatch_async(dispatch_get_main_queue()) {
                    self.message.text = weather.stringByReplacingOccurrencesOfString("&deg;", withString:"°")
                }
            }else {
                dispatch_async(dispatch_get_main_queue()) {
                    self.message.text = "City not found. Please try another one!"
                }
            }
        })
        
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

