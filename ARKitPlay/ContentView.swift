//
//  ContentView.swift
//  ARKitPlay
//
//  Created by Jong Yoon Kim on 2022/02/07.
//

import SwiftUI

struct Experiment : Identifiable {
    var id: Int
    var name: String
}

struct ContentView: View {
    private let experiments: [Experiment] = [
        Experiment(id:0, name:"Face Mask"),
        Experiment(id:1, name:"Face Counter"),
        Experiment(id:2, name:"Ruler"),
    ]

    var body: some View {
        NavigationView {
            List(experiments) { experiment in
                let subtitle : Text = Text("\(experiment.name)")
                
                switch experiment.id {
                case 1:
                    NavigationLink(destination: FaceDetectionView()) { subtitle }
                case 2:
                    NavigationLink(destination: RulerView()) { subtitle }
                default:
                    NavigationLink(destination: FaceMaskView()) { subtitle }
                }
                
            }.navigationBarTitle(Text("ARKit Play"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
