//
//  NetworkManager.swift
//  URLSessionWithSwiftUI
//
//  Created by iXavy on 6/11/22.
//

// Capa de conexión

import Foundation

class NetworkManager {
    
//  Aquí crearemos una Closure con ESCAPE para devolver un array de mis datos. Entre paréntesis lo que devuelve la closure con escape
    
    func getJson(completion: @escaping([DataModel]) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            fatalError("La URL no es correcta o no se ha podido acceder a ella")
        }
        
        URLSession.shared.dataTask(with: url) { dataOptional, responseOptional, error in
            guard let data = dataOptional, error == nil, let response = responseOptional as? HTTPURLResponse else {
                return
            }
            
            if response.statusCode == 200 {
//          Serializamos los datos que tengamos
                do {
                    let dataSerialized = try JSONDecoder().decode([DataModel].self, from: data)
//  Aunque posiblemente funcionara, como estamos utilizando una closure con escape (la que contiene el método getJson), le indicamos que lo que devuelva completion,
//  lo haga dentro del hilo principal de forma asíncrona.
                    DispatchQueue.main.async {
                        completion(dataSerialized)
                    }
                } catch let error {
                    print("Ha ocurrido un error: \(error.localizedDescription)")
                }
            }
        }.resume()
        
    }
    
}
