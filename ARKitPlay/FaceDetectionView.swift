//
//  FaceDetectionView.swift
//  ARKitPlay
//
//  Created by Jong Yoon Kim on 2022/02/11.
//

import SwiftUI

struct FaceDetectionView: View {
    @ObservedObject var facedetectionDelegate = FaceDetectionDelegate()

    var body: some View {
        ZStack {
            FaceDetectionViewRepresentable(facedetectionDelegate: facedetectionDelegate)
                .onAppear{
                    facedetectionDelegate.configure()
                }
                .onDisappear{
                    facedetectionDelegate.disappear()
            }
            VStack {
                Spacer()
                Text(facedetectionDelegate.message)
                    .foregroundColor(Color.primary)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 20)
                    .background(Color.secondary)
            }
        }.edgesIgnoringSafeArea(.all)
    }
}


struct FaceDetectionView_Previews: PreviewProvider {
    static var previews: some View {
        FaceDetectionView()
    }
}
