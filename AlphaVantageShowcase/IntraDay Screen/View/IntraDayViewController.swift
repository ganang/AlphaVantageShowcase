//
//  IntraDayViewController.swift
//  AlphaVantageShowcase
//
//  Created by Ganang Arief Pratama on 08/01/21.
//

import UIKit

class IntraDayViewController: UIViewController {
    
    var presenter: IntraDayPresenterProtocol?
    var timeseries: [TimeSeriesIntraDay]?
    var rawTimeseries: [TimeSeriesIntraDay]?
    var symbol: String = ""
    
    lazy var sortingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SortBy: Date/Time", for: .normal)
        button.titleLabel?.font =  .systemFont(ofSize: 12)
        button.addTarget(self, action: #selector(handleSorting), for: .touchUpInside)
        button.backgroundColor = UIColor.init(displayP3Red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
        
        return button
    }()
    
    lazy var intraDaytableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.keyboardDismissMode = .onDrag
        
        return tableView
    }()
    
    lazy var intraDaySearchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.sizeToFit()
        sb.becomeFirstResponder()
        sb.placeholder = "Search your symbol stock here"
        sb.searchTextField.leftView?.tintColor = .black
        
        return sb
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.titleView = intraDaySearchBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDepedency()
        setupViews()
    }
    
    func setupDepedency() {
        IntraDayWireframe.createMainModule(intraDayRef: self)
    }
    
    func setupViews() {
        view.backgroundColor = .white
        
        setupSearchBar()
        setupInterfaceComponent()
        setupConstraint()
        registerCell()
    }
    
    func setupSearchBar() {
        
        //accesing Textfield inside searchbar
        let textFieldInsideSearchBar = intraDaySearchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .black
        
        //set delegetes
        intraDaySearchBar.delegate = self
    }
    
    func registerCell() {
        intraDaytableView.register(IntraDayCell.self, forCellReuseIdentifier: Constants.KEY_INTRA_DAY_CELL)
    }
    
    func setupInterfaceComponent() {
        view.addSubview(intraDaytableView)
        view.addSubview(sortingButton)
        intraDaytableView.tableHeaderView = intraDaySearchBar
    }
    
    func setupConstraint() {
        intraDaytableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        intraDaytableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        intraDaytableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        intraDaytableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80).isActive = true
        
        sortingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -92).isActive = true
        sortingButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        sortingButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        sortingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sortingButton.layer.cornerRadius = 8
    }
    
    @objc func handleSorting() {
        
        let timeseriesCount = timeseries?.count
        
        if (timeseriesCount != nil) {
            handleShowAlert()
        }
        
    }
    
    func handleShowAlert() {
        let alert = UIAlertController(title: "Sorting", message: "Please Choose your Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Low", style: .default , handler:{ (UIAlertAction)in
            
            let sortingByLow = self.rawTimeseries?.sorted(by: { $0.low > $1.low })
            
            DispatchQueue.main.async {
                self.sortingButton.setTitle("SortBy: Low", for: .normal)
                self.timeseries = sortingByLow
                self.intraDaytableView.reloadData()
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "High", style: .default , handler:{ (UIAlertAction)in
            
            let sortingByHigh = self.rawTimeseries?.sorted(by: { $0.high > $1.high })
            
            DispatchQueue.main.async {
                self.sortingButton.setTitle("SortBy: High", for: .normal)
                self.timeseries = sortingByHigh
                self.intraDaytableView.reloadData()
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Open", style: .default , handler:{ (UIAlertAction)in
            
            let sortingByOpen = self.rawTimeseries?.sorted(by: { $0.open > $1.open })
            
            DispatchQueue.main.async {
                self.sortingButton.setTitle("SortBy: Open", for: .normal)
                self.timeseries = sortingByOpen
                self.intraDaytableView.reloadData()
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Date/Time", style: .default , handler:{ (UIAlertAction)in
            
            let soringByDate = self.rawTimeseries?.sorted(by: { $0.dateTime > $1.dateTime })
            
            DispatchQueue.main.async {
                self.sortingButton.setTitle("SortBy: Date/Time", for: .normal)
                self.timeseries = soringByDate
                self.intraDaytableView.reloadData()
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in

        }))
        
        
        //uncomment for iPad Support
        //alert.popoverPresentationController?.sourceView = self.view
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    func displayWarningSymbolAlert() {
        let alert = UIAlertController(title: "Symbol Warning", message: "Please try using another symbol", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                        switch action.style{
                                        case .default:
                                            print("cancel")
                                        case .cancel:
                                            print("cancel")
                                        case .destructive:
                                            print("cancel")
                                        @unknown default: break
                                        }}))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension IntraDayViewController: IntraDayViewControllerProtocol {
    func displayIntraDayError(withError error: Error) {
        self.displayWarningSymbolAlert()
    }
    
    func displayIntraDayResponse(withResponse response: IntraDayResponse) {
        
        self.rawTimeseries = response.timeSeriesIntraDay?.map {
            $0.value
        }
        
        let soringByDate = rawTimeseries?.sorted(by: { $0.dateTime > $1.dateTime })
        
        DispatchQueue.main.async {
            self.timeseries = soringByDate
            self.symbol = ""
            self.intraDaytableView.reloadData()
        }
    }
    
}

extension IntraDayViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.symbol = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let params = ["function": "TIME_SERIES_INTRADAY", "symbol": symbol, "interval": "15min"]
        
        self.presenter?.getIntraDay(withParams: params)
        self.intraDaySearchBar.text = ""
        self.symbol = ""
    }
    
}

extension IntraDayViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.timeseries?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.KEY_INTRA_DAY_CELL, for: indexPath) as! IntraDayCell
        cell.dateLabel.text = self.timeseries?[indexPath.row].dateTime
        cell.openLabel.text = self.timeseries?[indexPath.row].open
        cell.highLabel.text = self.timeseries?[indexPath.row].high
        cell.lowLabel.text = self.timeseries?[indexPath.row].low
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
    
