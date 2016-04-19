//
//  PBSeason.swift
//  Playback
//
//  Created by Nick Babenko on 12/09/2014.
//  Copyright (c) 2014 Playback. All rights reserved.
//

import Foundation
import CoreData

class PBSeason: NSManagedObject {

    @NSManaged var number: NSNumber
    @NSManaged var year: NSNumber
    @NSManaged var episodes: NSSet
    @NSManaged var show: NSManagedObject

}
