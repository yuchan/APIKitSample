//
//  ViewController.swift
//  APIKitSample
//
//  Created by Yusuke Ohashi on 2017/11/10.
//  Copyright © 2017 Yusuke Ohashi. All rights reserved.
//

import UIKit
import APIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var areas: [AreaClass]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if areas != nil {
            tableView.reloadData()
        } else {
            let req = AreaRequest()
            Session.send(req, callbackQueue: .sessionQueue) {
                result in
                switch result {
                case .success(let response):
                    self.areas = response.areas
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "TableCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let viewController: ViewController = self.storyboard?.instantiateViewController(withIdentifier: "mainList") as! ViewController
        viewController.areas = areas![indexPath.row].areas
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let areas = areas {
            return areas.count
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") {
            if let areas = areas, areas.count > 0 {
                cell.textLabel?.text = areas[indexPath.row].name
            } else {
                cell.textLabel?.text = "no data"
            }
            return cell
        }
        
        return UITableViewCell()
    }
}
