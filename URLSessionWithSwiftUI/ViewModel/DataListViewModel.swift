//
//  DataListViewModel.swift
//  URLSessionWithSwiftUI
//
//  Created by iXavy on 7/11/22.
//

import Foundation
import Combine


// Hay dos requisitos indispensables para que Combine funcione: 1.- Que la clase conforme el protocolo ObservableObject. 2.- La propiedad que declaremos para que reciba
// de forma reactiva los cambios (en nuestro caso la propiedad data, debe tener el property wrapper @Published, para que pueda ser publicado

// La clase debe conformar con el protocolo ObservableObject
class DataListViewModel: ObservableObject {
    
    //    Inicializador sin parámetros para que cuando se llame a este ViewModel, se ejecute el método getJson()
    
    init() {
        getData()
    }
    
    @Published var data = [DataModel] () {
//        Cambia el valor de la propiedad cuando este valor se modifique desde fuera. Las propiedades calculadas tienen didSet y willSet
        didSet {
//        A nuestra propiedad que recibirá los cambios externos le informamos del input (quien lo va a hacer) y le informamos que esta clase (DataListViewModel), o sea, self
            didChange.send(self)
        }
    }
    
//    Utilizamos el framework Combine para que informe a una propiedad que creamos (didChange) cuando ocurra un error
//    A PasstroughSubject se le pasan dos parámetros: Quien gestiona la emisión de datos y el error en caso que ocurra. En este caso utilizamos Never para no gestionar los errores
    
    let didChange = PassthroughSubject<DataListViewModel, Never>()
    
//    Atacamos la capa de conexión mediante la siguiente función, trayéndonos un JSON
    
    func getData() {
        NetworkManager().getJson { (dataSerialized) in
//        Voy a asignar lo que traigo de la capa de conexión a una propiedad (calculada) de mi ViewModel
            self.data = dataSerialized
        }
        
//      La sintaxis de arriba también puede escribirse más simplificada, al haber un sólo parámetro, podemos obviarlo quitando también la palabra in, como a continuación:
//
//      NetworkManager().getJson {
//         self.data = $0
//       }
    }
}

