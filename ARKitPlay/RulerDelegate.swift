//
//  RulerDelegate.swift
//  ARKitPlay
//
//  Created by Jong Yoon Kim on 2022/02/09.
//

import Foundation
import ARKit
import UIKit

class RulerDelegate: NSObject, ARSCNViewDelegate, ObservableObject {
    @Published var message:String = "starting AR Ruelr"
    
    func setARView(_ arView: ARSCNView) {
        self.arView = arView
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        arView.session.run(configuration)//, options: [.resetTracking, .removeExistingAnchors])
        
        arView.delegate = self
        arView.scene = SCNScene()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnARView))
        arView.addGestureRecognizer(tapGesture)

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panOnARView))
        arView.addGestureRecognizer(panGesture)
    }
    
    @objc func panOnARView(sender: UIPanGestureRecognizer) {
        guard let arView = arView else { return }
        let location = sender.location(in: arView)
        switch sender.state {
        case .began:
            if let node = nodeAtLocation(location) {
                trackedNode = node
            }
        case .changed:
            if let node = trackedNode {
                if let result = raycastResult(fromLocation: location) {
                    moveNode(node, raycastResult:result)
                }
            }
        default:
            ()
        }
    }
    
    @objc func tapOnARView(sender: UITapGestureRecognizer) {
        guard let arView = arView else { return }
        let location = sender.location(in: arView)
        if let node = nodeAtLocation(location) {
            removeCircle(node: node)
        }
        else if let result = raycastResult(fromLocation: location) {
            addCircle(raycastResult: result)
        }
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        print("Camera has changed \(camera.trackingState)")
        switch camera.trackingState {
        case .limited(_):
            message = "Tracking limited"
        case .normal:
            message =  "Ready"
        case .notAvailable:
            message = "Not Available"
        }
    }
    
    private var arView: ARSCNView?
    private var circles:[SCNNode] = []
    private var trackedNode:SCNNode?
    
    private func addCircle(raycastResult: ARRaycastResult) {
        let circleNode = GeometryUtils.createCircle(fromRaycastResult: raycastResult)
        if circles.count >= 2 {
            for circle in circles {
                circle.removeFromParentNode()
            }
            circles.removeAll()
        }
        
        arView?.scene.rootNode.addChildNode(circleNode)
        circles.append(circleNode)
        
        nodesUpdated()
    }
    
    private func moveNode(_ node:SCNNode, raycastResult:ARRaycastResult) {
        node.simdWorldTransform = raycastResult.worldTransform
        nodesUpdated()
    }
    
    private func nodeAtLocation(_ location:CGPoint) -> SCNNode? {
        guard let arView = arView else { return nil }
        let result = arView.hitTest(location, options: nil)
        return result.first?.node
    }
    
    private func nodesUpdated() {
        if circles.count == 2 {
            let distance = GeometryUtils.calculateDistance(firstNode: circles[0], secondNode: circles[1])
            print("Distance = \(distance)")
            message = "Distance " + String(format: "%.2f cm", distance)
        }
        else {
            message = "Add second point"
        }
    }
    
    private func raycastResult(fromLocation location: CGPoint) -> ARRaycastResult? {
        guard let arView = arView,
              let query = arView.raycastQuery(from: location,
                                        allowing: .existingPlaneGeometry,
                                        alignment: .horizontal) else { return nil }
        let results = arView.session.raycast(query)
        return results.first
    }
    
    func removeCircle(node:SCNNode) {
        node.removeFromParentNode()
        circles.removeAll(where: { $0 == node })
    }
}
