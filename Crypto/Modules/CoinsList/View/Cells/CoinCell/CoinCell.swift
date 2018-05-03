//
//  CoinCell.swift
//  Crypto
//
//  Created by Yaroslav Babalich on 1/28/18.
//  Copyright © 2018 PxToday. All rights reserved.
//

import UIKit

class CoinCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var coinShortName: UILabel!
    @IBOutlet weak var coinLongName: UILabel!
    @IBOutlet weak var coinPrice: UILabel!
    @IBOutlet weak var coinRightLabel: UILabel!
    
    @IBOutlet weak var coinLogo: ImageLoaderView!
    
    // MARK: - Variables
    private var lastLogoFrame: CGRect = .zero
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        clearUI()
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clearUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if lastLogoFrame != coinLogo.frame {
            coinLogo.layer.cornerRadius = coinLogo.frame.height / 2
            lastLogoFrame = coinLogo.frame
        }
    }

    // MARK: - Public methods
    func apply(coin: Coin) {
        coinShortName.text = coin.coinName
        coinLongName.text = coin.name
        coinLogo.layer.masksToBounds = true
        if let imageUrl = coin.imageUrl {
            coinLogo.loadImageFrom(url: imageUrl)
        }
        
        if let price = coin.price, price.values.count > 0 { //price
            let currentPrice = price.values[0]
            coinPrice.text = "\(currentPrice.value)" + "\(currentPrice.currency.symbol())"
            coin.history.loadOneDayAgoPrice { [weak self] in
                guard let strongSelf = self else { return }
                let dayAgoPrice = coin.history.oneDayAgo?.value ?? 0
                let difference = currentPrice.value - dayAgoPrice
                var textColor: UIColor? = .white
                if difference > 0 {
                    textColor = .green
                } else if difference < 0 {
                    textColor = .red
                }
                ui {
                    let stringValue = String(format: "%.2f", difference) + "\(currentPrice.currency.symbol())"
                    strongSelf.coinRightLabel.text = stringValue
                    strongSelf.coinRightLabel.textColor = textColor
                }
            }
        } else {
            coinPrice.text = "-"
        }
    }
    
    // MARK: - Private methods
    private func setupUI() {
        backView.layer.cornerRadius = 5
        backView.layer.masksToBounds = true
        backView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
    }
    
    private func clearUI() {
        coinShortName.text = ""
        coinLongName.text = ""
    }
}
