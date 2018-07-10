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
    let defaults = UserDefaults.standard
    
    let config = URLSessionConfiguration.default
    
    private init() {
        
    }
    
    func get(url: String, query: [String: String]?, completion: @escaping (_ status: Bool, _ data: Any? ) -> ()) {
        
        let session = URLSession(configuration: config)
        
        let relativeURL = URL(string: url, relativeTo: baseURL)
        guard
            let url = URLComponents(url: relativeURL!, resolvingAgainstBaseURL: true)?.url,
            let token = defaults.string(forKey: "token")
            else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request) { data, response, error in
            guard
                error == nil,
                let responseData = data
                else { return completion(false, nil) }
            
            do {
                guard
                    let formattedData = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]
                    else {
                        completion(false, nil)
                        print("Error trying to convert data to json")
                        return
                }
                guard
                    let statusCode = (response as? HTTPURLResponse)?.statusCode
                    else { return }
                if String(statusCode).first == "2" {
                    return completion(true, formattedData)
                }
                completion(false, nil)
            } catch {
                completion(false, nil)
            }
        }
        task.resume()
        
    }
    
    func post(url: String, data: [String: String], completion: @escaping (_ succes: Bool, _ data: Any?) -> (Void)) {
        
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
                error == nil,
                let responseData = data
                else {
                    return completion(false, nil) }
            do {
                guard
                    let formattedData = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]
                    else {
                        completion(false, nil)
                        print("Error trying to convert data to json")
                        return
                }
                guard
                    let statusCode = (response as? HTTPURLResponse)?.statusCode
                    else { return }
                if String(statusCode).first == "2" {
                    return completion(true, formattedData)
                }
                completion(false, nil)
            } catch {
                completion(false, nil)
            }
        }
        task.resume()
    }
}
