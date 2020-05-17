//
//  ViewController.swift
//  Try1
//
//  Created by Dre on 5/17/20.
//  Copyright © 2020 Dre. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var LabelKonfirmasi:UILabel!
    @IBOutlet weak var LabelMati: UILabel!
    @IBOutlet weak var LabelAktif: UILabel!
    @IBOutlet weak var LabelSembuh: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        let url = "https://api.covid19api.com/country/indonesia"
       
        getData(from: url)
    }
    
    private func getData(from url: String)
    {
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data,response, error in
            guard let data = data, error == nil else {
                print("ada yang eror")
                return
            }
            //jesen
            var result: [Response]?
            
            do{
                result = try JSONDecoder().decode([Response].self, from: data)
            }
            catch {
                print("gagal konvert \(error.localizedDescription)")
            }
            
            guard let json = result else {
                return
            }
            
            DispatchQueue.main.async {
                self.LabelMati.text=String(json[json.endIndex-1].Deaths)
                self.LabelKonfirmasi.text=String(json[json.endIndex-1].Confirmed)
                self.LabelSembuh.text=String(json[json.endIndex-1].Recovered)
                self.LabelAktif.text=String(json[json.endIndex-1].Active)
            }
        }).resume()
    }

    
}



struct Response: Codable
{
    let Deaths: Int
    let Confirmed : Int
    let Recovered : Int
    let Active : Int
    let Date : String
  //  let Date : String
}

