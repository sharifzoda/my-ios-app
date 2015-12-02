//
//  ViewController.swift
//  Weather App
//
//  Created by Umedjoni Sharifzoda on 11/24/15.
//  Copyright © 2015 sharifzoda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var cityTextField: UITextField!
    
    
    @IBAction func findWeather(sender: AnyObject) {
        
        var wasSuccessful = false
        
        let attemptedUrl = NSURL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        if let url = attemptedUrl{
            
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
                
                if let urlContent = data{
                    let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                    
                    let websiteArray = webContent!.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                    
                    if(websiteArray.count>1){
                        
                        //    print(websiteArray![1])   Prints the first part of the data it finds in HTML
                        
                        let weatherArray = websiteArray[1].componentsSeparatedByString("</span>")
                        
                        if weatherArray.count > 1{
                            
                            wasSuccessful = true
                            
                            
                            let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                            
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                self.resultLabel.text = weatherSummary
                                
                            })
                            
                        }
                        
                    }
                    
                }
                
                if wasSuccessful == false {
                    self.resultLabel.text = "Coundn't Find the weathe for that city. Please try in again"
                }
                
            }
            
            task.resume()
            
            
            
        } else{
            self.resultLabel.text = "Coundn't Find the weather for that city. Please try in again"
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
    
}

