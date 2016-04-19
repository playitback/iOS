//
//  PBPoster.swift
//  Playback
//
//  Created by Nick Babenko on 12/09/2014.
//  Copyright (c) 2014 Playback. All rights reserved.
//

import Foundation
import CoreData

class PBPoster: NSManagedObject {

    @NSManaged var url: String
    @NSManaged var episode: NSManagedObject
    @NSManaged var movie: NSManagedObject

}
