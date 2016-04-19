//
//  PBSetting.swift
//  Playback
//
//  Created by Nick Babenko on 12/09/2014.
//  Copyright (c) 2014 Playback. All rights reserved.
//

import Foundation
import CoreData

class PBSetting: NSManagedObject {

    @NSManaged var key: String
    @NSManaged var value: String

}
