//
//  CoursesViewController.swift
//  Networking
//
//  Created by Alex on 01.08.2020.
//  Copyright © 2020 Alex Sadunenko. All rights reserved.
//

import UIKit

class CoursesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var courses = [Course]()
    private var courseName: String?
    private var courseLink: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        
    }
    
    func fetchData() {
        
        let jsonURLString = "https://swiftbook.ru/wp-content/uploads/api/api_courses"
        
        guard let url = URL(string: jsonURLString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            print(data)
            
            do {
                let decodable = JSONDecoder()
                decodable.keyDecodingStrategy = .convertFromSnakeCase
                self.courses = try decodable.decode([Course].self, from: data)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    private func configureCell(cell: CoursesTableViewCell, for indexPath: IndexPath) {
        let course = courses[indexPath.row]
        cell.labelOne.text = course.name
        cell.labelTwo.text = course.link
        cell.labelThree.text = String(course.number_of_lessons ?? 0)
        
        DispatchQueue.global().async {
            guard let imageURL = URL(string: course.imageUrl!) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                cell.imageV.image = UIImage(data: imageData)
            }
        }
    }
    
}

extension CoursesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CoursesTableViewCell
        
        configureCell(cell: cell, for: indexPath)
        
        return cell
    }
    
}

extension CoursesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let course = courses[indexPath.row]
        courseName = course.name
        courseLink = course.link
        
        performSegue(withIdentifier: "segueToWeb", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToWeb" {
            let webVC = segue.destination as! WebViewController
            webVC.selectedCourse = courseName
            webVC.courseLink = courseLink ?? ""
        }
    }
    
}
