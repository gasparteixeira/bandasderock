//
//  Banda+CoreDataClass.swift
//  Bandas
//
//  Created by Gaspar on 03/10/16.
//  Copyright © 2016 Gaspar Teixeira. All rights reserved.
//

import Foundation
import CoreData


public class Banda: NSManagedObject {

    class func createWith(nome: String, estilo: String?, pais: String?, ano: Int16?, in context: NSManagedObjectContext) -> Banda? {
        print("\(nome)")
        let request = NSFetchRequest<Banda>(entityName: "Banda")
        let query = "nome == %@"
        let params = [ nome ]
        
        request.predicate = NSPredicate(format: query, argumentArray: params)
        
        // tenta recuperar a banda
        if let banda = (try? context.fetch(request))?.first {
            return banda
        }
        // senao cria a banda
        if let banda = NSEntityDescription.insertNewObject(forEntityName: "Banda", into: context) as? Banda {
            banda.nome = nome
            banda.estilo = estilo
            banda.pais = pais
            banda.ano = ano ?? 0
            return banda
        }
        // em caso de erro...
        return nil
    }
}
