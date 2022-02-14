//
//  FaceMaskView.swift
//  ARKitPlay
//
//  Created by Jong Yoon Kim on 2022/02/08.
//

import SwiftUI

struct FaceMaskView: View {
    @ObservedObject var facemaskDelegate = FaceMaskDelegate()
    
    var body: some View {
        ZStack {
            FaceMaskViewRepresentable(facemaskDelegate: facemaskDelegate)
                .onAppear{
                    facemaskDelegate.configure()
                }
                .onDisappear{
                    facemaskDelegate.disappear()
                }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct FaceMaskView_Previews: PreviewProvider {
    static var previews: some View {
        FaceMaskView()
    }
}
