//
//  MisLibrosViewController.swift
//  Books
//
//  Created by alumno on 20/12/2019.
//  Copyright © 2019 Carlos. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import Firebase
class MisLibrosViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    var myBooksModel = MisLibrosModel()
    var storage = Storage.storage()
    var bookItemArrayList : [BookItem] = []
    var image:UIImage?
    var cantidad:Int = 0
    let ref = Database.database().reference(withPath: "booksUser")
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.collectionView.dataSource = self
        
        //Register cells
        self.collectionView.register(UINib(nibName: "ItemCell", bundle: nil), forCellWithReuseIdentifier: "ItemCell")
        
        //llenamos el array
        refreshView()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookItemArrayList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
                   DispatchQueue.global().async { [weak self] in
                   self!.myBooksModel.fillArray { (error, array) in
                       if(error == false){
                           let url = URL(string:array[indexPath.row].image)
                           if let data = try? Data(contentsOf: url!) {
                             if let image = UIImage(data: data) {
                                 DispatchQueue.main.async {
                                     cell.setData(image: image, author: array[indexPath.row].author, title: array[indexPath.row].title)
                                   print(array.count, "cantidad")
                                   
                               }
                             }
                             else
                             {
                                 print("Fallo en la descarga de la imagen")
                             }
                             
                         }
                           self?.bookItemArrayList = array

                       }
                       
                   }
         
               }
               
               return cell
    }
    
    func refreshView(){
        myBooksModel.fillArray { (error, array) in
            if(error == false){
                self.bookItemArrayList = array
                self.collectionView.reloadData()
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
