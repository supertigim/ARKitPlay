//
//  RulerView.swift
//  ARKitPlay
//
//  Created by Jong Yoon Kim on 2022/02/09.
//

import SwiftUI

struct RulerView: View {
    @ObservedObject var rulerDelegate = RulerDelegate()
    
    var body: some View {
        ZStack {
            RulerViewRepresentable(rulerDelegate: rulerDelegate)
            VStack {
                Spacer()
                Text(rulerDelegate.message)
                    .foregroundColor(Color.primary)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 20)
                    .background(Color.secondary)
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct RulerView_Previews: PreviewProvider {
    static var previews: some View {
        RulerView()
    }
}
