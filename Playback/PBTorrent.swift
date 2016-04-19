//
//  PBTorrent.swift
//  Playback
//
//  Created by Nick Babenko on 12/09/2014.
//  Copyright (c) 2014 Playback. All rights reserved.
//

import Foundation
import CoreData

class PBTorrent: NSManagedObject {

    @NSManaged var magnet: String
    @NSManaged var score: NSNumber
    @NSManaged var media: NSManagedObject

}
