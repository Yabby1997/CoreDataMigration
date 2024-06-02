//
//  CoreDataMigrationPolicyV2ToV3.swift
//  CoreDataMigration
//
//  Created by Seunghun on 6/2/24.
//

import CoreData

@objc(CoreDataMigrationPolicyV2ToV3)
class CoreDataMigrationPolicyV2ToV3: NSEntityMigrationPolicy {
    override func createDestinationInstances(
        forSource sInstance: NSManagedObject,
        in mapping: NSEntityMapping,
        manager: NSMigrationManager
    ) throws {
        let memoInstance = NSEntityDescription.insertNewObject(
            forEntityName: "Memo",
            into: manager.destinationContext
        )
        memoInstance.setValue(sInstance.value(forKey: "memo") as! String, forKey: "memo")
        print("[DEBUG] New Memo instance created")

        let destinationInstance = NSEntityDescription.insertNewObject(
            forEntityName: mapping.destinationEntityName!,
            into: manager.destinationContext
        )
        destinationInstance.setValue(sInstance.value(forKey: "timestamp") as! Date, forKey: "timestamp")
        destinationInstance.setValue(memoInstance, forKey: "memo")
        print("[DEBUG] New Item instance created")
        
        manager.associate(sourceInstance: sInstance, withDestinationInstance: destinationInstance, for: mapping)
    }
}
