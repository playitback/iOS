//
//  PBShow.swift
//  Playback
//
//  Created by Nick Babenko on 12/09/2014.
//  Copyright (c) 2014 Playback. All rights reserved.
//

import Foundation
import CoreData

class PBShow: PBSyncableModel {

    @NSManaged var firstAired: NSDate
    @NSManaged var remoteId: String
    @NSManaged var title: String
    @NSManaged var seasons: NSSet

}
