
import Foundation
import CoreLocation

public final class WeatherService:NSObject {
    
    private let locationManager = CLLocationManager()
    private let API_KEY = "daf952f2c972e0fc01431cf32031bdd9"
    private var completionHandler: ((Weather) -> Void)?
    
    
    public override init(){
        super.init()
        locationManager.delegate = self
    }
    
    public func loadWeatherData(_ completionHandler: @escaping((Weather) -> Void)) {
        self.completionHandler = completionHandler
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    private func makeDataRequest(forCoordinates coordinates : CLLocationCoordinate2D) {
        
        guard let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_KEY)&units=metric".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { fatalError("Missing URL") }
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) {  data,response,error in
            
            guard error == nil, let data = data else {return}
            
            if let response = try? JSONDecoder().decode(ApiResponse.self, from: data) {
                self.completionHandler?(Weather(response: response))
            }
            
        }.resume()
        
            
        }
        
    }



extension WeatherService:CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations location: [CLLocation]) {
        guard let location = location.first else {return}
        makeDataRequest(forCoordinates: location.coordinate)
    }
}



    
    struct ApiResponse: Decodable {
        var weather: [ApiWeather]
        var main: ApiMain
        var name: String
    }
    
    
    
    struct ApiMain: Decodable {
        var temp: Double
        var temp_min: Double
        var temp_max: Double
        
    }
    
    struct ApiWeather: Decodable {
        var description: String
        var iconName: String
        
        enum CodingKeys: String, CodingKey {
            case description
            case iconName = "main"
        }
    }

