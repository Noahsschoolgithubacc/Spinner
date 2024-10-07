//
//  ContentView.swift
//  Spinner
//
//  Created by PM Student on 10/7/24.
//

import SwiftUI

struct ContentView: View {
    
    struct Leaf: View {
        
        let rotation: Angle
        let isCurrent: Bool
        
        var body: some View {
            Capsule()
                .stroke(isCurrent ? Color.white : Color.gray, lineWidth: 8)
                .frame(width: 20, height: 50)
                .offset(x: 0, y: 70)
            
            // applies the calculated rotation angle to the view
                .rotationEffect(rotation)
        }
    }
    // ignore these comments. Bulk and multiplayer sell system
    // plate+re execute at @a [r=1 , hasitem={item=diamond , quantity=2..}] run scoreboard add @p Money 20
    // c+aa clear @a [r=2 , hasitem={item=diamond , quantity=2..}] diamond 0 2
    //
    // Npc tp to private storage using id system. ? = Int. Copy and add to new line with enumerated Id
    // execute as @initiator if entity @s [scores={Id=?}] run tp @s ? ? ?
    
    
    @State var currentIndex = -1
    
    var body: some View {
        VStack {
            ZStack {
                // renders 12 instances of the leaf
                ForEach(0..<12) { index in
                    // calculates rotation angle based on index position
                    Leaf(rotation: .init(degrees: .init(index) / .init(12) * 360),
                isCurrent: index == currentIndex
                         )
                }
            }
            // initiates animation when the view appears
            .onAppear(perform: animate)
        }
    }
    
    // animates the leaf x12 in a loop. Initiates an animation loop
    func animate() {
        Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { timer in
            currentIndex = (currentIndex + 1) % 12
        }
    }
}

#Preview {
    ContentView()
}
