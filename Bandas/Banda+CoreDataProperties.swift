//
//  Banda+CoreDataProperties.swift
//  Bandas
//
//  Created by Gaspar on 03/10/16.
//  Copyright © 2016 Gaspar Teixeira. All rights reserved.
//

import Foundation
import CoreData


extension Banda {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Banda> {
        return NSFetchRequest<Banda>(entityName: "Banda");
    }

    @NSManaged public var nome: String?
    @NSManaged public var estilo: String?
    @NSManaged public var pais: String?
    @NSManaged public var ano: Int16

}
