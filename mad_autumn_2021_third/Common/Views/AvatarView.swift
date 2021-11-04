//
//  AvatarView.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 04.11.2021.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct AvatarView: View {
    let url: URL?

    var body: some View {
        WebImage(url: url).placeholder(Image("avatarDefault")).resizable().scaledToFill()
    }
}
