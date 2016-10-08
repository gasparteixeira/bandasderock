//
//  DetalheBandaController.swift
//  Bandas
//
//  Created by Gaspar on 03/10/16.
//  Copyright © 2016 Gaspar Teixeira. All rights reserved.
//

import UIKit
import CoreData

class DetalheBandaController: UIViewController {
    
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

    @IBOutlet weak var nomeEdit: UITextField!
    @IBOutlet weak var estiloEdit: UITextField!
    @IBOutlet weak var paisEdit: UITextField!
    @IBOutlet weak var anoEdit: UITextField!
    
    private func updateUI() {
        nomeEdit?.text = banda?.nome
        estiloEdit?.text = banda?.estilo
        paisEdit?.text = banda?.pais
        
        if let ano = banda?.ano {
            anoEdit?.text = String(ano)
        }
    }
    

    // MARK: Handle navigation by saving or not.
    
    @IBAction func cancelEdit(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBanda(_ sender: UIBarButtonItem) {
        
        // Se existe um contexto gerenciado...
        if let context = managedObjectContext {
            // ou atualiza o livro existente...
            if let band = banda {
                band.nome = nomeEdit.text
                band.estilo = estiloEdit.text
                band.pais = paisEdit.text
                if let anoText = anoEdit.text,
                    let ano = Int16(anoText)
                {
                    band.ano = ano
                }
            } else {
                // ou, se o usuario digitou um nome, cria uma banda...
                if let nome = nomeEdit.text
                {
                    let estilo = estiloEdit.text
                    let pais = paisEdit.text
                    var ano: Int16? = nil
                    if let anoText = anoEdit.text {
                        ano = Int16(anoText)
                    }
                    let _ = Banda.createWith(nome: nome,
                                             estilo: estilo,
                                             pais: pais,
                                             ano: ano,
                                             in: context)
                }
            }
            // ao final, salva as alteracoes do documento.
            do {
                try context.save()
            } catch let error {
                print("\(error)")
            }
        }
        // retorna a tela anterior
        _ = navigationController?.popToRootViewController(animated: true)
    }
    

}
