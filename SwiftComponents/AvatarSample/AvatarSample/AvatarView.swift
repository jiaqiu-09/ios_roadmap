//
//  AvatarView.swift
//  AvatarSample
//
//  Created by Jason Qiu on 2025/1/26.
//

import SwiftUI


enum AvatarImageShape {
    case round
    case rectangle
}

struct AvatarImageShapeKey: EnvironmentKey {
    static var defaultValue: AvatarImageShape = .round
}

extension EnvironmentValues {
    var avatarImageShape: AvatarImageShape {
        get {self[AvatarImageShapeKey.self] }
        set {self[AvatarImageShapeKey.self] = newValue}
    }
}

extension View {
    func avatarImageShape(_ imageShape: AvatarImageShape) -> some View {
        environment(\.avatarImageShape, imageShape)
    }
}

struct AvatarView: View {
    @Environment(\.avatarImageShape) var imageShape
    var person: Person
    
    @ViewBuilder
    private var profileImage: some View {
        if (imageShape == .round) {
            Image(person.profileImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 75, height: 75, alignment: .center)
                .clipShape(.circle)
                .accessibilityLabel(person.fullName)
        } else {
            Image(person.profileImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 75, height: 75, alignment: .center)
                .accessibilityLabel(person.fullName)
        }
    }
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
            profileImage
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
        .avatarImageShape(AvatarImageShape.rectangle)
        .padding()
    AvatarView(person: Person.sample)
        .padding()
}
