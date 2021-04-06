//
//  LaunchFetcher.swift
//  Yuki_Weather
//
//  Created by Yuki Waka on 2021-04-05.
//

import Foundation

class WeathersFetcher : ObservableObject{
   
    var apiURL = "https://api.weatherapi.com/v1/current.json?key=f0f898992d0142d0955134250210504&q="
   
   // var Location : String = ""
    
 
    
    @Published var weatherList = Weather()
    
    //singleton instance
    private static var shared : WeathersFetcher?
    
    static func getInstance() -> WeathersFetcher{
        if shared != nil{
            //instance already exists
            return shared!
        }else{
            // create a new singlton instance
            return WeathersFetcher()
        }
    }
   


    func fetchDataFromAPI(loc: String){
    apiURL = "https://api.weatherapi.com/v1/current.json?key=f0f898992d0142d0955134250210504&q="
    apiURL += loc
    apiURL += "&aqi=no"
    guard let api = URL(string: apiURL) else{
        return
    }
    
    URLSession.shared.dataTask(with: api){(data: Data?, response: URLResponse?, error : Error?) in
        
        if let err = error{
            print(#function, "Couldn't fetch data", err)
        }else{
            //received data or response
            
            DispatchQueue.global().async{
                do{
                    if let jsonData = data{
                        
                        let decoder = JSONDecoder()
                            //use this if response is array of JSON objects
                        let decodedList = try decoder.decode(Weather.self, from: jsonData)
                        
                        //use this of response is JSON object
                       // let decodedList = try decoder.decode(Launch.self, from: jsonData)
                        DispatchQueue.main.async {
                            self.weatherList = decodedList
                        }
                       
                        
                    }else{
                        print(#function, "No JSON data received")
                    }
                }catch  let error{
                    print(#function, error)
                }
            }
        }
        
    }.resume()
}
}

