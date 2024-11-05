//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by Jason Qiu on 2024/11/5.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(.systemMint)
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 20.0) {
                Image("bridge")
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fit)
                    .cornerRadius(15)
                HStack {
                    Text("Golden Gate Bridge")
                        .bold()
                        .font(.system(size: 24))
                    Spacer()
                    VStack {
                        HStack {
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                            Image(systemName: "star.leadinghalf.filled")
                        }
                        Text("(Reviews 361)")
                    }.foregroundColor(Color.orange)
                }
                Text(
                    "The Golden Gate Bridge is a suspension bridge spanning the Golden Gate, the one-mile-wide (1.6 km) strait connecting San Francisco Bay and the Pacific Ocean. "
                )
                HStack {
                    Spacer()
                    Image(systemName: "fork.knife")
                    Image(systemName: "binoculars.fill")
                }.foregroundColor(.gray)
                
            }
            .padding()
            .background(Rectangle()
                .foregroundColor(.white)
                .cornerRadius(15)
                .shadow(radius: 15)
            )
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
