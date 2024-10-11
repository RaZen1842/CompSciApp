//
//  ChartView.swift
//  Cryptocurrency Predictor
//
//  Created by Veturi, Shreyas (HJRM) on 10/10/2024.
//

import SwiftUI
import Charts

struct CryptoChartView: View {
    let cryptoHistoricalData: [CryptoHistoricalData]
    
    var body: some View {
        Chart {
            ForEach(cryptoHistoricalData, id: \.id) { dataPoint in
                if let date = dataPoint.newDate {
                    LineMark(
                        x: .value("Date", date),
                        y: .value("Price", dataPoint.close)
                    )
                    .foregroundStyle(.blue)
                }
            }
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .year, count: 1)) { value in
                AxisValueLabel(format: .dateTime.year())
            }
        }
    }
}

#Preview {
    
    let dummyData: [CryptoHistoricalData] = [
        CryptoHistoricalData(date: "2024-10-09", change: 0.58, changePercent: 5.4, close: 80000, label: "")
    ]
    CryptoChartView(cryptoHistoricalData: dummyData)
}
