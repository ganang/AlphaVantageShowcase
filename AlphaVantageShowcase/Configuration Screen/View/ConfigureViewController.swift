//
//  ConfigureViewController.swift
//  AlphaVantageShowcase
//
//  Created by Ganang Arief Pratama on 09/01/21.
//

import UIKit

class ConfigureViewController: UIViewController {
    
    let configNameArray = ["API_KEY", "INTERVAL", "OUTPUTSIZE"]
    var configValueArray = [String]()
    
    lazy var configCollectionView: UICollectionView = {
        let customFlowLayout = UICollectionViewFlowLayout()
        customFlowLayout.sectionInsetReference = .fromContentInset // .fromContentInset is default
        customFlowLayout.minimumLineSpacing = 16
        customFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: customFlowLayout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupValueArray()
    }
    
    func setupViews() {
        setupInterfaceComponent()
        setupConstraint()
        registerCell()
    }
    
    func setupInterfaceComponent() {
        view.backgroundColor = .white
        view.addSubview(configCollectionView)
    }
    
    func setupConstraint() {
        configCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        configCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        configCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        configCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func registerCell() {
        configCollectionView.register(ConfigCell.self, forCellWithReuseIdentifier: Constants.KEY_CONFIG_CELL)
        configCollectionView.reloadData()
    }
    
    func setupValueArray() {
        let apikey = LocalStorageService.shared.getApikey()
        let interval = LocalStorageService.shared.getInterval()
        let outputsize = LocalStorageService.shared.getOutputSize()
        
        configValueArray.append(apikey)
        configValueArray.append(interval)
        configValueArray.append(outputsize)
    }
    
    @objc func changeValue(_ sender: UIButton) {
        let tag = sender.tag
        
        switch tag {
        case 0:
            showChangeApiKeyAlert()
        case 1:
            showChangeIntervalAlert()
        case 2:
            showChangeOutputSizeAlert()
        default:
            print("cancel")
        }
    }
    
    func showChangeApiKeyAlert() {
        let alert = UIAlertController(title: "APIKEY", message: "change your apikey here", preferredStyle: .alert)
        alert.addTextField() { newTextField in
            newTextField.placeholder = "change your apikey here"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("cancel")
        })
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
            if
                let textFields = alert.textFields,
                let tf = textFields.first,
                let result = tf.text
            {
                self.changeApiKey(withApiKey: result)
            }
            else
            { print("cancel") }
        })
        navigationController?.present(alert, animated: true)
    }
    
    func changeApiKey(withApiKey apikey: String) {
        LocalStorageService.shared.setApikey(withApiKey: apikey, withKey: "apikey")
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = configCollectionView.cellForItem(at: indexPath) as! ConfigCell
        
        cell.parameterLabel.text = apikey
        
    }
    
    func showChangeIntervalAlert() {
        let alert = UIAlertController(title: "Interval", message: "Please Choose your Interval", preferredStyle: .actionSheet)
        
        let indexPath = IndexPath(row: 1, section: 0)
        let cell = configCollectionView.cellForItem(at: indexPath) as! ConfigCell
        
        alert.addAction(UIAlertAction(title: "1min", style: .default , handler:{ (UIAlertAction)in
            LocalStorageService.shared.setInterval(interval: "1min")
            cell.parameterLabel.text = "1min"
        }))
        
        alert.addAction(UIAlertAction(title: "5min", style: .default , handler:{ (UIAlertAction)in
            LocalStorageService.shared.setInterval(interval: "5min")
            cell.parameterLabel.text = "5min"
        }))
        
        alert.addAction(UIAlertAction(title: "15min", style: .default , handler:{ (UIAlertAction)in
            LocalStorageService.shared.setInterval(interval: "15min")
            cell.parameterLabel.text = "15min"
        }))
        
        alert.addAction(UIAlertAction(title: "30min", style: .default , handler:{ (UIAlertAction)in
            LocalStorageService.shared.setInterval(interval: "30min")
            cell.parameterLabel.text = "30min"
        }))
        
        alert.addAction(UIAlertAction(title: "60min", style: .default , handler:{ (UIAlertAction)in
            LocalStorageService.shared.setInterval(interval: "60min")
            cell.parameterLabel.text = "60min"
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in

        }))
        
        //uncomment for iPad Support
        //alert.popoverPresentationController?.sourceView = self.view
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    func showChangeOutputSizeAlert() {
        let alert = UIAlertController(title: "OutputSize", message: "Please Choose your OutputSize", preferredStyle: .actionSheet)
        
        let indexPath = IndexPath(row: 2, section: 0)
        let cell = configCollectionView.cellForItem(at: indexPath) as! ConfigCell
        
        alert.addAction(UIAlertAction(title: "compact", style: .default , handler:{ (UIAlertAction)in
            LocalStorageService.shared.setOutputSize(outputsize: "compact")
            cell.parameterLabel.text = "compact"
        }))
        
        alert.addAction(UIAlertAction(title: "full", style: .default , handler:{ (UIAlertAction)in
            LocalStorageService.shared.setOutputSize(outputsize: "full")
            cell.parameterLabel.text = "full"
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in

        }))
        
        //uncomment for iPad Support
        //alert.popoverPresentationController?.sourceView = self.view
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
}

extension ConfigureViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.KEY_CONFIG_CELL, for: indexPath) as! ConfigCell
        cell.titleLabel.text = configNameArray[indexPath.row]
        cell.parameterLabel.text = configValueArray[indexPath.row]
        cell.changeButton.addTarget(self, action: #selector(changeValue), for: .touchUpInside)
        cell.changeButton.tag = indexPath.row
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.configCollectionView.frame.width - 32
        
        return CGSize(width: width, height: 40)
    }
}

