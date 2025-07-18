//
//  ContentView.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 14/7/2568 BE.
//

import SwiftUI
internal import Combine

class CounterModel: ObservableObject {
    var objectWillChange: ObservableObjectPublisher

    @Published var count = 0
    
    init(objectWillChange: ObservableObjectPublisher = .init(),
         count: Int = 0) {
        self.objectWillChange = objectWillChange
        self.count = count
    }
}

class SceneStroge: ObservableObject {
    @SceneStorage("counter")
    var counterValue: Int = 0
}

struct Datasource: Identifiable {
    var id: UUID
    var value: String

    init(id: UUID = .init(),
         value: String) {
        self.id = id
        self.value = value
    }
}

class AsyncTasl {
    
    func fetchTexts() async -> [Datasource] {
        // wait for 1 sec
        sleep(1)
        return Array(1...20).map { Datasource(value: String($0)) }
    }
}

struct ContentView: View {
    
    @State
    var toggleValue: Bool = false
    
    @StateObject
    var sceneStroge: SceneStroge = .init()
    
    @StateObject
    var counterModel: CounterModel = .init()
    
    @State
    var texts: [Datasource] = [
        .init(value: "A"),
        .init(value: "B"),
        .init(value: "C"),
    ]
            
    @State
    var search: String = ""
    
    var body: some View {
        
        List {
            Text("Hello")
        }.background()            
    }
}

struct ModelView: View {
    @Binding var show: Bool
    let text: String
    
    var body: some View {
        if show {
            Text(text)
                .onTapGesture {
                    show.toggle()
                }
        }
        else {
            Text("Empty")
        }
    }
}

#Preview {
    Group {
        ContentView()
        //ContentView()
    }
    
//    Group {
//        ContentView()
//        //ContentView()
//    }
    
//    ModelView(show: true,
//              text: "Hello")
}
