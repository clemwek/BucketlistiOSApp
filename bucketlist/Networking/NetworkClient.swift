//
//  Network.swift
//  bucketlist
//
//  Created by Clement  Wekesa on 28/06/2018.
//  Copyright © 2018 Clement  Wekesa. All rights reserved.
//

import Foundation

class NetworkClient {
    static let standard = NetworkClient()
    let baseURL = URL(string: "https://clembucketlistapi.herokuapp.com")
    
    let config = URLSessionConfiguration.default
    //    var componentURL = URLComponents(url: baseURL!, resolvingAgainstBaseURL: true)
    
    private init() {
        
    }
    
    func post(url: String, data: [String: String], completion: @escaping (_ succes: Bool) -> (Void)) {
        
        let session = URLSession(configuration: config)
        
        let relativeURL = URL(string: url, relativeTo: baseURL)
        guard
            let url = URLComponents(url: relativeURL!, resolvingAgainstBaseURL: true)?.url
            else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: String] = data
        let httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        request.httpBody = httpBody
        
        let task = session.dataTask(with: request) { data, response, error in
            guard
                error == nil else {
                    print(error!)
                    completion(false)
                    return
            }
            
            guard
                let responseData = data
                else {
                    print("Error, did not receive data")
                    completion(false)
                    return
            }
            do {
                guard
                    let formattedData = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]
                    else {
                        completion(false)
                        print("Error trying to convert data to json")
                        return
                }
                guard
                    let statusCode = (response as? HTTPURLResponse)?.statusCode
                    else { return }
                if String(statusCode).first == "2" {
                    completion(true)
                    print(formattedData)
                }
                completion(false)
                print(formattedData)
            } catch {
                completion(false)
                print(error)
            }
        }
        
        task.resume()
        
    }
}
