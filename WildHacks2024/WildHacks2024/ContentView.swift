//
//  ContentView.swift
//  WildHacks2024
//
//  Created by Ziye Wang on 4/1/24.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        HStack {
            RoundedRectangle(cornerRadius: 10).foregroundColor(.red)
    }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
