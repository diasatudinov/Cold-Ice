//
//  CIRunDetailsView.swift
//  Cold Ice
//
//

import SwiftUI

struct CIRunDetailsView: View {
    let run: Run
    @Binding var path: [AppRoute]
    @ObservedObject var viewModel: CIRunsViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                HStack {
                    Button {
                        path.removeLast()
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 14)
                            .bold()
                    }
                    
                    Text("Run Details")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.buttonBlue)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Button {
                        viewModel.delete(run)
                        path.removeLast()
                    } label: {
                        Image(systemName: "trash")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 19)
                            .foregroundStyle(.red)
                    }
                }.padding(.horizontal, 24)
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(.secondary.opacity(0.2))
                    .shadow(color: .secondary.opacity(0.4), radius: 1, y: 2)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 12) {
                    HStack(spacing: 4) {
                        Image(.locationIconCI)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 24)
                        
                        Text(run.location)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(.buttonBlue)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(run.rideStyle.rideStyle.text)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.buttonBlue)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 12)
                            .background(.buttonBlue.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .overlay {
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(lineWidth: 1)
                                    .foregroundStyle(.buttonBlue)
                            }
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "calendar")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.secondaryGray)
                        
                        Text("\(formattedDate(run.date)) • \(formattedTime(run.time))")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.secondaryGray)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(spacing: 12) {
                        VStack(spacing: 16) {
                            HStack(spacing: 4) {
                                VStack(alignment: .leading) {
                                    Text("Snow")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundStyle(.secondaryGray)
                                        .textCase(.uppercase)
                                    
                                    HStack(spacing: 4) {
                                        Image(uiImage: run.conditions.snowType.icon)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 14)
                                        
                                        Text("\(run.conditions.snowType.text)")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundStyle(.black)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                VStack(alignment: .leading) {
                                    Text("Temp")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundStyle(.secondaryGray)
                                        .textCase(.uppercase)
                                    
                                    HStack(spacing: 4) {
                                        Image(.tempIconCI)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 14)
                                        
                                        Text("\(run.conditions.temperature)°C")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundStyle(.black)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            HStack(spacing: 4) {
                                VStack(alignment: .leading) {
                                    Text("Wind")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundStyle(.secondaryGray)
                                        .textCase(.uppercase)
                                    
                                    HStack(spacing: 4) {
                                        Image(.windIconCI)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 14)
                                        
                                        Text("\(run.conditions.wind.text)")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundStyle(.black)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                VStack(alignment: .leading) {
                                    Text("Visibility")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundStyle(.secondaryGray)
                                        .textCase(.uppercase)
                                    
                                    HStack(spacing: 4) {
                                        Image(.eyeIconCI)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 14)
                                        
                                        Text("\(run.conditions.visibylity.text)")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundStyle(.black)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        
                        Rectangle()
                            .frame(height: 0.5)
                            .foregroundStyle(.secondaryGray)
                        
                        VStack(alignment: .leading) {
                            Text("Board Type")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.secondaryGray)
                                .textCase(.uppercase)
                            
                            HStack(spacing: 4) {
                                Image(.boardIconCI)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 14)
                                
                                Text("\(run.rideStyle.equipment.text)")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(.black)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                    
                    .overlay {
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(lineWidth: 1)
                            .foregroundStyle(.black.opacity(0.5))
                    }
                    
                    VStack {
                        Text("Notes & Impressions")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.secondaryGray)
                            .textCase(.uppercase)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack {
                            Text(run.memories)
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(.black)
                                .textCase(.uppercase)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(lineWidth: 1)
                                .foregroundStyle(.black.opacity(0.5))
                        }
                    }
                    
                    VStack {
                        Text("Required & Recommended")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.secondaryGray)
                            .textCase(.uppercase)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack {
                            if run.equipment.isEmpty {
                                Text("Equipments are empty")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundStyle(.secondaryGray)
                                    .frame(maxWidth: .infinity, alignment: .center)
                            } else {
                                VStack(spacing: 12) {
                                    ForEach(run.equipment) { item in
                                        GearRow(item: item)
                                    }
                                }
                                
                            }
                        }
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(lineWidth: 1)
                                .foregroundStyle(.black.opacity(0.5))
                        }
                    }
                }
                .padding(24)
                .padding(.bottom, 150)
            }
        }
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d, yyyy"
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
    CIRunDetailsView(run: Run(location: "Sheregesh", date: .now, time: .now, conditions: Condition(temperature: "-15", snowType: .artificial, wind: .calm, visibylity: .cloudy), rideStyle: RideStyle(equipment: .ski, rideStyle: .park), memories: "The weather was nice"), path: .constant([]), viewModel: CIRunsViewModel())
}
