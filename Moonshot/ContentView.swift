//
//  ContentView.swift
//  Moonshot
//
//  Created by Rishav Gupta on 07/06/23.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var isGridLayout = true
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            Group {
                if isGridLayout {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            loopMission(missions: missions)
                        }
                        .padding([.horizontal, .bottom])
                    }
                } else {
//                    ScrollView {
//                        LazyVStack {
//                            loopMission(missions: missions)
//                        }
//                    }
                    List {
                        loopMission(missions: missions)
                    }
                    .listStyle(.plain)
                    .listRowBackground(Color.darkBackground)
                }
            }
            .navigationTitle("Moonshot")
//            .background(.lightBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button("Toggle", action: toolBarClicked)
                    .accessibilityLabel("Press this to change layout")
            }
        }
    }
    
    func loopMission(missions: [Mission]) -> some View  {
        ForEach(missions) { mission in
            NavigationLink {
                MissionView(mission: mission, astronauts: astronauts)
                    .accessibilityLabel("Click to view Details")
            } label: {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding()
                    
                    VStack {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text(mission.formattedLaunchDate)
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.5))
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(.lightBackground)
                    .accessibilityElement()
                    .accessibilityLabel("\(mission.displayName) launched on")
                    .accessibilityHint("\(mission.formattedLaunchDate)")
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                        .stroke(.lightBackground)
                )
            }
        }
    }
    
    func toolBarClicked() {
        isGridLayout.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
