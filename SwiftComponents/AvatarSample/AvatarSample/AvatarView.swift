//
//  AvatarView.swift
//  AvatarSample
//
//  Created by Jason Qiu on 2025/1/26.
//

import SwiftUI


struct AvatarStyleConfiguration {
    let title: String
    let subTitle: String
    let detailsTitle: String
    let imageName: String
    let editProfileHandler: (() -> Void)?
}

protocol AvatarStyle {
    associatedtype Body: View
    
    @ViewBuilder
    func makeBody(configuration: Configuration) -> Body
    
    typealias Configuration = AvatarStyleConfiguration
}

struct AvatarStyleKey: EnvironmentKey {
    static var defaultValue: any AvatarStyle = DefaultAvatarStyle()
}

extension EnvironmentValues {
    var avatarStyle: any AvatarStyle {
        get {
            self[AvatarStyleKey.self]
        }
        set {
            self[AvatarStyleKey.self] = newValue
        }
    }
}

extension View {
    func avatarStyle(_ style: some AvatarStyle) -> some View {
        environment(\.avatarStyle, style)
    }
}

struct DefaultAvatarStyle: AvatarStyle {
    @Environment(\.avatarImageShape) var imageShape
    
    private func titleLabel(_ text: String) -> some View {
        Text(text)
            .font(.headline)
    }
    private func detailLabel(_ text: String) -> some View {
        Text(text)
            .font(.subheadline)
    }
    
    @ViewBuilder
    private func profileImage(_ configuration:Configuration) -> some View {
        if (imageShape == .round) {
            Image(configuration.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 75, height: 75, alignment: .center)
                .clipShape(.circle)
                .accessibilityLabel(configuration.title)
        } else {
            Image(configuration.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 75, height: 75, alignment: .center)
                .accessibilityLabel(configuration.title)
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .top) {
            profileImage(configuration)
                .onTapGesture {
                    if let editProfileHandler = configuration.editProfileHandler {
                        editProfileHandler()
                    }
                }
            VStack(alignment: .leading) {
                titleLabel(configuration.title)
                detailLabel(configuration.subTitle)
                detailLabel(configuration.detailsTitle)
            }
            Spacer()
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel(configuration.title)
    }
}

//struct AvatarEditProfileHandler: EnvironmentKey {
//    static var defaultValue: (() -> Void)?
//}
//
//extension EnvironmentValues {
//    var editProfileHandler: (() -> Void)? {
//        get {self[AvatarEditProfileHandler.self] }
//        set {self[AvatarEditProfileHandler.self] = newValue}
//    }
//}
//
//extension View {
//    public func onEditProfile(editProfileHandler: @escaping () -> Void) -> some View {
//        environment(\.editProfileHandler, editProfileHandler)
//    }
//}

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
    @Environment(\.avatarStyle) var style
    
    var title: String
    var subTitle: String
    var detailsTitle: String
    var imageName: String
    var editProfileHandler: (() -> Void)?
    
    init(title: String, subTitle: String, detailsTitle: String, imageName: String, editProfileHandler: (() -> Void)? = nil) {
        self.title = title
        self.subTitle = subTitle
        self.detailsTitle = detailsTitle
        self.imageName = imageName
        self.editProfileHandler = editProfileHandler
    }
    
    var body: some View {
        let configuration = AvatarStyleConfiguration(title: title, subTitle: subTitle, detailsTitle: detailsTitle, imageName: imageName, editProfileHandler: editProfileHandler)
        
        AnyView(style.makeBody(configuration: configuration))
    }
}

#Preview {
    var person = Person.sample
    AvatarView(title: person.fullName, subTitle: person.jobtitle, detailsTitle: person.affiliation, imageName: person.profileImageName, editProfileHandler: {
        print("You've tapped on the profile image!")
    })
    .avatarImageShape(AvatarImageShape.rectangle)
    
    .padding()
    AvatarView(title: person.fullName, subTitle: person.jobtitle, detailsTitle: person.affiliation, imageName: person.profileImageName)
        .padding()
}
