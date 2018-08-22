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
    let URL_GET_DATA = "https://api.openweathermap.org/data/2.5/forecast?q=Dubai&units=metric&cnt=80&APPID=1259c7528433a9050b7ec2b634430a2f"
    
    
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
        let x = (forecast.main?.temp)!
        let y = Double(round(100*x)/100)
        cell.tempName.text = convertUnit(temp: y)
        cell.dateName.text = forecast.dt_txt
        
        
        //displaying image
        Alamofire.request("http://openweathermap.org/img/w/"+(forecast.weather?.icon!)!+".png").responseImage { response in
            debugPrint(response)
            
            if let image = response.result.value {
                cell.weatherImage.image = image
            }
        }
        
        return cell
    }
    
    func convertUnit(temp:Double) -> String{
        
        if(defaults.object(forKey: "isImperial") as? Bool)!{
            let fahrenheit = String(format: "%1.2f", (temp * 9.0) / 5.0 + 32.0)+" F"
            return fahrenheit
        }
        else{
            let celcius = String(format: "%1.2f", temp)+" C"
            return celcius
        }
        
    }
    
//    var index: Int? = 0
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        cell.tag = indexPath.row
//        performSegue(withIdentifier: "toDetailView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if(segue.identifier == "toDetailView") {
            
            if(segue.identifier=="toDetailView"){
                let detailVC: WeatherDetailViewController? = segue.destination as? WeatherDetailViewController
                let cell: ViewControllerTableViewCell? = sender as? ViewControllerTableViewCell
    
                let index = tableView.indexPathForSelectedRow?.row
                print("Index: "+String(index!))
                if cell != nil && detailVC != nil{
                    detailVC!.titleText = forecastList[index!].weather?.main
                    detailVC!.descText = forecastList[index!].weather?.description
                    
                    let tempValue = (forecastList[index!].main?.temp)!
                    let tempShortValue = Double(round(100*tempValue)/100)
                    detailVC!.tempText = convertUnit(temp: tempShortValue)
                    
                    let minTempValue = (forecastList[index!].main?.temp_min)!
                    let minTempShortValue = Double(round(100*minTempValue)/100)
                    detailVC!.minTempText = convertUnit(temp: minTempValue)
                    
                    let maxTempValue = (forecastList[index!].main?.temp_max)!
                    let maxTempShortValue = Double(round(100*maxTempValue)/100)
                    detailVC!.maxTempText = convertUnit(temp: maxTempValue)
                    
                    detailVC!.airText = String(format:"%1.2f", (forecastList[index!].main?.pressure)!)
                    let humid = String((forecastList[index!].main?.humidity)!)
                    detailVC!.humidityText = humid
                    
                    detailVC!.cloudsText = String((forecastList[index!].clouds?.all)!)+" %"
                    
                    let windValue = (forecastList[index!].wind?.speed)!
                    let windShortValue = Double(round(100*windValue)/100)
                    detailVC!.windText = String(format:"%1.2f", windShortValue)+" Kms"
                    
                    detailVC!.iconText = forecastList[index!].weather?.icon
                }
                
            }
            
        }
        
    }
    let defaults = UserDefaults.standard
    @IBOutlet weak var tableView: UITableView!
    @IBAction func OnChangeUnit(){
        if((defaults.object(forKey: "isImperial")) as? Bool)!{
            defaults.set(false, forKey: "isImperial")
        }
        else{
            defaults.set(true, forKey: "isImperial")
        }
        self.tableView.reloadData()
    }

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
                        clouds: Clouds(all: ((list[i] as AnyObject).value(forKey: "clouds") as? AnyObject)?.value(forKey: "all") as? Int),
                        wind: Wind(speed: ((list[i] as AnyObject).value(forKey: "wind") as? AnyObject)?.value(forKey: "speed") as? Double,
                                   deg: nil),
                        dt_txt: (list[i] as AnyObject).value(forKey: "dt_txt") as? String,
                        humidity: (list[i] as AnyObject).value(forKey: "humidity") as? Int
                    ))

                }
                
                //displaying data in tableview
                self.tableView.reloadData()
                self.tableView.allowsSelection = true
                self.tableView.isUserInteractionEnabled = true
            }
            
            
            if(self.defaults.object(forKey: "isImperial") == nil){
                self.defaults.set(false, forKey: "isImperial")
            }
            
            
        }
        
        
        
        self.tableView.reloadData()
        
        
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if(segue.identifier=="toDetailView"){
//            let detailVC: WeatherDetailViewController? = segue.destination as? WeatherDetailViewController
//            let cell: ViewControllerTableViewCell? = sender as? ViewControllerTableViewCell
//
//            if cell != nil && detailVC != nil{
//                detailVC!.titleLabel.text = cell!.titleName!.text
//            }
//        }
//    }


}



