//
//  ContentView.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 01.11.2021.
//

import SwiftUI
import SwiftUIX

struct ContentView: View {

    @StateObject var notifications = Notifications()
    
    init() {
        UINavigationBar.appearance().tintColor = .white
        UITextView.appearance().backgroundColor = .clear
    }

    @StateObject var networkService = NetworkService.shared
    
    @ViewBuilder
    var content: some View {
        if networkService.token?.accessToken != nil, networkService.token?.accessTokenDate?.isInFuture == true {
            TabbedView()
        } else {
            StartScreen(vm: .init(notifications))
        }
    }
    
    var body: some View {
        content.environmentObject(notifications).alert(isPresented: .init(get: {
            notifications.alert != nil
        }, set: {
            notifications.alert = $0 ? notifications.alert : nil
        })) {
            notifications.alert ?? .init(title: Text(""), message: nil, dismissButton: nil)
        }.overlay {
            MyActivityIndicator(isLoading: notifications.isLoading)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
