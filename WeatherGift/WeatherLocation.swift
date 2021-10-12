//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Andrew Chapman on 10/11/21.
//

import Foundation

class WeatherLocation: Codable {
    var name: String
    var latitude: Double
    var longitude: Double
    
    init(name:String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func getData() {
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely&units=imperial&appid=\(APIkeys.openWeatherKey)"
        
        print("Accesssing this URL: \(urlString)")
        //create a url
        guard let url = URL(string: urlString) else {
            print("ERROR: Could not create a url from \(urlString)")
            return
        }
        
        //create session
        let session = URLSession.shared
        
        //get data with .datataskmethod
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            }
            //some other things could go wrong, ignoring testing them rn
            
            //dealing with data
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print(json)
            } catch {
                print("ERROR: JSON issue \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}
