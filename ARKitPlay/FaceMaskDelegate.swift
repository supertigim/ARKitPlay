//
//  FaceMaskDelegate.swift
//  ARKitPlay
//
//  Created by Jong Yoon Kim on 2022/02/08.
//

import Foundation
import ARKit
import UIKit
import SceneKit


class FaceMaskDelegate: NSObject, ARSCNViewDelegate, ObservableObject {
    private var arView: ARSCNView?
    
    func setARView(_ arView: ARSCNView) {
        self.arView = arView
        
        // Face Tracking Configuration
        guard ARFaceTrackingConfiguration.isSupported else { return }
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        
        arView.session.run(configuration)
        arView.delegate = self
        arView.scene = SCNScene()
    }
 
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {

        // to avoid the error -> Value of optional type 'ARSCNView?' must be unwrapped to refer to member 'device' of wrapped base type 'ARSCNView'
        // use self.arView? instead of self.arView
        guard let device = self.arView?.device else {
            return nil
        }

        let faceGeometry = ARSCNFaceGeometry(device: device)
        let node = SCNNode(geometry: faceGeometry)

        node.geometry?.firstMaterial?.fillMode = .lines // to represent mask as lines
        return node
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
        guard let faceAnchor = anchor as? ARFaceAnchor,
            let faceGeometry = node.geometry as? ARSCNFaceGeometry else {
                return
        }
        faceGeometry.update(from: faceAnchor.geometry)
    }
}
