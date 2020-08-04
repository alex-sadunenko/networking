//
//  StartViewController.swift
//  Networking
//
//  Created by Alex on 01.08.2020.
//  Copyright © 2020 Alex Sadunenko. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func getAction(_ sender: UIButton) {
        
        let baseURLString = "https://jsonplaceholder.typicode.com"
        let requestString = "/posts"
        
        guard let url = URL(string: baseURLString + requestString) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let response = response, let data = data else { return }
            print(response)
            print(data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }.resume()
        
    }
    
    @IBAction func postAction(_ sender: UIButton) {
        
        let baseURLString = "https://jsonplaceholder.typicode.com"
        let requestString = "/posts"
        guard let url = URL(string: baseURLString + requestString) else { return }
        
        let userData = ["Course": "Networking", "Lessons": "GET and POST"]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: userData, options: []) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data, let response = response else { return }
            
            print(response)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }.resume()
        
        
    }
    
    
}
