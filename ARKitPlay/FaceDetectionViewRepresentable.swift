//
//  FaceDetectionViewRepresentable.swift
//  ARKitPlay
//
//  Created by Jong Yoon Kim on 2022/02/11.
//

import SwiftUI
import AVFoundation

struct FaceDetectionViewRepresentable: UIViewRepresentable {
    class VideoPreviewView: UIView {
        override class var layerClass: AnyClass {
             AVCaptureVideoPreviewLayer.self
        }
        
        var videoPreviewLayer: AVCaptureVideoPreviewLayer {
            return layer as! AVCaptureVideoPreviewLayer
        }
    }
    
    let facedetectionDelegate: FaceDetectionDelegate
    
    func makeUIView(context: Context) -> VideoPreviewView {
        let view = VideoPreviewView()
        
        view.backgroundColor = .black
        view.videoPreviewLayer.videoGravity = .resizeAspectFill
        view.videoPreviewLayer.cornerRadius = 0
        view.videoPreviewLayer.session = facedetectionDelegate.session
        view.videoPreviewLayer.connection?.videoOrientation = .portrait

        return view
    }
    
    func updateUIView(_ uiView: VideoPreviewView, context: Context) {
        
    }
}


//struct FaceDetectionViewRepresentable: PreviewProvider {
//    static var previews: some View {
//        FaceDetectionViewRepresentable(facemaskDelegate: FaceMaskDelegate())
//    }
//}
