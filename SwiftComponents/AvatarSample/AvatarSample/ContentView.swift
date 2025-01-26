//
//  ContentView.swift
//  AvatarSample
//
//  Created by Jason Qiu on 2025/1/25.
//

import SwiftUI

struct ContentView: View {
    @State var people = Person.samples
    @State var participants = Person.samples.filter { person in
        person.isParticipant
    }
    var body: some View {
        List{
        
            Section("Participants") {
                ForEach(participants) { participant in
                    AvatarView(person: participant)
                        .avatarImageShape(AvatarImageShape.round)
                }
            }
            Section("Speakers") {
                ForEach(people) { person in
                    AvatarView(person: person)
                }
            }
        }
        .avatarImageShape(AvatarImageShape.rectangle)
    }
}

#Preview {
    ContentView()
}
