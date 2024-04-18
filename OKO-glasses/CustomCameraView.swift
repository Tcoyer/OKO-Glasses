//
//  CustomCameraView.swift
//  OKO-glasses
//
//  Created by Ali Musawa on 22/03/24.
//

import SwiftUI
import AVFoundation
import GoogleGenerativeAI

let synthesizer = AVSpeechSynthesizer()


struct CustomCameraView: View {
    let cameraService = CameraSevice()
    @Binding var capturedImage: UIImage?
       
    @Environment(\.presentationMode) private var presentationMode
    @State private var isWaiting: Bool = false

       var body: some View {
           ZStack {
               CameraView(cameraService: cameraService) { result in
                   switch result {
                   case .success(let photo):
                       
                       if let data = photo.fileDataRepresentation() {
                           isWaiting = true
                           Task {
                                           do {
                                               await gemini(pic: UIImage(data: data)!)
                                               capturedImage = UIImage(data: data)
                                               presentationMode.wrappedValue.dismiss()
                                           } catch {
                                               print("Error: \(error)")
                                           }
                                           isWaiting = false // Dismiss waiting alert
                                       }
                           capturedImage = UIImage(data: data)
                           presentationMode.wrappedValue.dismiss()
                       } else {
                           print("Error: no image data found")
                       }
                   case .failure(let err):
                       print(err.localizedDescription)
                   }
               }
               
               VStack {
                   Spacer()
                   Button(action: {
                       cameraService.capturePhoto()
//                       let utterance = AVSpeechUtterance(string: "Please say your command")
//                       utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
////                       utterance.rate = 0.3
//                       synthesizer.speak(utterance)
                       
                       
                       
                   }, label: {
                       Image(systemName: "circle")
                           .font(.system(size: 72))
                           .foregroundColor(.white)
                   })
                   .padding(.bottom)
               }
           }.alert(isPresented: $isWaiting) {
               Alert(title: Text("Processing"), message: Text("Please wait while the image is being processed"), dismissButton: .none)
           }

       }
    
    private func gemini(pic: UIImage) async {
        let model = GenerativeModel(name: "gemini-pro-vision", apiKey: "AIzaSyCh-MsEjfOV4sKEl9u58YT9pt5WR18zaY4")
        
        let image = pic
        
        let prompt = "Explain to me what you saw"
        
        do {
                let response = try await model.generateContent(prompt, image)
                
                if let text = response.text {
                    print(text)
                    
                    let utterance = AVSpeechUtterance(string: text)
                    utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
//                       utterance.rate = 0.3
                    synthesizer.speak(utterance)
                }
            }
        catch {
                print("Error: \(error)")
            }


    }
}

//#Preview {
//    CustomCameraView()
//}
