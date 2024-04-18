//
//  ObstDetectionView.swift
//  OKO-glasses
//
//  Created by Ali Haidar on 17/04/24.
//

import SwiftUI
import RealityKit
import ARKit

struct ObstDetectionView: View {
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    @State private var distance: Float = 0.0
    @State private var showDialog = false
    @State private var lastDistance: Float = 0.0
    
    var body: some View {
        ZStack{
            ARViewContainer(distance: $distance)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                Text("Distance: \(String(format: "%.2f", distance)) meters")
                    .foregroundStyle(.white)
                    .font(.headline)
                    .padding(.bottom)
                Text("Last Distance: \(String(format: "%.2f", lastDistance)) meters")
                    .foregroundStyle(.white)
                    .font(.headline)
                    .padding(.bottom)
                Spacer()
            }
            
            if showDialog{
                
                VStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .resizable()
                        .foregroundStyle(.white)
                        .frame(width: 100, height: 100)
                    .padding()
                    
                    Text("Obstacle detected")
                        .foregroundStyle(.white)
                        .bold()
                }
                .padding(50)
                .background(Circle().foregroundStyle(.red))
            }
            
        }
        .onReceive(timer, perform: { _ in
            lastDistance = distance
//            let threshold: Float = 0.5 // adjust this value to your desired threshold
//                if abs(lastDistance - distance) > threshold || abs(distance - lastDistance ) < threshold{
//                    withAnimation {
//                        showDialog.toggle()
//                    }
//                }
        })
    }
}


#Preview {
    ObstDetectionView()
}
//

struct ARViewContainer: UIViewRepresentable{
    @Binding var distance: Float
    
    func makeUIView(context: Context) -> some UIView {
        let arView = ARView(frame: .zero)
        let config = ARWorldTrackingConfiguration()
        config.environmentTexturing = .automatic
        
        arView.session.delegate = context.coordinator
        arView.session.run(config)
        
        return arView
        
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> ARSessionCoordinator {
        return ARSessionCoordinator(distance: $distance)
    }
}


class ARSessionCoordinator : NSObject, ARSessionDelegate{
    @Binding var distance: Float
    
    init(distance: Binding<Float>) {
        _distance = distance
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        guard let currentPointCloud = frame.rawFeaturePoints else {return}
        let cameraTransform = frame.camera.transform
        
        var furthestDistance : Float = 0.0
        
        for point in currentPointCloud.points{
            let pointInCameraSpace = cameraTransform.inverse*simd_float4(point,1)
            let distanceToCamera = sqrt(pointInCameraSpace.x*pointInCameraSpace.x+pointInCameraSpace.y*pointInCameraSpace.y+pointInCameraSpace.z*pointInCameraSpace.z)
            
            if distanceToCamera > furthestDistance{
                furthestDistance = distanceToCamera
            }
        }
        
        distance = furthestDistance
    }
}
