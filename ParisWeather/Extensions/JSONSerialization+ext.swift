//
//  JSONSerialization+ext.swift
//  ParisWeather
//
//  Created by Cedrik on 19/03/2023.
//

import Foundation

extension JSONSerialization {
    static func loadJSON(withFilename filename: String) throws -> Data? {
        let fm = FileManager.default
        let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
        if let url = urls.first {
            var fileURL = url.appendingPathComponent(filename)
            fileURL = fileURL.appendingPathExtension("json")
            let data = try Data(contentsOf: fileURL)
//            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers, .mutableLeaves])
            return data
        }
        return nil
    }
    
    static func saveToFile(jsonString: String, toFilename filename: String) throws {
           let fm = FileManager.default
           let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
           if let url = urls.first {
               var fileURL = url.appendingPathComponent(filename)
               fileURL = fileURL.appendingPathExtension("json")
               do {
                   try jsonString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
                   print("✅ FileCreated")
               } catch {
                  throw error
               }
           }
       }
}
