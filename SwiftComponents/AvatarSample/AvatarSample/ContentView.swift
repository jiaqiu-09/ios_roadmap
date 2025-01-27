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
                    AvatarView(title: participant.fullName, subTitle: participant.jobtitle, detailsTitle: participant.affiliation, imageName: participant.profileImageName)
                        .avatarImageShape(AvatarImageShape.round)
                }
            }
            Section("Speakers") {
                ForEach(people) { person in
                    AvatarView(title: person.fullName, subTitle: person.jobtitle, detailsTitle: person.affiliation, imageName: person.profileImageName)
                }
            }
        }
        .avatarImageShape(AvatarImageShape.rectangle)
    }
}

#Preview {
    ContentView()
}
