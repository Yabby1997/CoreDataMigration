//
//  CoreDataMigrationPolicyV1ToV2.swift
//  CoreDataMigration
//
//  Created by Seunghun on 6/1/24.
//

import CoreData

@objc(CoreDataMigrationPolicyV1ToV2)
class CoreDataMigrationPolicyV1ToV2: NSEntityMigrationPolicy {
    override func createDestinationInstances(
        forSource sInstance: NSManagedObject,
        in mapping: NSEntityMapping,
        manager: NSMigrationManager
    ) throws {
        let sourceKeys = sInstance.entity.attributesByName.keys
        let sourceValues = sInstance.dictionaryWithValues(forKeys: sourceKeys.map { $0 as String })
        print("[DEBUG] SourceInstance: \(sInstance.entity.name), keys: \(sourceKeys)")

        let destinationInstance = NSEntityDescription.insertNewObject(
            forEntityName: mapping.destinationEntityName!,
            into: manager.destinationContext
        )
        let destinationKeys = destinationInstance.entity.attributesByName.keys.map { $0 as String }
        print("[DEBUG] DestinationInstance: \(mapping.destinationEntityName!), keys: \(destinationKeys)")

        for key in destinationKeys {
            if let value = sourceValues[key] {
                destinationInstance.setValue(value, forKey: key)
                print("[DEBUG] key \(key) set with value of \(value)")
            }
        }
        
        destinationInstance.setValue("MEMO " + UUID().uuidString, forKey: "memo")
        
        manager.associate(sourceInstance: sInstance, withDestinationInstance: destinationInstance, for: mapping)
    }
}
