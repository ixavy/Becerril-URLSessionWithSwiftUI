//
//  ContentView.swift
//  URLSessionWithSwiftUI
//
//  Created by iXavy on 6/11/22.
//

import SwiftUI

struct ContentView: View {
    
//    Declaramos una propiedad conectándola con nuestro modelo de datos, como variable ya que puede cambiar de valor
//    y con el property wrapper ObservedObject para darle reactividad
    
    @ObservedObject var model = DataListViewModel()
    
    var body: some View {
        List(model.data) {
            Text($0.title)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
