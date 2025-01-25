//
//  ContentView.swift
//  PackageTest
//
//  Created by Jason Qiu on 2025/1/25.
//

import SwiftUI
import FloatingTextInputField

struct ContentView: View {
    @State var name = ""
    var body: some View {
        Form {
            TextInputField("name", text: $name)
        }
    }
}

#Preview {
    ContentView()
}
