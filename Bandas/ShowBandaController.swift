//
//  ShowBandaController.swift
//  Bandas
//
//  Created by Gaspar on 05/10/16.
//  Copyright © 2016 Gaspar Teixeira. All rights reserved.
//

import UIKit
import CoreData

class ShowBandaController: UIViewController {
    
    weak var managedObjectContext: NSManagedObjectContext?
    
    weak var banda: Banda? {
        didSet{
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    
    @IBOutlet weak var labelNome: UILabel!
    @IBOutlet weak var labelEstilo: UILabel!
    @IBOutlet weak var labelPais: UILabel!
    @IBOutlet weak var labelAno: UILabel!
    
    private func updateUI() {
        labelNome?.text = banda?.nome
        labelEstilo?.text = banda?.estilo
        labelPais?.text = banda?.pais
        if let ano = banda?.ano {
            labelAno?.text = String(ano)
        }
    }
    
    // MARK: - Navigation
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
        
    }


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetalheBandaController {
            destination.managedObjectContext = managedObjectContext
            
            if segue.identifier == "editDetail" {
                destination.banda = banda
                
            }
            
        }
    }


}
