//
//  TVCTableViewController.swift
//  BsucarTabla2.0
//
//  Created by Juan Andres Garcia C on 11/04/17.
//  Copyright © 2017 Juan Andres Garcia C. All rights reserved.
//

import UIKit

class TVCTableViewController: UITableViewController {
    var libros : Array<Array<String>> = Array<Array<String>>()
    var buscra = false
    var nuevaentradatit = ""
    var nuevaentradaisbn = ""
    @IBOutlet weak var testo: UITextField!
    
    @IBAction func buscad(_ sender: UIBarButtonItem) {
        buscra = true
        
        print("sica")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        self.refreshControl?.beginRefreshing()
        print("TITULOOOOOOOOOOOO\(nuevaentradatit)")
        self.title = "OpenLibrary" //Cambia nombre que aparecen en la flechitas de ir hacia atras
        self.libros.append(["Cien Años de Soledad(Ejemplo)", "978-84-376-0494-7"])
        self.libros.append([nuevaentradatit, nuevaentradaisbn])
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.refreshControl?.endRefreshing()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Celda", for: indexPath)
            cell.textLabel?.text = self.libros[indexPath.row][0]
            // Configure the cell...
            
            return cell
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl?.beginRefreshing()
        print("TITULOOOOOOOOOOOO\(nuevaentradatit)")
        self.title = "OpenLibrary" //Cambia nombre que aparecen en la flechitas de ir hacia atras
        self.libros.append(["Cien Años de Soledad(Ejemplo)", "978-84-376-0494-7"])
        self.libros.append([nuevaentradatit, nuevaentradaisbn])
        self.libros.remove(at: 1)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.refreshControl?.endRefreshing()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.libros.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Celda", for: indexPath)
        cell.textLabel?.text = self.libros[indexPath.row][0]
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if testo.text == ""{
        let cc = segue.destination as! ControlLibroViewController
        
        
        
        let ip = self.tableView.indexPathForSelectedRow// nos va a decir el renglon de lo seleccionado
        cc.codigo = self.libros[ip!.row][1]
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        }else{
        let cc = segue.destination as! ControlLibroViewController
        cc.codigo = testo.text!
        cc.buscrr = buscra
            let codigo = testo.text!
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
                
                let titulo = dico1["title"] as! String
                let paginas = dico1["pagination"] as! String
                nuevaentradatit = titulo
                nuevaentradaisbn = codigo
                self.libros.append([titulo,codigo])
            }catch _ {
                
            }
    }
    }
    

}
