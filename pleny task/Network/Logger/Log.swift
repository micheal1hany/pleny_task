//
//  Logger.swift

//
//  Created by Micheal Hany on 12/09/2024.
//

import Foundation
internal import OSLog

class Log{
    
    private static let logger = Logger(subsystem: "com.dsquares.mobilawySDK", category: "SDK")
    
    private init(){}
    
    static func i(_ message:Any..., file: String = #file, function: String = #function, line: Int = #line){
#if DEBUG
        if isInternalTest(){
            logger.info("""
            \(downLine())
            \(INFO())
            [📂 File: \(file.split(separator: "/").last ?? "")]
            [ℹ️ Function Name: \(function)]
            [🔢 Line Number: \(line)]
            \(message)
            \(upLine())
            """)
        }
#endif
    }
    
    static func d(_ message:Any..., file: String = #file, function: String = #function, line: Int = #line ){
#if DEBUG
        if isInternalTest(){
            logger.warning("""
            \(downLine())
            \(DEBUG())
            [📂 File: \(file.split(separator: "/").last ?? "")]
            [ℹ️ Function Name: \(function)]
            [🔢 Line Number: \(line)]
            \(message)
            \(upLine())
            """)
        }
#endif
    }
    
    static func e(_ message:Any..., file: String = #file, function: String = #function, line: Int = #line ){
#if DEBUG
        if isInternalTest(){
            logger.critical("""
            \(downLine())
            \(ERROR())
            [📂 File: \(file.split(separator: "/").last ?? "")]
            [ℹ️ Function Name: \(function)]
            [🔢 Line Number: \(line)]
            \(message)
            \(upLine())
            """)
        }
#endif
    }
    
    static func logAPI(
        HTTPMethod:String?,
        baseURL:String?,
        endpoint:String?,
        statuesCode:Int,
        headers:String?,
        params:[String:Any]?,
        requestTime:TimeInterval?,
        res:String?,
        error:Error?
    ){
#if DEBUG
        if isInternalTest(){
            if error == nil && statuesCode == 200{
                
                logger.debug("""
                \(downLine())
                \(APISUCCESS())
                [🔗 BASE URL: \(baseURL ?? "-")]
                [🔗 Endpoint: \(endpoint ?? "-")]
                [⚡️ Status Code: \(statuesCode)]
                [📎 Headers: \(headers ?? "-")]
                [🗂️ Params: \(params ?? [:])]
                [⏳ Time: \(requestTime ?? 0)]
                [📦 Response: ->>
                \(drawLine())
                \(res ?? "-")
                \(drawLine())
                \(upLine())
                """)
            }else{
                guard let er = error as? APIError else {
                    logger.critical("""
                    \(downLine())
                    \(APIERROR())
                    [🔗 BASE URL: \(baseURL ?? "-")]
                    [🔗 Endpoint: \(endpoint ?? "-")]
                    [⚡️ Status Code: \(statuesCode)]
                    [📎 Headers: \(headers ?? "-")]
                    [🗂️ Params: \(params ?? [:])]
                    [⏳ Time: \(requestTime ?? 0)]
                    [💥 Error: \(error?.localizedDescription ?? "-")]
                    [📦 Response: ->>
                    \(drawLine())
                    \(res ?? "-")
                    \(drawLine())
                    \(upLine())
                    """)
                    return
                }
                
                logger.critical("""
                \(downLine())
                \(APIERROR())
                [🔗 BASE URL: \(baseURL ?? "-")]
                [🔗 Endpoint: \(endpoint ?? "-")]
                [⚡️ Status Code: \(statuesCode)]
                [📎 Headers: \(headers ?? "-")]
                [🗂️ Params: \(params ?? [:])]
                [⏳ Time: \(requestTime ?? 0)]
                [💥 Error: \(er.error.errorDescription)]
                [📦 Response: ->>
                \(drawLine())
                \(res ?? "-")
                \(drawLine())
                \(upLine())
                """)
            }
        }
#endif
    }
    
    private static func drawLine() -> String{
        return "--------------------------------------------------------------------------------"
    }
    
    private static func downLine() -> String{
        return "↘️================================================================================↙️"
    }
    
    private static func upLine() -> String{
        return "↗️================================================================================↖️"
    }
    
    private static func getTime() -> String{
        return "⏱️ \(String.getCurrentDateTimeFormattedForLogger())"
    }
    
    
    
    private static func INFO()->String{
        return """
🟦 INFO
\(getTime())
--------------------
"""
    }
    
    
    private static func DEBUG()->String{
        return """
🐛 DEBUG
\(getTime())
--------------------
"""
    }
    
    private static func ERROR()->String{
        return """
💥 ERROR
\(getTime())
--------------------
"""
    }
    
    private static func APISUCCESS()->String{
        return """
🟩 API SUCCESS
\(getTime())
--------------------
"""
    }
    
    private static func APIERROR()->String{
        return """
🟥 API ERROR
\(getTime())
--------------------
"""
    }
}

func print(_ items: Any..., separator: String = " ", terminator: String = "\n"){
#if DEBUG
    // Check if the bundle matches your framework's bundle identifier
    if isInternalTest(){
        Swift.print(items, separator: separator, terminator: terminator)
    }
#else
    return
#endif
}

func isInternalTest()->Bool{
    return Bundle.main.bundleIdentifier?.contains("com.micheal") == true
}


private extension String{
    
    static func getCurrentDateTimeFormattedForLogger()->String{
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm:ss a zz"
        
        return dateFormatter.string(from: Date())
    }
}
