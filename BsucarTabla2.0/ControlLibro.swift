//
//  ControlLibroViewController.swift
//  BsucarTabla2.0
//
//  Created by Juan Andres Garcia C on 11/04/17.
//  Copyright © 2017 Juan Andres Garcia C. All rights reserved.
//

import UIKit

class ControlLibroViewController: UIViewController {
var codigo = ""
    var buscrr = false
    @IBOutlet weak var buscar: UITextField!
    
    @IBOutlet weak var titul: UILabel!
    
    @IBOutlet weak var autor: UILabel!
    
    @IBOutlet weak var pagss: UILabel!
    
    
    var lib : Array<Array<String>> = Array<Array<String>>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
            //https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:978-84-376-0494-7
            let url = NSURL(string: urls + codigo)
            let datos = NSData(contentsOf: url! as URL)
            do{
                let json = try JSONSerialization.jsonObject(with: datos as! Data, options: JSONSerialization.ReadingOptions.allowFragments)
                let dico = json as! NSDictionary
                let dico1 = dico["ISBN:" + codigo] as! NSDictionary
                let dico2 = dico1["authors"] as! NSArray
                print(dico2)
                let autor1 = dico2.object(at: 0) as! NSDictionary
                let autor2 = autor1["name"] as! String
                print(autor)
                let titulo = dico1["title"] as! String
                let paginas = dico1["pagination"] as! String
                
                titul.text = "Titulo de la obra:\(titulo)"
                autor.text = "Autor:\(autor2)"
                pagss.text = "Numero de Paginas:\(paginas)"
            }catch _ {
                
            }
            

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if buscrr == true{
        let cc = segue.destination as! TVCTableViewController
        cc.nuevaentradatit = titul.text!
        cc.nuevaentradaisbn = codigo
        cc.self.libros.append([titul.text!, codigo])
        
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    


}
