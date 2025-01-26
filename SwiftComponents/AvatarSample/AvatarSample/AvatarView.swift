//
//  AvatarView.swift
//  AvatarSample
//
//  Created by Jason Qiu on 2025/1/26.
//

import SwiftUI


struct AvatarView: View {
    var person: Person
    private var titleLabel: some View {
        Text(person.fullName)
            .font(.headline)
    }
    private func detailLabel(_ text: String) -> some View {
        Text(text)
            .font(.subheadline)
    }
    
    var body: some View {
        HStack(alignment: .top) {
            Image(person.profileImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 75, height: 75, alignment: .center)
                .clipShape(.circle)
                .accessibilityLabel(person.fullName)
            VStack(alignment: .leading) {
                titleLabel
                detailLabel(person.jobtitle)
                detailLabel(person.affiliation)
            }
            Spacer()
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel(person.fullName)
    }
}

#Preview {
    AvatarView(person: Person.sample)
        .padding()
}
