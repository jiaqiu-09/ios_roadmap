//
//  ReminderToggleStyle.swift
//  CustomToggleStyles
//
//  Created by Jason Qiu on 2025/1/26.
//

import SwiftUI

struct ReminderToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "largecircle.fill.circle" : "circle")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .accentColor: .gray)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            configuration.label
        }
    }
}

extension ToggleStyle where Self == ReminderToggleStyle {
    static var reminder: ReminderToggleStyle {
        ReminderToggleStyle()
    }
}


#Preview {
  Toggle(isOn: .constant(true)) {
    Text("Just do it")
  }.toggleStyle(.reminder)
}
