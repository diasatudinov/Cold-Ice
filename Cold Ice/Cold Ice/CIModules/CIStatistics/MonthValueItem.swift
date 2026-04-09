//
//  MonthValueItem.swift
//  Cold Ice
//
//

import SwiftUI
import Charts

extension CIStatisticsView {
    var preferredConditionsChart: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("PREFERRED CONDITIONS")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.secondary)
            
            Chart(preferredConditionMonthlyData) { item in
                BarMark(
                    x: .value("Month", item.month),
                    y: .value("Count", item.value)
                )
                .foregroundStyle(Color.blue)
                .cornerRadius(10)
            }
            .chartYAxis {
                AxisMarks(position: .leading) { _ in
                    AxisGridLine(stroke: StrokeStyle(lineWidth: 1, dash: [4, 4]))
                        .foregroundStyle(Color.gray.opacity(0.25))
                    AxisTick()
                        .foregroundStyle(Color.gray.opacity(0.6))
                    AxisValueLabel()
                        .foregroundStyle(.secondary)
                }
            }
            .chartXAxis {
                AxisMarks { _ in
                    AxisGridLine(stroke: StrokeStyle(lineWidth: 1, dash: [4, 4]))
                        .foregroundStyle(Color.gray.opacity(0.25))
                    AxisTick()
                        .foregroundStyle(Color.gray.opacity(0.6))
                    AxisValueLabel()
                        .foregroundStyle(.secondary)
                }
            }
            .frame(height: 260)
        }
        .padding(18)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(.secondary, lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.06), radius: 8, y: 2)
    }
    
    var styleDistributionChart: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("STYLE DISTRIBUTION")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.secondary)
            
            PieChartView(items: rideStyleChartData)
                .frame(height: 280)
            
            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 12),
                    GridItem(.flexible(), spacing: 12)
                ],
                spacing: 14
            ) {
                ForEach(rideStyleChartData) { item in
                    HStack(spacing: 8) {
                        Circle()
                            .fill(item.color)
                            .frame(width: 14, height: 14)
                        
                        Text("\(item.title): \(item.value)")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.black)
                        
                        Spacer()
                    }
                }
            }
        }
        .padding(18)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(.secondary, lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.06), radius: 8, y: 2)
    }
}

extension CIStatisticsView {
    var preferredConditionMonthlyData: [MonthValueItem] {
        guard let preferredSnowType = preferredSnowType(from: viewModel.runs) else { return [] }
        
        let calendar = Calendar.current
        let currentMonthStart = calendar.date(from: calendar.dateComponents([.year, .month], from: Date())) ?? Date()
        
        let months: [Date] = (-3...0).compactMap {
            calendar.date(byAdding: .month, value: $0, to: currentMonthStart)
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        
        return months.map { monthDate in
            let month = calendar.component(.month, from: monthDate)
            let year = calendar.component(.year, from: monthDate)
            
            let count = viewModel.runs.filter {
                calendar.component(.month, from: $0.date) == month &&
                calendar.component(.year, from: $0.date) == year &&
                $0.conditions.snowType == preferredSnowType
            }.count
            
            return MonthValueItem(
                month: formatter.string(from: monthDate),
                value: count
            )
        }
    }
    
    var rideStyleChartData: [PieChartItem] {
        let grouped = Dictionary(grouping: viewModel.runs, by: \.rideStyle)
            .mapValues(\.count)
        
        let colors: [Color] = [.blue, .green, .yellow, .red, .purple, .orange]
        
        let sorted = grouped
            .sorted { $0.value > $1.value }
        
        if sorted.isEmpty {
            return [
                PieChartItem(title: "No Data", value: 1, color: .gray.opacity(0.35))
            ]
        }
        
        return sorted.enumerated().map { index, item in
            PieChartItem(
                title: rideStyleTitle(item.key),
                value: item.value,
                color: colors[index % colors.count]
            )
        }
    }
    
    func preferredSnowType(from runs: [Run]) -> SnowType? {
        let counts = Dictionary(grouping: runs, by: { $0.conditions.snowType })
            .mapValues(\.count)
        
        return counts.max(by: { $0.value < $1.value })?.key
    }
    
    func rideStyleTitle(_ style: RideStyle) -> String {
        String(describing: style.rideStyle.text)
            .replacingOccurrences(of: "_", with: " ")
            .capitalized
    }
}


private struct PieChartView: View {
    let items: [PieChartItem]
    
    private var total: Double {
        Double(items.map(\.value).reduce(0, +))
    }
    
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            let radius = size / 2.2
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            
            ZStack {
                ForEach(Array(pieSlices.enumerated()), id: \.offset) { _, slice in
                    Path { path in
                        path.move(to: center)
                        path.addArc(
                            center: center,
                            radius: radius,
                            startAngle: slice.startAngle,
                            endAngle: slice.endAngle,
                            clockwise: false
                        )
                        path.closeSubpath()
                    }
                    .fill(slice.color)
                    .overlay {
                        Path { path in
                            path.move(to: center)
                            path.addArc(
                                center: center,
                                radius: radius,
                                startAngle: slice.startAngle,
                                endAngle: slice.endAngle,
                                clockwise: false
                            )
                            path.closeSubpath()
                        }
                        .stroke(Color.white, lineWidth: 2)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    private var pieSlices: [PieSlice] {
        guard total > 0 else { return [] }
        
        var currentAngle = Angle(degrees: -90)
        
        return items.map { item in
            let degrees = Double(item.value) / total * 360
            let slice = PieSlice(
                startAngle: currentAngle,
                endAngle: currentAngle + Angle(degrees: degrees),
                color: item.color
            )
            currentAngle += Angle(degrees: degrees)
            return slice
        }
    }
    
    private struct PieSlice {
        let startAngle: Angle
        let endAngle: Angle
        let color: Color
    }
}
