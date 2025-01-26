//
//  ContentView.swift
//  AvatarSample
//
//  Created by Jason Qiu on 2025/1/25.
//

import SwiftUI

struct ContentView: View {
    @State var people = Person.samples
    var body: some View {
        List(people) { person in
            AvatarView(person: person)
//            .padding()
        }
    }
}

#Preview {
    ContentView()
}
