//
//  Weather.swift
//  Yuki_Weather
//  Student#: 141082180
//  Created by Yuki Waka on 2021-04-05.
//

import Foundation

struct Weather : Codable{
    var name : String //name
    var region : String  //region
    var country : String //country
    var last_updated : String  //last_update
    var temp_c : Double  //temp_c
    var feelslike_c : Double  //feelslike_c
    var wind_dir : String //wind_dir
    var wind_kph : Double
    var uv : Double  //uv
    var text : String //condition/text
    var icon : String  //current/icon
    
    
    init(){
        self.name = ""
        self.region = ""
        self.country = ""
        self.last_updated = ""
        self.icon = ""
        self.temp_c = 0.0
        self.feelslike_c = 0.0
        self.text = ""
        self.wind_dir = ""
        self.wind_kph = 0.0
        self.uv = 0.0
    }
    
    enum CodingKeys : String, CodingKey{
        case name = "name"
        case region = "region"
        case country = "country"
        case location = "location"
        case last_updated = "last_updated"
        case icon = "icon"
        case temp_c = "temp_c"
        case feelslike_c = "feelslike_c"
        case text = "text"
        case wind_dir = "wind_dir"
        case wind_kph = "wind_kph"
        case uv = "uv"
        case current = "current"
    }
    func encode(to encoder: Encoder) throws {
        //nothing to encode
    }
    
    init(from decoder: Decoder) throws{
        let response = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name  = ""
        self.region  = ""
        self.country  = ""
        let locationContainer = try response.decodeIfPresent(Location.self, forKey: .location)
        self.name = locationContainer?.name ?? "Unavailable"
        self.region = locationContainer?.region ?? "Unavailable"
        self.country = locationContainer?.country ?? "Unavailable"
        
        self.last_updated  = ""
        self.temp_c  = 0.0
        self.feelslike_c  = 0.0
        self.wind_dir = ""
        self.wind_kph = 0.0
        self.uv = 0.0
        let currentContainer = try response.decodeIfPresent(Current.self, forKey: .current)
        self.last_updated = currentContainer?.last_updated ?? "Unavailable"
        self.temp_c = currentContainer?.temp_c ?? 0
        
        self.feelslike_c = currentContainer?.feelslike_c ?? 0.0
        self.wind_dir = currentContainer?.wind_dir ?? "Unavailable"
        self.wind_kph = currentContainer?.wind_kph ??  0.0
        self.uv = currentContainer?.uv ?? 0.0
        
        self.text = ""
        self.icon = ""
        self.text = currentContainer?.text ?? "Unavailable"
        self.icon = currentContainer?.icon ?? "Unavailable"
        
    }
}

struct Location : Codable{
    let name : String
    let region : String
    let country : String
    
    
    enum CodingKeys: String, CodingKey{
        case name = "name"
        case region = "region"
        case country = "country"
        
    }
    
    init(from decoder: Decoder) throws{
        let response = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try response.decodeIfPresent(String.self, forKey: .name) ?? "Unavailable"
        self.region = try response.decodeIfPresent(String.self, forKey: .region) ?? "Unavailable"
        self.country = try response.decodeIfPresent(String.self, forKey: .country) ?? "Unavailable"
    }
    
    func encode(to encoder: Encoder) throws {
        //nothing to encode
    }
    
    
}

struct Current : Codable{
    let last_updated : String
    let temp_c : Double
    let feelslike_c : Double
    var wind_dir : String
    let wind_kph : Double
    let uv : Double
    
    var text : String
    var icon : String
    
    init(){
        self.last_updated = ""
        self.temp_c = 0.0
        self.feelslike_c = 0.0
        self.wind_dir = ""
        self.wind_kph = 0.0
        self.uv = 0.0
        self.text = ""
        self.icon = ""
    }
    
    
    enum CodingKeys: String, CodingKey{
        case last_updated = "last_updated"
        case temp_c = "temp_c"
        case feelslike_c = "feelslike_c"
        case uv = "uv"
        case wind_dir = "wind_dir"
        case wind_kph = "wind_kph"
        
        case text = "text"
        case icon = "icon"
        case condition = "condition"
    }
    
    init(from decoder: Decoder) throws{
        let response = try decoder.container(keyedBy: CodingKeys.self)
        self.last_updated = try response.decodeIfPresent(String.self, forKey: .last_updated) ?? "Unavailable"
        self.temp_c = try response.decodeIfPresent(Double.self, forKey: .temp_c) ?? 0.0
        self.feelslike_c = try response.decodeIfPresent(Double.self, forKey: .feelslike_c) ?? 0.0
        self.wind_dir = try response.decodeIfPresent(String.self, forKey: .wind_dir) ?? "Unavailable"
        self.wind_kph = try response.decodeIfPresent(Double.self, forKey: .wind_kph) ?? 0.0
        self.uv = try response.decodeIfPresent(Double.self, forKey: .uv) ?? 0.0
        
        self.text = ""
        self.icon = ""
        let conditionContainer = try response.decodeIfPresent(Condition.self, forKey: .condition)
        self.text = conditionContainer?.text ?? "Unavailable"
        self.icon = conditionContainer?.icon ?? "Unavailable"
    }
    
    func encode(to encoder: Encoder) throws {
        //nothing to encode
    }
    
    
}

struct Condition : Codable{
    let text : String
    let icon : String
    
    
    enum CodingKeys: String, CodingKey{
        case text = "text"
        case icon = "icon"
    }
    
    init(from decoder: Decoder) throws{
        let response = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try response.decodeIfPresent(String.self, forKey: .text) ?? "Unavailable"
        self.icon = try response.decodeIfPresent(String.self, forKey: .icon) ?? "Unavailable"
        
    }
    
    func encode(to encoder: Encoder) throws {
        //nothing to encode
    }
    
}
