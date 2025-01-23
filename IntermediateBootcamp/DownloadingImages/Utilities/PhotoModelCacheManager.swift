//
//  PhotoModelCacheManager.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2025-01-23.
//

import Foundation
import SwiftUI

class PhotoModelCacheManager {
    static let shared = PhotoModelCacheManager()
    
    private init() {}
    
    var photoCache: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit = 1024 * 1024 * 200 // 200mb
        return cache
    }()
    
    func add(key: String, value: UIImage) {
        photoCache.setObject(value, forKey: key as NSString)
    }
    
    func get(key: String) -> UIImage? {
        photoCache.object(forKey: key as NSString)
    }
}
