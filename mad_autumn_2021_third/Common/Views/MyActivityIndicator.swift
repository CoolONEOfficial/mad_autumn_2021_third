//
//  MyActivityIndicator.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 01.11.2021.
//

import Foundation
import SwiftUI
import SwiftUIX

struct MyActivityIndicator: View {
    var isLoading: Bool
    
    @ViewBuilder
    var body: some View {
        if isLoading {
            ActivityIndicator().style(.large).tintColor(.orange).animated(true).background(Color.clear).fill()
        }
    }
}
