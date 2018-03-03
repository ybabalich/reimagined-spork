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
