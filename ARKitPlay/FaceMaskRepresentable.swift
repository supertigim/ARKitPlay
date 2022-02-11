//
//  FaceMaskRepresentable.swift
//  ARKitPlay
//
//  Created by Jong Yoon Kim on 2022/02/08.
//

import SwiftUI
import ARKit

struct FaceMaskViewRepresentable: UIViewRepresentable {
    let facemaskDelegate:FaceMaskDelegate
    
    func makeUIView(context: Context) -> some UIView {
        let facemaskView = ARSCNView(frame: .zero)
        facemaskDelegate.setARView(facemaskView)
        return facemaskView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct FaceMaskViewRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        FaceMaskViewRepresentable(facemaskDelegate: FaceMaskDelegate())
    }
}

