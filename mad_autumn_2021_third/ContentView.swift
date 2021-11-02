//
//  ContentView.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 01.11.2021.
//

import SwiftUI
import SwiftUIX

struct ContentView: View {

    @StateObject var alert: AlertInfo = .init(nil)
    
    init() {
        UINavigationBar.appearance().tintColor = .white
 
        
    }
    
    @StateObject var networkService = NetworkService.shared
//
//    @State var token: AuthResp? = (try? JSONDecoder().decode(AuthResp.self, from: UserDefaults.standard.data(forKey: "token") ?? .init())) {
//        didSet {
//            UserDefaults.standard.set(try? JSONEncoder().encode(token), forKey: "token")
//        }
//    }
    
    
    
    @ViewBuilder
    var content: some View {
        if networkService.token?.accessToken != nil, networkService.token?.accessTokenDate?.isInFuture == true {
            TabbedView()
        } else {
            StartScreen(vm: .init(alert))
        }
    }
    
    var body: some View {
        content.environmentObject(alert).alert(isPresented: .init(get: {
            alert.info != nil
        }, set: {
            alert.info = $0 ? alert.info : nil
        })) {
            alert.info ?? .init(title: Text(""), message: nil, dismissButton: nil)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
