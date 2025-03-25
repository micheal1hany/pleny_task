//
//  UIImageQRGenerator.swift

//
//  Created by Micheal Hany on 13/03/2024.
//

import UIKit
import CoreImage.CIFilterBuiltins

class UIImageQRGenerator{
    
    private init(){}

    class func generateQRCode(from string: String) -> UIImage {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}
