//
//  IntraDayViewController.swift
//  AlphaVantageShowcase
//
//  Created by Ganang Arief Pratama on 08/01/21.
//

import UIKit

public enum Sorting: String {
    case open
    case low
    case high
    case dateTime
}

class IntraDayViewController: UIViewController {
    
    var presenter: IntraDayPresenterProtocol?
    var timeseries: [TimeSeriesIntraDay]?
    var symbol: String = ""
    
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
        intraDaytableView.tableHeaderView = intraDaySearchBar
    }
    
    func setupConstraint() {
        intraDaytableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        intraDaytableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        intraDaytableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        intraDaytableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}

extension IntraDayViewController: IntraDayViewControllerProtocol {
    func displayIntraDayResponse(withResponse response: IntraDayResponse) {
        
        let timeseriesFilter = response.timeSeriesIntraDay?.map {
            $0.value
        }
        
        let sortingByOpen = timeseriesFilter?.sorted(by: { $0.open > $1.open })
        let sortingByLow = timeseriesFilter?.sorted(by: { $0.low > $1.low })
        let sortingByHigh = timeseriesFilter?.sorted(by: { $0.high > $1.high })
        let soringByDate = timeseriesFilter?.sorted(by: { $0.dateTime > $1.dateTime })
        
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
        
        print(self.symbol)
        let params = ["function": "TIME_SERIES_INTRADAY", "symbol": symbol, "interval": "15min"]
        
        self.presenter?.getIntraDay(withParams: params)
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
    
