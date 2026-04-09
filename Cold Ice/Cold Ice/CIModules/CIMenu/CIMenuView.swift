//
//  CIMenuView.swift
//  Cold Ice
//
//

import SwiftUI

struct BBMenuContainer: View {
    
    @AppStorage("firstOpenBB") var firstOpen: Bool = true
    
    var body: some View {
        NavigationStack {
            CIMenuView()
        }
    }
}

struct CIMenuView: View {
    @State var selectedTab = 0
    @StateObject var viewModel = CIRunsViewModel()
    private let tabs = ["Runs", "Tricks", "Stats"]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            TabView(selection: $selectedTab) {
                CIRunsView(viewModel: viewModel)
                    .tag(0)
                
                CITricksView(viewModel: viewModel)
                    .tag(1)
                
                CIStatisticsView(viewModel: viewModel)
                    .tag(2)
            }
            
            customTabBar
        }
        .background(.clear)
        .ignoresSafeArea(edges: .bottom)
    }
    
    private var customTabBar: some View {
        HStack(spacing: 80) {
            ForEach(0..<tabs.count, id: \.self) { index in
                Button {
                    selectedTab = index
                } label: {
                    VStack(spacing: 4) {
                        Image(selectedTab == index ? selectedIcon(for: index) : icon(for: index))
                            .resizable()
                            .scaledToFit()
                            .frame(height: 36)
                        
                        Text(tabs[index])
                            .font(.system(size: 10, weight: .medium))
                            .foregroundStyle(.black)
                            .padding(.bottom, 10)
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 4)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .padding(.bottom, 5)
        .overlay(alignment: .top) {
            Rectangle()
                .frame(height: 2)
                .foregroundStyle(.secondary.opacity(0.2))
                .shadow(color: .secondary.opacity(0.4), radius: 1, y: -2)
        }
    }
    
    private func icon(for index: Int) -> String {
        switch index {
        case 0: return "tab1IconCI"
        case 1: return "tab2IconCI"
        case 2: return "tab3IconCI"
        default: return ""
        }
    }
    
    private func selectedIcon(for index: Int) -> String {
        switch index {
        case 0: return "tab1IconSelectedCI"
        case 1: return "tab2IconSelectedCI"
        case 2: return "tab3IconSelectedCI"
        default: return ""
        }
    }
}


#Preview {
    BBMenuContainer()
}
