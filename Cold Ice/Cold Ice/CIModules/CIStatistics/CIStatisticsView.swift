//
//  CIStatisticsView.swift
//  Cold Ice
//
//

import SwiftUI
import Charts

struct CIStatisticsView: View {
    @ObservedObject var viewModel: CIRunsViewModel
    
    var favoriteResort: String {
        let grouped = Dictionary(grouping: viewModel.runs.filter { !$0.location.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }) {
            $0.location
        }
        
        return grouped.max(by: { $0.value.count < $1.value.count })?.key ?? "—"
    }
    
    func preferredCondition(from runs: [Run]) -> Condition? {
        let counts = Dictionary(grouping: runs, by: \.conditions)
            .mapValues(\.count)
        
        return counts.max { $0.value < $1.value }?.key
    }
    
    var body: some View {
        VStack {
            VStack {
                Text("Statistics")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.buttonBlue)
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(.secondary.opacity(0.2))
                    .shadow(color: .secondary.opacity(0.4), radius: 1, y: 2)
            }
            
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack(spacing: 20) {
                        VStack {
                            Text("\(viewModel.runs.count)")
                                .font(.system(size: 32, weight: .semibold))
                                .foregroundStyle(.buttonBlue)
                            
                            Text("Total Runs")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundStyle(.black)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 1)
                                .foregroundStyle(.black.opacity(0.3))
                        }
                        
                        VStack {
                            Text("\(viewModel.tricks.filter { $0.status == .mastered }.count)")
                                .font(.system(size: 32, weight: .semibold))
                                .foregroundStyle(.buttonBlue)
                            
                            Text("Tricks Learned")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundStyle(.black)
                        }
                        .padding(.horizontal, 7)
                        .padding(.vertical, 12)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 1)
                                .foregroundStyle(.black.opacity(0.3))
                        }
                    }
                    
                    VStack(spacing: 20) {
                        
                        
                        textFiled(title: "Favorite Resort") {
                            Text(favoriteResort)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        textFiled(title: "Preferred Conditions") {
                            HStack {
                                if let preferedCond = preferredCondition(from: viewModel.runs) {
                                    Image(uiImage: preferedCond.snowType.icon)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 24)
                                }
                                
                                
                                Text("\(preferredCondition(from: viewModel.runs)?.snowType.text ?? "-")")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundStyle(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        
                        preferredConditionsChart
                                        
                        styleDistributionChart
                    }
                }
                .padding(24)
                .padding(.bottom, 150)
            }
                
        }
    }
    
    @ViewBuilder func textFiled<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 8)  {
            Text(title)
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(.secondaryGray)
                .textCase(.uppercase)
            
            content()
        }
    }
}

// MARK: - Models for charts
 struct MonthValueItem: Identifiable {
    let id = UUID()
    let month: String
    let value: Int
}

 struct PieChartItem: Identifiable {
    let id = UUID()
    let title: String
    let value: Int
    let color: Color
}

#Preview {
    CIStatisticsView(viewModel: CIRunsViewModel())
}
