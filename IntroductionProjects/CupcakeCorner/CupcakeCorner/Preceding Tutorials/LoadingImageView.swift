//
//  LoadingImageView.swift
//  CupcakeCorner
//
//  Created by Paulina Dąbrowska on 25/01/2023.
//

import SwiftUI

struct LoadingImageView: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 3)
        // scale scales down the image, we need this parameter as, when Swift downloads image from the internet, it doesn't know its size
        
        //
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            // if the image is not available or loading, use the loading icon
            ProgressView()
        }
        .frame(width: 200, height: 200)
        
        
        AsyncImage(url: URL(string: "https://hws.dev/img/bad.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                // if the image is not available, display error message
                Text("There was an error loading the image.")
            } else {
                // if the image is loading, diaplay a loading icon
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
    }
}

struct LoadingImageView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingImageView()
    }
}
