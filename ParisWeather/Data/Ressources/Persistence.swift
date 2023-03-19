//
//  Persistence.swift
//  ParisWeather
//
//  Created by Cedrik on 17/03/2023.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        var newWeatherData: WeatherData = createWeatherData(context: viewContext,
                                                            dt: 1679432400,
                                                            temp: 282.38,
                                                            feels_like: 279.91,
                                                            temp_min: 282.38,
                                                            temp_max: 282.38,
                                                            pressure: 1012,
                                                            sea_level: 1012,
                                                            grnd_level: 1007,
                                                            humidity: 84,
                                                            temp_kf: 0,
                                                            id: 04,
                                                            main: "Clouds",
                                                            descriptionStr: "overcast clouds",
                                                            icon: "04n",
                                                            all: 86,
                                                            speed: 0.13,
                                                            deg: 210,
                                                            gust: 7.99,
                                                            visibility: 10000,
                                                            pop: 0,
                                                            h3: 0.13)
        var newCity: CityData = createCity(context: viewContext,
                                           id: 2988507,
                                           name: "Paris",
                                           country: "FR",
                                           population: 2138551,
                                           timezone: 3600,
                                           sunrise: 1679032848,
                                           sunset: 1679075846,
                                           lat: 48.8534,
                                           lon: 2.3488)
        
        let newItem = Weather(context: viewContext)
        newItem.list = []
        newItem.list!.addingObjects(from: [newWeatherData])
        newItem.city = newCity
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ParisWeather")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    // MARK: - Preview Weather
    
    // MARK: Weather
    /// - Returns: WeatherData
    static func createWeatherData(context: NSManagedObjectContext,
                                  dt: Int,
                                  temp: Double,
                                  feels_like: Double,
                                  temp_min: Double,
                                  temp_max: Double,
                                  pressure: Int,
                                  sea_level: Int,
                                  grnd_level: Int,
                                  humidity: Int,
                                  temp_kf: Int,
                                  id: Int,
                                  main: String,
                                  descriptionStr: String,
                                  icon: String,
                                  all: Int,
                                  speed: Double,
                                  deg: Int,
                                  gust: Double,
                                  visibility: Int,
                                  pop: Double,
                                  h3: Double
                                  
                                  
                                  
                                  
    ) -> WeatherData {
        let preview = WeatherData(context:context)
        
        preview.dt = Int32(dt)
        preview.main = createWeatherMainData(context: context,
                                             temp: temp,
                                             feels_like: feels_like,
                                             temp_min: temp_min,
                                             temp_max: temp_max,
                                             pressure: pressure,
                                             sea_level: sea_level,
                                             grnd_level: grnd_level,
                                             humidity: humidity,
                                             temp_kf: temp_kf)
        preview.weather = []
        preview.weather!.addingObjects(from:createWeatherDescriptionData(
            context: context,
            id: id,
            main: main,
            descriptionStr: descriptionStr,
            icon: icon))
        preview.clouds = createWeatherCloudData(context: context,
                                                all: all)
        preview.wind = createWeatherWindData(context: context,
                                             speed: speed,
                                             deg: deg,
                                             gust: gust)
        preview.visibility = Int32(visibility)
        preview.pop = pop
        preview.rain = createWeatherRainData(context: context,
                                             h3: h3)
        preview.sys = createWeatherSysData(context: context,
                                           pod: "d")
        preview.dt_txt = "2023-03-21 18:00:00"
        
        return preview
    }
    
    /// WeatherMainData
    /// - Returns: WeatherMainData
    static func createWeatherMainData(context: NSManagedObjectContext,
                                      temp: Double,
                                      feels_like: Double,
                                      temp_min: Double,
                                      temp_max: Double,
                                      pressure: Int,
                                      sea_level: Int,
                                      grnd_level: Int,
                                      humidity: Int,
                                      temp_kf: Int) -> WeatherMainData? {
        let preview = WeatherMainData(context:context)
        preview.temp = temp
        preview.feels_like = feels_like
        preview.temp_min = temp_min
        preview.temp_max = temp_max
        preview.pressure = Int32(pressure)
        preview.sea_level = Int32(sea_level)
        preview.grnd_level = Int32(grnd_level)
        preview.humidity = Int32(humidity)
        preview.temp_kf = Double(temp_kf)
        
        return preview
    }
    
    /// - Returns: WeatherDescriptionData
    static func createWeatherDescriptionData(context: NSManagedObjectContext,
                                             id: Int,
                                             main: String,
                                             descriptionStr: String,
                                             icon: String) -> [WeatherDescriptionData] {
        var array : [WeatherDescriptionData] = []
        
        let preview = WeatherDescriptionData(context:context)
        preview.id = Int32(id)
        preview.main = main
        preview.descriptionStr = descriptionStr
        preview.icon = icon
        
        array.append(preview)
        
        return array
    }
    
    /// - Returns: WeatherCloudData
    static func createWeatherCloudData(context: NSManagedObjectContext, all: Int) -> WeatherCloudData? {
        let preview = WeatherCloudData(context:context)
        preview.all = Int32(all)
        
        return preview
    }
    
    /// - Returns: WeatherWindData
    static func createWeatherWindData(context: NSManagedObjectContext,
                                      speed: Double,
                                      deg: Int,
                                      gust: Double) -> WeatherWindData? {
        let preview = WeatherWindData(context:context)
        preview.speed = speed
        preview.deg = Int32(deg)
        preview.gust = gust
        
        return preview
    }
    
    /// - Returns: WeatherRainData
    static func createWeatherRainData(context: NSManagedObjectContext,
                                      h3: Double) -> WeatherRainData? {
        let preview = WeatherRainData(context:context)
        preview.h3 = h3
        
        return preview
    }
    
    /// - Returns: WeatherSysData
    static func createWeatherSysData(context: NSManagedObjectContext,
                                     pod: String) -> WeatherSysData? {
        let preview = WeatherSysData(context:context)
        preview.pod = pod
        
        return preview
    }
    
    // MARK: CityData
    /// - Returns: CityData
    static public func createCity(context: NSManagedObjectContext,
                           id: Int,
                           name: String,
                           country: String,
                           population: Int,
                           timezone: Int,
                           sunrise: Int,
                           sunset: Int,
                           lat: Double,
                           lon: Double) -> CityData {
        let preview = CityData(context: context)
        preview.id = Int32(id)
        preview.name = name
        preview.country = country
        preview.population = Int32(population)
        preview.timezone = Int32(timezone)
        preview.sunrise = Int32(sunrise)
        preview.sunset = Int32(sunset)
        preview.coord = createCityCoordinateData(context: context, lat: lat, lon: lon)
        
        return preview
    }
    /// - Returns: CityCoordinateData
    static func createCityCoordinateData(context: NSManagedObjectContext,
                                         lat: Double,
                                         lon: Double) -> CityCoordinateData? {
        let preview = CityCoordinateData(context: context)
        preview.lat = lat
        preview.lon = lon
        
        return preview
    }
}
