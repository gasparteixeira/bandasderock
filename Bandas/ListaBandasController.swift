//
//  ListaBandasController.swift
//  Bandas
//
//  Created by Gaspar on 03/10/16.
//  Copyright © 2016 Gaspar Teixeira. All rights reserved.
//

import UIKit
import CoreData

class ListaBandasController: CoreDataTableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        requestFetchedResultsController()

    }

    // MARK: - CoreDataTableViewController FetchedResultsController setup
    
    private func requestFetchedResultsController() {
        let request = NSFetchRequest<NSManagedObject>(entityName: "Banda")
        request.sortDescriptors = [ NSSortDescriptor(key: "nome", ascending: true) ]
        
        if let context = managedObjectContext {
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                                  managedObjectContext: context,
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: nil)
        } else {
            fetchedResultsController = nil
        }
    }
    
     // MARK: - UITableView data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let banda = fetchedResultsController?.object(at: indexPath) as? Banda {
            cell.textLabel?.text = banda.nome
            cell.detailTextLabel?.text = banda.estilo
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if let banda = fetchedResultsController?.object(at: indexPath) as? Banda {
                managedObjectContext?.delete(banda)
            do {
                try managedObjectContext?.save()
            } catch let error {
                print("\(error)")
            }
        }
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ShowBandaController {
            destination.managedObjectContext = managedObjectContext
            if segue.identifier == "showDetail" {
                if let indexPath = tableView.indexPathForSelectedRow, let banda = fetchedResultsController?.object(at: indexPath) as? Banda {
                    destination.banda = banda
                }
                
            } else {
                print("\(segue.identifier)")
                destination.banda = nil
            }
            
        }
        
    }
    

}
