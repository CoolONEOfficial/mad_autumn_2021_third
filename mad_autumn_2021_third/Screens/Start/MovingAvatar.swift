//
//  MovingAvatar.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 02.11.2021.
//

import SwiftUI

struct MovingAvatar: View {
    let name: String
    
    @State var offset: CGSize = .zero
    
    static let speed: CGFloat = 3
    
    let gen = SystemRandomNumberGenerator.init()
    
    @State var acceleration: CGSize = .init(width: .random(in: 1...Self.speed) * [1, -1].randomElement()!, height: .random(in: 1...Self.speed) * [1, -1].randomElement()!)

    static let duration: CGFloat = 0.1
    
    let timer = Timer.publish(every: Self.duration, on: .main, in: .common).autoconnect()

    static let size: CGFloat = 100
    
    var body: some View {
        GeometryReader { proxy in
            if offset == .zero {
                let _ = DispatchQueue.main.async {
                    guard proxy.size.width > Self.size, proxy.size.height > Self.size else { return }
                    offset = .init(width: .random(in: 0..<proxy.size.width - Self.size), height: .random(in: 0..<proxy.size.height - Self.size))
                }
            }
            Image(name).resizable().width(Self.size).height(Self.size).offset(self.offset)
                .onReceive(timer) { _ in
                    let nextX = offset.x + acceleration.x
                    let nextY = offset.y + acceleration.y
                    if !(-Self.speed / 2...proxy.size.width - Self.size + Self.speed / 2 ~= nextX) {
                        acceleration = .init(width: -acceleration.width, height: acceleration.height)
                    }
                    
                    if !(-Self.speed / 2...proxy.size.height - Self.size + Self.speed / 2 ~= nextY) {
                        acceleration = .init(width: acceleration.width, height: -acceleration.height)
                    }
                    
                    withAnimation(.linear(duration: Self.duration)) {
                        offset = CGSize(width: offset.x + acceleration.x, height: offset.y + acceleration.y)
                    }
                }
        }
    }
}

//struct MovingAvatar_Previews: PreviewProvider {
//    static var previews: some View {
//        MovingAvatar()
//    }
//}
