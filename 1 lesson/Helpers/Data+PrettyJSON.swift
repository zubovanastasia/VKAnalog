//
//  Data+PrettyJSON.swift
//  1 lesson
//
//  Created by Anastasiia Zubova on 24.10.2021.
//

import Foundation
import UIKit

extension Data {

     var prettyJSON: NSString? { /// NSString gives us a nice sanitized debugDescription
         guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
               let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
               let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

         return prettyPrintedString
     }
 }
