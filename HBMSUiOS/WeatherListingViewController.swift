//
//  ViewController.swift
//  HBMSUiOS
//
//  Created by Mohsin Hussain on 8/21/18.
//  Copyright © 2018 Mohsin Hussain. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class WeatherListingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //the Web API URL
    let URL_GET_DATA = "https://api.openweathermap.org/data/2.5/forecast?q=Dubai&units=imperial&cnt=80&APPID=1259c7528433a9050b7ec2b634430a2f"
    
    
    //a list to store heroes
    var forecastList = [ForeCast]()
    
    //the method returning size of the list
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return forecastList.count
    }
    
    
    //the method returning each cell of the list
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        //getting the hero for the specified position
        let forecast: ForeCast
        forecast = forecastList[indexPath.row]
        
        //displaying values
        cell.titleName.text = forecast.weather?.main
        cell.tempName.text = String(format:"%f", (forecast.main?.temp)!)
        cell.dateName.text = forecast.dt_txt
        
        
        //displaying image
//        Alamofire.request(hero.imageUrl!).responseImage { response in
//            debugPrint(response)
//            
//            if let image = response.result.value {
//                cell.weatherImage.image = image
//            }
//        }
        
        return cell
    }
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //fetching data from web api
        Alamofire.request(URL_GET_DATA).responseJSON { response in
            
            //getting json
            if let json = response.result.value {
                
                //converting json to NSArray
                let object : NSObject  = json as! NSObject
                
                let list: NSArray = object.value(forKey: "list") as! NSArray
                
                //traversing through all elements of the array
                for i in 0..<list.count{

                    //team: (heroesArray[i] as AnyObject).value(forKey: "team") as? String,
                    //adding hero values to the hero list
                    self.forecastList.append(ForeCast(
                        dt: (list[i] as AnyObject).value(forKey: "dt") as? Int,
                        main: Main(temp: ((list[i] as AnyObject).value(forKey: "main") as? AnyObject)?.value(forKey: "temp") as? Double,
                                   temp_min: ((list[i] as AnyObject).value(forKey: "main") as? AnyObject)?.value(forKey: "temp_min") as? Double,
                                   temp_max: ((list[i] as AnyObject).value(forKey: "main") as? AnyObject)?.value(forKey: "temp_max") as? Double,
                                   pressure: ((list[i] as AnyObject).value(forKey: "main") as? AnyObject)?.value(forKey: "pressure") as? Double,
                                   sea_level: ((list[i] as AnyObject).value(forKey: "main") as? AnyObject)?.value(forKey: "sea_level") as? Double,
                                   grnd_level: ((list[i] as AnyObject).value(forKey: "main") as? AnyObject)?.value(forKey: "grnd_level") as? Double,
                                   humidity: ((list[i] as AnyObject).value(forKey: "main") as? AnyObject)?.value(forKey: "humidity") as? Int),
                        weather: Weather(id: (((list[i] as AnyObject).value(forKey: "weather") as? [AnyObject])?.first as! NSObject).value(forKey: "id") as? Int,
                                         main: (((list[i] as AnyObject).value(forKey: "weather") as? [AnyObject])?.first as! NSObject).value(forKey: "main") as? String,
                                         description: (((list[i] as AnyObject).value(forKey: "weather") as? [AnyObject])?.first as! NSObject).value(forKey: "description") as? String,
                                         icon: (((list[i] as AnyObject).value(forKey: "weather") as? [AnyObject])?.first as! NSObject).value(forKey: "icon") as? String),
                        clouds: nil, wind: nil,
                        dt_txt: (list[i] as AnyObject).value(forKey: "dt_txt") as? String,
                        humidity: (list[i] as AnyObject).value(forKey: "humidity") as? Int
                    ))

                }
                
                //displaying data in tableview
                self.tableView.reloadData()
                
            }
            
        }
        
        
        
        self.tableView.reloadData()
        
    }



}



