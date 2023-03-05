//
//  TestContentView.swift
//  Instafilter
//
//  Created by Paulina Dąbrowska on 01/02/2023.
//


import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct TestContentView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    
    @State private var inputImage: UIImage?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button("Select Image") {
                showingImagePicker = true
            }
            
            Button("Save Image") {
                guard let inputImage = inputImage else { return }

                let imageSaver = ImageSaver()
                imageSaver.writeToPhotoAlbum(image: inputImage)
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage) { _ in loadImage() }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        
        // saving the chosen image to user's photo library
        //UIImageWriteToSavedPhotosAlbum(inputImage, nil, nil, nil)
    }
}

struct TestContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  OTHER VIEWS
//

struct FilterTutorialView : View {
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        // load the image into CIImage so it can be eited by filters
        guard let inputImage = UIImage(named: "Example") else { return }
        let beginImage = CIImage(image: inputImage)
        
        // initialize the filter
        let context = CIContext()
        //let currentFilter = CIFilter.sepiaTone()
        //currentFilter.inputImage = beginImage
        //currentFilter.intensity = 1
        
        let currentFilter = CIFilter.twirlDistortion()
        currentFilter.inputImage = beginImage

        let amount = 1.0

        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey) }
        
        
        
        // get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter.outputImage else { return }
        
        // attempt to get a CGImage from our CIImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            // convert that to a UIImage
            let uiImage = UIImage(cgImage: cgimg)
            
            // and convert that to a SwiftUI image
            image = Image(uiImage: uiImage)
        }
    }
}
