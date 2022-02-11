//
//  RulerViewRepresentable.swift
//  ARKitPlay
//
//  Created by Jong Yoon Kim on 2022/02/09.
//

import SwiftUI
import ARKit

struct RulerViewRepresentable: UIViewRepresentable {
    let rulerDelegate:RulerDelegate
    
    func makeUIView(context: Context) -> some UIView {
        let rulerView = ARSCNView(frame: .zero)
        rulerDelegate.setARView(rulerView)
        return rulerView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct RulerViewRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        RulerViewRepresentable(rulerDelegate: RulerDelegate())
    }
}

