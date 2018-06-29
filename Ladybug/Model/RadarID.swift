//
//  Radar.swift
//  Ladybug
//
//  Created by Ethanhuang on 2018/6/12.
//  Copyright © 2018年 Elaborapp Co., Ltd. All rights reserved.
//

import Foundation

public struct RadarID: Codable {
    let id: Int

    init(_ int: Int) {
        self.id = int
    }
}

extension RadarID: Hashable {
    public var hashValue: Int { return id }
}

public func == (lhs: RadarID, rhs: RadarID) -> Bool {
    return lhs.id == rhs.id
}

extension RadarID {
    init?(string: String) {
        if let int = Int(string),
            String(int) == string {
            self.id = int
        } else {
            return nil
        }
    }

    init?(url: URL) {
        if let radarID = OpenRadar.parse(url) {
            self = radarID
        } else if let radarID = AppleRadar.parse(url) {
            self = radarID
        } else if let radarID = BriskRadar.parse(url) {
            self = radarID
        } else {
            return nil
        }
    }

    func url(by radarOption: RadarOption) -> URL {
        switch radarOption {
        case .appleRadar:
            return AppleRadar.buildURL(from: self)
        case .openRadar:
            return OpenRadar.buildURL(from: self)
        case .brisk:
            return BriskRadar.buildURL(from: self)
        }
    }
}

extension RadarID {
    var idString: String {
        return String(self.id)
    }
}
