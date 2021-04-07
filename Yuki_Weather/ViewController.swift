//
//  ViewController.swift
//  Yuki_Weather
//  Student#: 141082180
//  Created by Yuki Waka on 2021-04-05.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet var pkrLocation : UIPickerView!
    @IBOutlet var lblRegion : UILabel!
    @IBOutlet var lblName : UILabel!
    @IBOutlet var lblCountry : UILabel!
    @IBOutlet var lblTime : UILabel!
    @IBOutlet var lblTempC : UILabel!
    @IBOutlet var lblFeels : UILabel!
    @IBOutlet var lblwind : UILabel!
    @IBOutlet var lblwind_kph : UILabel!
    @IBOutlet var lblUv : UILabel!
    @IBOutlet var lbltext : UILabel!
    @IBOutlet var imageIcon : UIImageView!
    @IBOutlet var lblwindText : UILabel!
    @IBOutlet var lblkphText : UILabel!
    @IBOutlet var lblUvText : UILabel!
    @IBOutlet var lblFeelsText : UILabel!
    
    let locationList = ["Toronto","Vancouver","Edmonton","Halifax","Montreal", "Seoul","Takamatsu","Osaka","Hiroshima","Nagoya"]
    
    private let weathersFetcher = WeathersFetcher.getInstance()
    private var weatherList : Weather = Weather()
    private var cancellables: Set<AnyCancellable> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = " Weather"
        
        self.pkrLocation.dataSource = self
        self.pkrLocation.delegate = self
        
        self.lblName.text =  ""
        self.lblRegion.text = ""
        self.lblCountry.text = ""
        self.lblTime.text = ""
        self.lblTempC.text = ""
        
        self.lblFeels.text = ""
        self.lblwind.text = ""
        self.lblwind_kph.text = ""
        self.lblUv.text = ""
        
        self.lbltext.text = ""
        
        self.lblwindText.text = ""
        self.lblkphText.text = ""
        self.lblUvText.text = ""
        self.lblFeelsText.text = ""
    }
    
    @IBAction func selectWeather(){
        var newWeather = Weather()
        newWeather.name = self.locationList[self.pkrLocation.selectedRow(inComponent: 0)]
        
        self.weathersFetcher.fetchDataFromAPI(loc: newWeather.name)
        self.receiveChanges()
        
        //print(#function,newWeather.name_w)
    }
    
    private func receiveChanges(){
        self.weathersFetcher.$weatherList.receive(on: RunLoop.main)
            .sink{ (weather) in
                print(#function, "Received Weather : ", weather)
                
                self.weatherList = weather
                self.lblName.text = self.weatherList.name
                self.lblRegion.text = self.weatherList.region
                self.lblCountry.text = self.weatherList.country
                self.lblTime.text = self.weatherList.last_updated
                self.lblTempC.text = String(self.weatherList.temp_c)+"°"
                
                self.lblFeels.text = String(self.weatherList.feelslike_c)+"°"
                self.lblwind.text = self.weatherList.wind_dir
                self.lblwind_kph.text = String(self.weatherList.wind_kph)
                self.lblUv.text = String(self.weatherList.uv)
                
                self.lbltext.text = self.weatherList.text
                self.imageIcon.image = UIImage(url: URL(string:  "https:" + self.weatherList.icon))
                
                self.lblwindText.text = "Wind direction :"
                self.lblkphText.text = "Wind kph :"
                self.lblUvText.text = "UV :"
                self.lblFeelsText.text = "Feels"
            }
            .store(in : &cancellables)
    }
    
}




extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.locationList.count
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.locationList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(#function,"Selected location : \(self.locationList[row])")
    }
}

extension UIImage {
    convenience init?(url: URL?) {
        guard let url = url else { return nil }
        
        do {
            self.init(data: try Data(contentsOf: url))
        } catch {
            print("Cannot load image from url: \(url) with error: \(error)")
            return nil
        }
    }
}
