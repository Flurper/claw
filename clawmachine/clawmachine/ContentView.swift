//
//  ContentView.swift
//  clawmachine
//
//  Created by AM Student on 9/25/24.
//

import SwiftUI

struct ContentView: View {
    @State var rotation = 0.0
    @State var length = 50.0
    @State var timer = Timer.publish(every: 0.1, on: .main, in: .common) .autoconnect()
    @State var outerLineStart: CGFloat = 0.009 * 150
    
    let innerRadius = 25.0
    
    @GestureState var up = false
    @GestureState var down = false
    
    var body: some View {
        ZStack {
            Image("clawgamebackground")
                .resizable()
                .ignoresSafeArea()
            VStack {
                ZStack(alignment: .top) {
                    VStack {
                        Line(length: length)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.gray)
                            .animation(Animation.linear, value: length)
                            .frame(width: 4, height: 500)
                            .offset(x: -innerRadius - 2, y: -39)
                        
                        Image("claw")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .offset(x: -innerRadius, y: -(500 - length))
                            .animation(Animation.linear, value: length)
                    }
                    ZStack {
                        Circle()
                            .trim(from: 0, to: outerLineStart)
                            .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                            .rotationEffect(Angle(degrees: -180))
                            .frame(width: (innerRadius * 2) + 4)
                            .foregroundColor(.gray)
                            .animation(Animation.linear, value: outerLineStart)
                        
                        ZStack {
                            Circle()
                                .stroke(lineWidth: 8)
                                .frame(width: 100, height: 100)
                                .foregroundColor(.white)
                            
                            ForEach(0..<6) { item in
                                Rectangle()
                                    .frame(width: 4, height: (innerRadius * 4) + 20)
                                    .foregroundColor(.white)
                                    .rotationEffect(Angle(degrees: Double(item * 60)))
                            }
                            Circle()
                                .frame(width: innerRadius * 2, height: innerRadius * 2)
                                .foregroundColor(Color("darkcolor"))
                        }
                        .rotationEffect(Angle(degrees: rotation))
                        .animation(Animation.linear, value: rotation)
                        
                    }
                }
                HStack {
                    Image(systemName: "arrowtriangle.up.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .shadow(color: up ? .clear: .white, radius: 3, x: 1, y: 1)
                        .foregroundColor(up ? .yellow : .black)
                        .animation(Animation.linear, value: up)
                        .gesture(DragGesture(minimumDistance: 0.0)
                            .updating($up, body: { value, state, transaction in
                                state = true
                            }))
                    
                    
                    Spacer()
                    
                    Image(systemName: "arrowtriangle.up.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .rotationEffect(Angle(degrees: 180))
                        .shadow(color: down ? .clear: .white, radius: 3, x: 1, y: 1)
                        .foregroundColor(down ? .yellow : .black)
                        .animation(Animation.linear, value: down)
                        .gesture(DragGesture(minimumDistance: 0.0)
                            .updating($down, body: { value, state, transaction in
                                state = true
                            }))
                }
                .frame(width: 200, height: 50)
            }
        }
        .onReceive(timer) { time in
            if up {
                moveUp()
            }
            if down {
                moveDown()
            }
        }
    }
    func moveUp() {
        if length > 100 {
            rotation = up ? rotation + (3.45) : rotation
            length = up ? length - 3 : length
            outerLineStart = up ? outerLineStart + 0.009 : outerLineStart
        }
    }
    func moveDown() {
        if length < 500 {
            rotation = down ? rotation - (3.45) : rotation
            length = down ? length + 3 : length
            outerLineStart = down ? outerLineStart - 0.009 : outerLineStart
        }
    }
}

#Preview {
    ContentView()
}
