//
//  DailyController.swift
//  AlphaVantageShowcase
//
//  Created by Ganang Arief Pratama on 08/01/21.
//

import UIKit

class DailyViewController: UIViewController {
    
    var presenter: DailyPresenterProtocol?
    var symbols: [String]?
    var arrayOfText: [String]?
    let timeseriesGroup = DispatchGroup()
    var dailyTimeseries: [[DailyTimeseries]] = [[DailyTimeseries]]()
    var showSymbols = [String]()
    
    lazy var dailytableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.keyboardDismissMode = .onDrag
        
        return tableView
    }()
    
    lazy var dailySearchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.sizeToFit()
        sb.becomeFirstResponder()
        sb.placeholder = "Search your (max) 3 symbols stock here"
        sb.searchTextField.leftView?.tintColor = .black
        
        return sb
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.titleView = dailySearchBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDepedency()
        setupViews()
    }
    
    func setupDepedency() {
        DailyWireframe.createMainModule(dailyRef: self)
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
        let textFieldInsideSearchBar = dailySearchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .black
        
        //set delegetes
        dailySearchBar.delegate = self
    }
    
    func registerCell() {
        dailytableView.register(DailyCell.self, forCellReuseIdentifier: Constants.KEY_DAILY_CELL)
    }
    
    func setupInterfaceComponent() {
        view.addSubview(dailytableView)
        dailytableView.tableHeaderView = dailySearchBar
    }
    
    func setupConstraint() {
        dailytableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        dailytableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dailytableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dailytableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func checkSymbols(withSearchText searchText: String) {
        
        self.arrayOfText = searchText.split(separator: " ").map { String($0) }
        print(arrayOfText)
        
        if (arrayOfText!.count > 3) {
            let arrayOfSearchText: [String] = Array((arrayOfText?[0..<3])!)
            self.symbols = arrayOfSearchText
        } else {
            self.symbols = arrayOfText
        }
        
        print(self.symbols)
        
    }
    
    func showWarningExceedSymbols() {
        let alert = UIAlertController(title: "Exceed Symbols", message: "Please use max 3 symbols", preferredStyle: .alert)
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
    
    func displayWarningSymbolsAlert() {
        let alert = UIAlertController(title: "Symbol Warning", message: "Something error, please try again", preferredStyle: .alert)
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
    
    func notifyResponse() {
        timeseriesGroup.notify(queue: .main) {
            
            if (self.dailyTimeseries.count > 0) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.dailytableView.reloadData()
                })
            } else {
                self.displayWarningSymbolsAlert()
            }
            
            self.symbols = []
        }
    }
}

extension DailyViewController: DailyViewControllerProtocol {
    
    func displayDailyError(withError error: Error) {
        timeseriesGroup.leave()
    }
    
    func displayDailyResponse(withResponse response: DailyResponse) {
        timeseriesGroup.leave()
        
        let symbol: String = response.metadata!.symbol
        let rawTimeseries = response.dailyTimeseries?.map { $0.value }
        guard let sortingByDate = rawTimeseries?.sorted(by: { $0.dateTime > $1.dateTime }) else { return }
        
        dailyTimeseries.append(sortingByDate)
        showSymbols.append(symbol)
    }
    
}

extension DailyViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.checkSymbols(withSearchText: searchText)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let count = self.arrayOfText?.count else { return }
        let outputsize = LocalStorageService.shared.getOutputSize()
        
        if (count > 0 && count < 4) {
            if let symbols = self.symbols {
                
                for symbol in symbols {
                    timeseriesGroup.enter()
                    
                    let params = ["function": "TIME_SERIES_DAILY_ADJUSTED", "symbol": symbol, "outputsize": outputsize]
                    
                    self.presenter?.getDaily(withParams: params)
                }
                
                self.notifyResponse()
            }
        } else {
            self.showWarningExceedSymbols()
        }
        
        self.dailyTimeseries = []
        self.showSymbols = []
        self.dailySearchBar.text = ""
        self.arrayOfText = []
        
    }
    
}

extension DailyViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (dailyTimeseries.count > 0) {
            return dailyTimeseries[0].count
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.KEY_DAILY_CELL, for: indexPath) as! DailyCell
        
        if showSymbols.count == 1 {
            cell.dateLabel.text = dailyTimeseries[0][indexPath.row].dateTime
            cell.symbol1Label.text = showSymbols[0]
            cell.open1Label.text = dailyTimeseries[0][indexPath.row].open
            cell.low1Label.text = dailyTimeseries[0][indexPath.row].low
        } else if (showSymbols.count == 2) {
            cell.dateLabel.text = dailyTimeseries[0][indexPath.row].dateTime
            cell.symbol1Label.text = showSymbols[0]
            cell.symbol2Label.text = showSymbols[1]
            cell.open1Label.text = dailyTimeseries[0][indexPath.row].open
            cell.open2Label.text = dailyTimeseries[1][indexPath.row].open
            cell.low1Label.text = dailyTimeseries[0][indexPath.row].low
            cell.low2Label.text = dailyTimeseries[1][indexPath.row].low
        } else if (showSymbols.count == 3) {
            cell.dateLabel.text = dailyTimeseries[0][indexPath.row].dateTime
            cell.symbol1Label.text = showSymbols[0]
            cell.symbol2Label.text = showSymbols[1]
            cell.symbol3Label.text = showSymbols[2]
            cell.open1Label.text = dailyTimeseries[0][indexPath.row].open
            cell.open2Label.text = dailyTimeseries[1][indexPath.row].open
            cell.open3Label.text = dailyTimeseries[2][indexPath.row].open
            cell.low1Label.text = dailyTimeseries[0][indexPath.row].low
            cell.low2Label.text = dailyTimeseries[1][indexPath.row].low
            cell.low3Label.text = dailyTimeseries[0][indexPath.row].low
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if showSymbols.count == 1 {
            return 80
        } else if (showSymbols.count == 2) {
            return 100
        } else {
            return 120
        }
        
    }
}


