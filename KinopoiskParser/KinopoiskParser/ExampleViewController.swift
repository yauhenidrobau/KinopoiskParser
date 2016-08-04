//
//  ExampleViewController.swift
//  KinopoiskParser
//
//  Created by Admin on 8/3/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class ExampleViewController: UIViewController {

    //MARK: Properties
    
    var someProperty : String = ""
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareData()
    }
    
    //MARK: Actions
    
    func someButtonDidTap() -> Void {
        
    }
    
    //MARK: Private
    
    private func prepareData() -> Void {
        RemoteFacade.sharedInstance.loadData("your url") { [weak self] (result) in // [weak self] - это слабая сслыка, чтобы не было retain cycle
            guard  let self_ = self else { return }
            
            switch result {
            case .OfflineError:
                //TODO: show offline alert
                break
            case .Success(let yourData):
                // Parse data
                break
            case .UnexpectedError(let error):
                break
            }
            
            
        }
    }
    
}
