//
//  UBAsyncImage.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 1/2/23.
//

import SwiftUI

struct UBAsyncImageView: View {
    @State var asyncImage: String? = nil
    
    var body: some View {
        if let imageURL = asyncImage {
            AsyncImage(url: URL(string: imageURL)) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(width: UBConstants.itemIconSize, height: UBConstants.itemIconSize,  alignment: .center)
            } placeholder: {
                ProgressView()
            }
        }
        else {
            Image("notAvailable")
                .resizable()
                .scaledToFit()
                .frame(width: UBConstants.itemIconSize, height: UBConstants.itemIconSize,  alignment: .center)
        }
    }
}


struct UBAsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        UBAsyncImageView(asyncImage: "https://cdn.pixabay.com/photo/2015/03/17/02/01/cubes-677092__480.png")
        UBAsyncImageView(asyncImage: nil)
    }
}
