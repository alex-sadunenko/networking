//
//  Course.swift
//  Networking
//
//  Created by Alex on 01.08.2020.
//  Copyright © 2020 Alex Sadunenko. All rights reserved.
//

import Foundation

struct Course: Decodable {
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: String?
    let number_of_lessons: Int?
    let number_of_tests: Int?
}
