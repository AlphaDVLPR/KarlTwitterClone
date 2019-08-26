//
//  Hype.swift
//  KarlTwitterClone
//
//  Created by AlphaDVLPR on 8/26/19.
//  Copyright © 2019 AlphaDVLPR. All rights reserved.
//

import Foundation
import CloudKit

struct constants {
    
    static let recordTypeKey = "Hype"
    static let recodeTextKey = "Text"
    static let recordTimeStampKey = "Timestamp"
}
class Hype {
    
    let hypeText: String
    let timeStamp: Date
    
    init(hypeText: String, timeStamp: Date = Date()) {
        
        self.hypeText = hypeText
        self.timeStamp = timeStamp
    }
    
}

extension CKRecord {
    
    //Create a CK record from a hype
    convenience init(hype: Hype) {
        self.init(recordType: constants.recordTypeKey)
        self.setValue(hype.hypeText, forKeyPath: constants.recodeTextKey)
        self.setValue(hype.timeStamp, forKeyPath: constants.recordTimeStampKey)
    }
}

extension Hype {
    //Creating a hype from a record. Which is like the same thing as loading
    //We dont know what the network is going to be so we make this failable
    convenience init?(ckRecord: CKRecord) {
        guard let hypeText = ckRecord[constants.recodeTextKey] as? String,
            let timestamp = ckRecord[constants.recordTimeStampKey] as? Date else {return nil}
        self.init(hypeText: hypeText, timestamp: timestamp)
    }
}
