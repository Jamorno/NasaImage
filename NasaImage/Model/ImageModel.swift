//
//  ImageModel.swift
//  NasaImage
//
//  Created by Jamorn Suttipong on 7/2/2568 BE.
//

import Foundation

struct ImageModel: Codable {
    let date: String
    let explanation: String
    let title: String
    let url: String?
    let hdurl: String?
}
