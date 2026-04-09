//
//  CIRunsView.swift
//  Cold Ice
//
//

import SwiftUI

enum AppRoute: Hashable {
    case newRun
    case smartGear(Run)
    case runDetails(Run)
}

struct CIRunsView: View {
    @ObservedObject var viewModel: CIRunsViewModel
    @State private var path: [AppRoute] = []
    var body: some View {
        
        NavigationStack(path: $path) {
            VStack(spacing: 0) {
                VStack {
                    Text("Cold&Ice")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.buttonBlue)
                    
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.secondary.opacity(0.2))
                        .shadow(color: .secondary.opacity(0.4), radius: 1, y: 2)
                }
                
                Text("Recent Runs")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 24)
                    .padding(.top, 24)
                
                
                if viewModel.runs.isEmpty {
                    VStack {
                        Spacer()
                        Image(.snowIconCI)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 36)
                        
                        Text("No runs recorded yet")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.black)
                        
                        Text("Tap 'New Run' to start your season diary.")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.secondary)
                        Spacer()
                        
                    }
                    .padding(.horizontal, 24)
                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(viewModel.runs, id: \.id) { run in
                                HStack(spacing: 10) {
                                    if let image = run.image {
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 120, height: 100)
                                            .clipped()
                                            
                                            
                                    } else {
                                        Rectangle()
                                            .foregroundStyle(.secondaryGray.opacity(0.5))
                                            .frame(width: 120, height: 100)
                                            .overlay {
                                                Image(systemName: "camera")
                                            }
                                    }
                                    
                                    VStack {
                                        HStack(spacing: 4) {
                                            Image(systemName: "calendar")
                                                .font(.system(size: 12, weight: .regular))
                                                .foregroundStyle(.secondaryGray)
                                            
                                            Text("\(formattedDate(run.date)) \(formattedTime(run.time))")
                                                .font(.system(size: 8, weight: .regular))
                                                .foregroundStyle(.secondaryGray)
                                            
                                            Spacer()
                                            
                                            Text(run.rideStyle.rideStyle.text)
                                                .font(.system(size: 8, weight: .regular))
                                                .foregroundStyle(.buttonBlue)
                                                .padding(.vertical, 2)
                                                .padding(.horizontal, 6)
                                                .background(.buttonBlue.opacity(0.1))
                                                .clipShape(RoundedRectangle(cornerRadius: 30))
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 30)
                                                        .stroke(lineWidth: 1)
                                                        .foregroundStyle(.buttonBlue)
                                                }
                                        }
                                        
                                        Text(run.location)
                                            .font(.system(size: 14, weight: .semibold))
                                            .foregroundStyle(.black)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .frame(maxHeight: .infinity, alignment: .center)
                                        
                                        HStack {
                                            Image(uiImage: run.conditions.snowType.icon)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 14)
                                            
                                            Text("\(run.conditions.snowType.text) • \(run.conditions.temperature)°C • \(run.rideStyle.equipment.text)")
                                                .font(.system(size: 12, weight: .regular))
                                                .foregroundStyle(.secondaryGray)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                    }
                                    .padding(.trailing, 12)
                                    .padding(.vertical, 12)
                                }
                                .frame(height: 100)
                                .frame(maxWidth: .infinity)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .shadow(color: .buttonBlue.opacity(0.25), radius: 2, y: 2)
                                .onTapGesture {
                                    path.append(.runDetails(run))
                                }
                            }
                            
                        }
                        .padding(24)
                        .padding(.bottom, 150)
                        
                    }
                }
                
                
            }
            
            .overlay(alignment: .bottom) {
                Button {
                    path.append(.newRun)
                } label: {
                    Text("+ New Run")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 14)
                        .background(.buttonBlue)
                        .clipShape(RoundedRectangle(cornerRadius: 70))
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 50)
            }
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .newRun:
                    CINewRunView(path: $path)
                        .navigationBarBackButtonHidden()
                    
                case .smartGear(let run):
                    SmartGearView(run: run, path: $path, viewModel: viewModel)
                        .navigationBarBackButtonHidden()
                case .runDetails(let run):
                    CIRunDetailsView(run: run, path: $path, viewModel: viewModel)
                        .navigationBarBackButtonHidden()
                }
            }
        }
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: date)
    }

    func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: date)
    }
    
}

#Preview {
    CIRunsView(viewModel: CIRunsViewModel())
}
