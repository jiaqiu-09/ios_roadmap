//
// Person.swift
// AvatarSample
//
// Created by Peter Friese on 28.08.23.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation

struct Person: Identifiable {
  var id = UUID()
  var fullName: String
  var jobtitle: String
  var affiliation: String

  var profileImageName: String {
    fullName.lowercased().replacingOccurrences(of: " ", with: "-")
  }
}

extension Person {
  static var samples: [Person] = [
    .init(fullName: "Alex Kudelka", jobtitle: "Co-Founder & CRO", affiliation: "Glassfy"),
    .init(fullName: "Allison Mcentire", jobtitle: "Software Engineer", affiliation: "URBN"),
    .init(fullName: "Anum Mian", jobtitle: "iOS Developer", affiliation: "The Guardian"),
    .init(fullName: "Araks Avoyan", jobtitle: "iOS Engineer", affiliation: "Spotify"),
    .init(fullName: "Audrey Sobgou Zebaze", jobtitle: "iOS/macOS Software Engineer", affiliation: "Proton"),
    .init(fullName: "Avi Tsadok", jobtitle: "Head Of Mobile", affiliation: "Melio"),
    .init(fullName: "Chris Greening", jobtitle: "Technology Advisor", affiliation: "Self-employed"),
    .init(fullName: "Daniel Kennett", jobtitle: "Cocoa developer", affiliation: "Cascable"),
    .init(fullName: "Daniel Tull", jobtitle: "Cocoa developer", affiliation: "Cascable"),
    .init(fullName: "Evgenii Matsiuk", jobtitle: "Co-Founder", affiliation: "MarathonLabs"),
    .init(fullName: "Leah Vogel", jobtitle: "Senior Engineering Manager", affiliation: "Chegg"),
    .init(fullName: "Lena Mattea Stöxen", jobtitle: "Student", affiliation: "Volkswagen Commercial Vehicles"),
    .init(fullName: "Luke Stringer", jobtitle: "Tech Principal", affiliation: "AND Digital"),
    .init(fullName: "Michael Baldock", jobtitle: "Senior Software Engineer", affiliation: "Skyscanner"),
    .init(fullName: "Mike Abdullah", jobtitle: "Lead iOS & Mac Developer", affiliation: "Karelia Software"),
    .init(fullName: "Natalia Panferova", jobtitle: "Senior iOS Developer & Director", affiliation: "Nil Coalescing Limited"),
    .init(fullName: "Oliver Binns", jobtitle: "Lead Mobile Developer", affiliation: "Deloitte"),
    .init(fullName: "Oliver Foggin", jobtitle: "iOS Principal", affiliation: "Jugo"),
    .init(fullName: "Peter Friese", jobtitle: "Senior Developer Advocate", affiliation: "Google"),
    .init(fullName: "Pol Piella Abadia", jobtitle: "Senior Software Engineer", affiliation: "BBC"),
    .init(fullName: "Rich Turton", jobtitle: "iOS Developer", affiliation: "MartianCraft"),
    .init(fullName: "Rizwan Ahmed", jobtitle: "Senior iOS Engineer", affiliation: "ohmyswift.com"),
    .init(fullName: "Tim Condon", jobtitle: "Engineer & Founder", affiliation: "Broken Hands"),
    .init(fullName: "Zamzam Farzamipooya", jobtitle: "Tech Lead & Senior iOS Engineer", affiliation: "Veo.co"),
    .init(fullName: "Emad Ghorbaninia", jobtitle: "Lead Engineer", affiliation: "Visma Acubiz"),
    .init(fullName: "Paul Hudson", jobtitle: "himself", affiliation: "Hacking with Swift"),
    .init(fullName: "Anna Beltrami", jobtitle: "Software Engineer", affiliation: "Spotify"),
  ]

  static var sample = samples[0]
}

