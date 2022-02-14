//
//  FaceDetectionDelegate.swift
//  ARKitPlay
//
//  Created by Jong Yoon Kim on 2022/02/11.
//

import AVKit
import Vision

class FaceDetectionDelegate: NSObject, ObservableObject {
    
    private let camera: Camera
    let session: AVCaptureSession

    @Published var isFlashOn = false
    @Published var isSilentModeOn = false
    @Published var message:String = "Start Face Detector (Counter)"
    
    override init() {
        camera = Camera()
        session = camera.session
    }
    
    func configure() {
        camera.requestAndCheckPermissions()
        enableFaceDetection()
        message = "Ready"
    }
    
    func disappear(){
        camera.session.stopRunning()
    }
    
    func enableFaceDetection(){
        let dataOutput = AVCaptureVideoDataOutput()
        if camera.session.canAddOutput(dataOutput) {
            dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
            camera.session.addOutput(dataOutput)
        }
    }
    
//    func switchFlash() {
//        isFlashOn.toggle()
//    }
//
//    func switchSilent() {
//        isSilentModeOn.toggle()
//    }
//
//    func capturePhoto() {
//        print("[CameraViewModel]: Photo captured!")
//    }
//
//    func changeCamera() {
//        print("[CameraViewModel]: Camera changed!")
//    }
    
}

extension FaceDetectionDelegate: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {

        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }

        let request = VNDetectFaceRectanglesRequest { (req, err) in

            if let err = err {
                print("Failed to detect faces:", err)
                return
            }

            DispatchQueue.main.async {
                if let results = req.results {
                    self.message = "\(results.count) face(s)"
                }
            }

        }

        DispatchQueue.global(qos: .userInteractive).async {
            let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
            do {
                try handler.perform([request])
            } catch let reqErr {
                print("Failed to perform request:", reqErr)
            }
        }
    }
}

