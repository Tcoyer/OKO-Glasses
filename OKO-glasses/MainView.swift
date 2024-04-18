//
//  MainView.swift
//  OKO-glasses
//
//  Created by Ali Musawa on 22/03/24.
//

import SwiftUI

struct MainView: View {
    
    @State private var capturedImage: UIImage? = nil
    @State private var isCustomCameraViewPresented = false
    
    var body: some View {
        CustomCameraView(capturedImage: $capturedImage)
//           ZStack {
//               if capturedImage != nil {
//                   Image(uiImage: capturedImage!)
//                       .resizable()
//                       .scaledToFill()
//                       .ignoresSafeArea()
//               } else {
//                   Color(UIColor.systemBackground)
//               }
//               
//               VStack {
//                   Spacer()
//                   Button(action: {
//                       isCustomCameraViewPresented.toggle()
//                   }, label: {
//                       Image(systemName: "camera.fill")
//                           .font(.largeTitle)
//                           .padding()
//                           .background(Color.black)
//                           .foregroundColor(.white)
//                           .clipShape(Circle())
//                   })
//                   .padding(.bottom)
//                   .sheet(isPresented: $isCustomCameraViewPresented, content: {
//                       CustomCameraView(capturedImage: $capturedImage)
//                   })
//               }
//           }
       }
}

#Preview {
    MainView()
}
