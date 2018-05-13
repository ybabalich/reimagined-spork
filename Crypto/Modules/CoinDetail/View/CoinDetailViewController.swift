//
//  CoinDetailCoinDetailViewController.swift
//  Crypto
//
//  Created by  on 27/04/2018.
//  Copyright © 2018 PxToday. All rights reserved.
//

import UIKit
import Charts

class CoinDetailViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var chartView: UIView!
    
    // MARK: - Variables
    var coin: Coin? {
        didSet {
            title = coin?.coinName
        }
    }
    override var navigationTitle: String {
        return coin?.coinName ?? "Coin detail"
    }
    var output: CoinDetailViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChart()
    }

    func setupChart() {
        let lineChartView = LineChartView()
        chartView.addSubview(lineChartView)
        lineChartView.alignExpandToSuperview()
        
        //adding data
        var lineChartData: [ChartDataEntry] = []
        lineChartData.append(ChartDataEntry(x: 0, y: 2))
        lineChartData.append(ChartDataEntry(x: 3, y: 10))
        lineChartData.append(ChartDataEntry(x: 4, y: 12))
        lineChartData.append(ChartDataEntry(x: 6, y: 15))
        
        //linies
        let line = LineChartDataSet(values: lineChartData, label: "Test")
        line.colors = [.red]
        
        //line chart
        let lineChart = LineChartData()
        lineChart.addDataSet(line)
        
        lineChartView.data = lineChart
        lineChartView.chartDescription?.text = "Text label"
    }
}

extension CoinDetailViewController: CoinDetailViewInput {
    func setupInitialState() {
    }
}
