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
        let isCompleted: Bool
        
        var body: some View {
            Capsule()
                .stroke(isCurrent ? Color.white : Color.gray, lineWidth: 10)
//                .frame(width: 20, height: 50)
            // initial offset
//                .offset(x: 0, y: 70)
            
            // item will fold in
                .frame(width: 20, height: isCompleted ? 20 : 50)
            
            // conditional offset based on isCurrent
                .offset(
                    isCurrent
                    ? .init(width: 10, height: 0)
                    : .init(width: 40, height: 70)
            )
            
            // makes leafs smaller
                .scaleEffect(isCurrent ? 0.5 : 1)
            
            // applies the calculated rotation angle to the view
//                .rotationEffect(rotation)
            
            // item will fold in on itself
                .rotationEffect(isCompleted ? .zero : rotation)
                .animation(.easeInOut(duration: 1.5), value: isCompleted)
        }
    }
    // ignore these comments
    // Npc tp to private storage using id system. ? = Int. Copy and add to new line with enumerated Id
    // execute as @initiator if entity @s [scores={Id=?}] run tp @s ? ? ?
    
    
    @State var currentIndex = -1
    @State var completed = false
    @State var isVisible = true
    @State var currentOffset = CGSize.zero
    
    // transition that will move item upwards and off the screen
    let shootUp = AnyTransition.offset(x: 0, y: -1000)
        .animation(.easeIn(duration: 1))
    
    var body: some View {
        VStack {
            
            
            
            if isVisible {
                
                
                
                
                ZStack {
                    // renders 12 instances of the leaf
                    ForEach(0..<12) { index in
                        // calculates rotation angle based on index position
                        Leaf(rotation: .init(degrees: .init(index) / .init(12) * 360),
                             isCurrent: index == currentIndex,
                             isCompleted: completed
                        )
                    }
                }
                .offset(currentOffset)
                
                .blur(radius: currentOffset == .zero ? 0 : 10)
                
                .animation(.easeIn(duration: 1), value: currentOffset)
                
                .gesture(DragGesture()
                    .onChanged { gesture in
                        currentOffset = gesture.translation
                    }
                    .onEnded{ gesture in
                        if currentOffset.height > 150 {
                            isCompleted()
                        }
                        currentOffset = .zero
                    }
                )
                         
                .transition(shootUp)
                // initiates animation when the view appears
                .onAppear(perform: animate)
            }
        }
    }
    
    func isCompleted() {
        guard !completed else { return }
        
        completed = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            withAnimation {
                isVisible = false
            }
        }
    }
    
    // animates the leaf x12 in a loop. Initiates an animation loop
    func animate() {
        
        var iteration = 0
        
        Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { timer in
            currentIndex = (currentIndex + 1) % 12
            iteration += 1
            
            // animation runs 30 times
            if iteration == 36 {
                timer.invalidate()
                isCompleted()
                completed = true
                
                // circle fades away after 2 seconds
                
            }
        }
    }
}

#Preview {
    ContentView()
}
