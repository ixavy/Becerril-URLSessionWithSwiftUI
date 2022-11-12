//
//  DataModel.swift
//  URLSessionWithSwiftUI
//
//  Created by iXavy on 6/11/22.
//

// Modelo de datos

import Foundation

// La ajustamos a tres protocolos: Codable, Hashable y Identifiable

struct DataModel: Codable, Hashable, Identifiable {
    
    var id = UUID()
    let title: String
    let body: String
}
                                                                                         
