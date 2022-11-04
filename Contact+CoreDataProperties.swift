//
//  Contact+CoreDataProperties.swift
//  Notizy
//
//  Created by Mirko Weitkowitz on 04.11.22.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var adress: String?
    @NSManaged public var email: String?
    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var notes: String?

}

extension Contact : Identifiable {

}
