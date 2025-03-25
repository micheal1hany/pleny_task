//
//  String+Extension.swift
//  swiftui_movies_example
//
//  Created by Micheal Hany on 07/11/2023.
//

import Foundation

extension String{
    
    
    
    /// Compare numeric versions
    /// - Parameters:
    ///     - otherVersion: can be a remote version to check if app is updated or not
    /// - Returns: ComparisonResult ex. (.orderedDescending,.orderedAscending)
    ///
    ///Example: "0.2".versionCompare("0.1") -> .orderedDescending
    ///"1.0.0".versionCompare("1.1") -> .orderedAscending
    func versionCompare(_ otherVersion: String) -> ComparisonResult {
        let versionDelimiter = "."

        var versionComponents = self.components(separatedBy: versionDelimiter) // <1>
        var otherVersionComponents = otherVersion.components(separatedBy: versionDelimiter)

        let zeroDiff = versionComponents.count - otherVersionComponents.count // <2>

        if zeroDiff == 0 { // <3>
            // Same format, compare normally
            return self.compare(otherVersion, options: .numeric)
        } else {
            let zeros = Array(repeating: "0", count: abs(zeroDiff)) // <4>
            if zeroDiff > 0 {
                otherVersionComponents.append(contentsOf: zeros) // <5>
            } else {
                versionComponents.append(contentsOf: zeros)
            }
            return versionComponents.joined(separator: versionDelimiter)
                .compare(otherVersionComponents.joined(separator: versionDelimiter), options: .numeric) // <6>
        }
    }
    
    func replaceAPIError()->String{
        let urlSessionString = "URLSessionTask failed with error: "
        return self.replacingOccurrences(of: urlSessionString , with: "")
    }
    
    func formatDateTimeWithSlashes() -> String? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
            
            if let date = dateFormatter.date(from: self) {
                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = Language.isRTL ? "yyyy/MM/dd - h:mm a" : "dd/MM/yyyy - h:mm a"
                outputFormatter.locale = Locale(identifier: Language.currentLanguage.rawValue)
                return outputFormatter.string(from: date)
            }
            
            return nil
        }
    
    func toUrl()->URL?{
        return URL(string: self)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    func decodeJWT() -> [String: Any]? {
        // Split the JWT into header, payload, and signature
        let parts = self.components(separatedBy: ".")
        
        // Check if there are three parts as expected
        guard parts.count == 3,
              let payloadData = parts[1].base64UrlDecodedData() else {
            return nil
        }
        
        do {
            // Deserialize the JSON payload
            let jsonObject = try JSONSerialization.jsonObject(with: payloadData, options: [])
            guard let dictionary = jsonObject as? [String: Any] else {
                return nil
            }
            return dictionary
        } catch {
            Log.e("->> JWT decoding error: \(error)")
            return nil
        }
    }
    
    private func base64UrlDecodedData() -> Data? {
        var base64 = self
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        
        // Add padding if needed
        let padding = base64.count % 4
        if padding > 0 {
            base64 += String(repeating: "=", count: 4 - padding)
        }
        
        return Data(base64Encoded: base64)
    }
    
    func localizedNumber()->String?{
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: Language.currentLanguage.rawValue)
        if let num = formatter.number(from: self){
            return formatter.string(from: num)
        }else{
            return self
        }
    }
    
    
}
