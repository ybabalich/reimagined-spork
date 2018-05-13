//
//  CoinsListCoinsListViewController.swift
//  Crypto
//
//  Created by  on 20/01/2018.
//  Copyright © 2018 PxToday. All rights reserved.
//

import UIKit

class CoinsListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var topView: UIView!
    fileprivate lazy var coinsTopView: CoinsListTopView = {
        return CoinsListTopView.view()
    }()
    
    // MARK: - Variables
    var output: CoinsListViewOutput!
    var settings: CryptoSettings!
    fileprivate var data: [Coin] = {
        return []
    }()

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        table.tableFooterView = UIView(frame: .zero)
        
        //navigation bar
        let goldColor = UIColor(hex: 0xffe34c)
        title = "COINS LIST"
        navigationController?.navigationBar.barTintColor = UIColor(from: 42, green: 42, blue: 42, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: goldColor, NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Medium", size: 18)!]
        
        //adding buttons
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action,
                                          target: self,
                                          action: #selector(CoinsListViewController.shareBtnEvent))
        shareButton.tintColor = goldColor
        navigationItem.rightBarButtonItems = [shareButton]
        
        //add top view
        topView.addSubview(coinsTopView)
        coinsTopView.alignExpandToSuperview()
        coinsTopView.onCurrencyTap { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.onCurrencyTapEvent()
        }
        updateCurrencyTitle()
    }
    
    private func reloadUI() {
        ui { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.table.reloadData()
        }
    }
    
    private func updateCurrencyTitle() {
        let title = getCurrencyTitle(by: settings.currencyType)
        coinsTopView.setCurrency(title: title)
    }
    
    private func getCurrencyTitle(by type: App.CurrencyType) -> String {
        return type.rawValue.uppercased() + " " + "\(type.symbol())"
    }
    
    fileprivate func loadData() {
        let coinsService = CoinsLoaderService() // |FIX| relocate to Interactor
        
        coinsService.loadList { [weak self] (coinsList, error) in
            guard let strongSelf = self else { return }
            if error == nil {
                let coinsNames = Defines.baseListCoinsNames()
                strongSelf.data = coinsService.retrieveCoins(names: coinsNames, from: coinsList!.elements)
                coinsService.loadPrices(in: [strongSelf.settings.currencyType], to: coinsNames, completion: { (prices) in
                    prices.forEach({ (price) in
                        strongSelf.data.forEach({ (coin) in
                            var coin = coin
                            if coin.name.lowercased() == price.coinName.lowercased() {
                                coin.price = price
                            }
                        })
                    })
                    strongSelf.reloadUI()
                })
            } else {
                print("ERROR!")
            }
        }
    }
    
    // MARK: - Events
    @objc private func shareBtnEvent() {
        
    }
    
    @IBAction func addCoinBtnEvent(_ sender: UIButton) {
        
    }
    
    @IBAction func converterBtnEvent(_ sender: UIButton) {
        output.didTapConverterBtn()
    }
    
    private func onCurrencyTapEvent() {
        let alert = Alert.alert(title: "Choose your currency:", message: nil)
        
        for type in App.CurrencyType.allValues {
            let title = getCurrencyTitle(by: type)
            alert.add(action: AlertAction.init(title: title, style: .default)) { [weak self] (action) in
                guard let strongSelf = self else { return }
                let currentTitle = action.title
                for actionType in App.CurrencyType.allValues {
                    if currentTitle!.lowercased().hasPrefix(actionType.rawValue) {
                        strongSelf.settings.currencyType = actionType
                        strongSelf.updateCurrencyTitle()
                    }
                }
            }
        }
        alert.show(from: navigationController!)
    }
    
}

extension CoinsListViewController: CoinsListViewInput {
    func setupInitialState() {
        setupUI()
        
        if !Defines.isDev() {
            loadData()
        } else {
            let generator = TestDataCreator()
            data = generator.generateTestCoins(count: 10)
            table.reloadData()
        }

    }
}

extension CoinsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 109
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coin = data[indexPath.row]
        output.didChoose(coin: coin)
    }
}

extension CoinsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reusableTableCell(cellClass: CoinCell.self) as! CoinCell
        cell.apply(coin: data[indexPath.row])
        return cell
    }
}
