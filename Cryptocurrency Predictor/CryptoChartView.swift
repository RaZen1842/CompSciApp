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
        //Need to add a selction i.e All time, year, month, week, day
        Chart {
            ForEach(cryptoHistoricalData, id: \.id) { dataPoint in
                if let date = dataPoint.newDate {
                    LineMark(
                        x: .value("Date", date),
                        y: .value("Price", dataPoint.close)
                    )
                    .foregroundStyle(.blue)
                    .accessibilityIdentifier("DataPoint-\(dataPoint.id)")
                }
            }
        }
        .accessibilityIdentifier("CryptoChart")
        .chartXAxis {
            AxisMarks(values: .stride(by: .year, count: 1)) { value in
                AxisValueLabel(format: .dateTime.year())
            }
        }
        .chartYAxis {
            AxisMarks(values: .automatic) { value in
                AxisGridLine()
                AxisValueLabel {
                    if let price = value.as(Double.self) {
                        Text("$\(price, format: .number)")
                    }
                }
            }
        }
    }
}

#Preview {
    CryptoChartView(cryptoHistoricalData: [
        CryptoHistoricalData(date: "2024-10-09", change: 0.58, changePercent: 5.4, close: 80000, label: "")
    ])
}
