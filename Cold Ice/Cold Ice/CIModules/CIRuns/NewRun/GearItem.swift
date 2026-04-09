//
//  GearItem.swift
//  Cold Ice
//
//

import SwiftUI

struct GearItem: Codable, Identifiable, Equatable, Hashable {
    enum Kind: Codable {
        case required
        case recommended
    }
    
    let id = UUID()
    let title: String
    let subtitle: String?
    let icon: String
    let kind: Kind
    var isChecked: Bool
    let isCustom: Bool
    
    init(
        title: String,
        subtitle: String? = nil,
        icon: String,
        kind: Kind,
        isChecked: Bool = false,
        isCustom: Bool = false
    ) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.kind = kind
        self.isChecked = isChecked
        self.isCustom = isCustom
    }
}

struct SmartGearView: View {
    let run: Run
    @Binding var path: [AppRoute]
    @ObservedObject var viewModel: CIRunsViewModel
    
    @State private var customGearText = ""
    @State private var gearItems: [GearItem]
    
    init(run: Run, path: Binding<[AppRoute]>, viewModel: CIRunsViewModel) {
        self.run = run
        self._path = path
        self.viewModel = viewModel
        self._gearItems = State(initialValue: SmartGearView.buildGear(for: .freeride))
    }
    
    private var checkedCount: Int {
        gearItems.filter(\.isChecked).count
    }
    
    private var totalCount: Int {
        gearItems.count
    }
    
    private var progress: Double {
        guard totalCount > 0 else { return 0 }
        return Double(checkedCount) / Double(totalCount)
    }
    
    private var progressText: String {
        "Make sure you have everything you need"
    }
    
    private var progressTextColor: Color {
        checkedCount == totalCount ? .green : .red
    }
    
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
                    
                    Text("Smart Gear")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.buttonBlue)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 14)
                        .opacity(0)
                    
                }.padding(.horizontal, 24)
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(.secondary.opacity(0.2))
                    .shadow(color: .secondary.opacity(0.4), radius: 1, y: 2)
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    readinessBlock
                    
                    gearListBlock
                    
                    customGearBlock
                    
                    Button {
                        
                        var run = self.run
                        run.equipment = gearItems.filter({ $0.isChecked })
                        
                        viewModel.add(run)
                        path.removeAll()
                    } label: {
                        Text("Save Run")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .fill(Color.blue)
                            )
                    }
                    .buttonStyle(.plain)
                    .padding(.top, 4)
                }
                .padding(16)
                .padding(.bottom, 150)
            }
        }
    }
    
    private var readinessBlock: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .firstTextBaseline) {
                Text("Equipment Readiness")
                    .font(.system(size: 16, weight: .bold))
                
                Spacer()
                
                Text("\(checkedCount) / \(totalCount)")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.blue)
            }
            
            ProgressView(value: progress)
                .progressViewStyle(.linear)
                .tint(.blue)
                .scaleEffect(x: 1, y: 1.4, anchor: .center)
            if checkedCount == 0 {
                Text(progressText)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.red)
            } else {
                Text(progressText)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.clear)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.white)
        )
    }
    
    private var gearListBlock: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("REQUIRED & RECOMMENDED")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.secondary)
            
            VStack(spacing: 12) {
                ForEach(gearItems) { item in
                    GearRow(item: item)
                        .onTapGesture {
                            toggle(item)
                        }
                    
                }
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .stroke(Color.black.opacity(0.08), lineWidth: 1)
                    )
            )
        }
    }
    
    private var customGearBlock: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("ADD CUSTOM GEAR")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.secondary)
            
            HStack(spacing: 12) {
                TextField("e.g. GoPro, Snacks", text: $customGearText)
                    .font(.system(size: 17))
                    .padding(.horizontal, 16)
                    .frame(height: 56)
                    .background(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .stroke(Color.black.opacity(0.08), lineWidth: 1)
                            )
                    )
                
                Button {
                    addCustomGear()
                } label: {
                    Text("Add")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 132, height: 56)
                        .background(
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .fill(customGearText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? Color.gray.opacity(0.45) : Color.gray)
                        )
                }
                .buttonStyle(.plain)
                .disabled(customGearText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
    }
    
    private func toggle(_ item: GearItem) {
        guard let index = gearItems.firstIndex(where: { $0.id == item.id }) else { return }
        withAnimation(.easeInOut(duration: 0.2)) {
            gearItems[index].isChecked.toggle()
        }
    }
    
    private func addCustomGear() {
        let trimmed = customGearText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        
        withAnimation(.easeInOut(duration: 0.2)) {
            gearItems.append(
                GearItem(
                    title: trimmed,
                    icon: "🎒",
                    kind: .recommended,
                    isChecked: false,
                    isCustom: true
                )
            )
            customGearText = ""
        }
    }
    
    private static func buildGear(for rideType: RideType) -> [GearItem] {
        var items: [GearItem] = [
            GearItem(title: "Helmet", icon: "🪖", kind: .required),
            GearItem(title: "Goggles", icon: "🥽", kind: .required),
            GearItem(title: "Gloves", icon: "🧤", kind: .required),
            GearItem(title: "Thermal Underwear", icon: "🧦", kind: .required),
            GearItem(title: "Ski Boots", icon: "👢", kind: .recommended),
            GearItem(title: "Skis & Poles", icon: "🎿", kind: .recommended),
            GearItem(title: "Sunscreen", icon: "🧴", kind: .recommended),
            GearItem(title: "Buff / Balaclava", icon: "🧣", kind: .recommended)
        ]
        
        switch rideType {
        case .freeride:
            items += [
                GearItem(title: "Avalanche Beacon", subtitle: "Mandatory for freeride", icon: "📡", kind: .required),
                GearItem(title: "Probe", icon: "📏", kind: .required),
                GearItem(title: "Shovel", icon: "⛏️", kind: .required),
                GearItem(title: "Backpack", icon: "🎒", kind: .required)
            ]
            
        case .park:
            items += [
                GearItem(title: "Back Protector", subtitle: "Recommended for park riding", icon: "🛡️", kind: .recommended),
                GearItem(title: "Knee Pads", subtitle: "Useful for rails and falls", icon: "🦵", kind: .recommended),
                GearItem(title: "Wrist Guard Gloves", subtitle: "Extra hand protection", icon: "🥊", kind: .recommended)
            ]
            
        case .tricks:
            items += [
                GearItem(title: "Action Camera / Tripod", subtitle: "For filming tricks", icon: "📹", kind: .recommended),
                GearItem(title: "Back Protector", subtitle: "Extra protection for trick sessions", icon: "🛡️", kind: .recommended)
            ]
            
        case .piste:
            items += [
                GearItem(title: "Neck Warmer", subtitle: "Useful in windy weather", icon: "🧣", kind: .recommended),
                GearItem(title: "Spare Gloves", subtitle: "Optional backup pair", icon: "🧤", kind: .recommended)
            ]
        }
        
        return items
    }
}

struct GearRow: View {
    let item: GearItem
    
    private var borderColor: Color {
       Color.gray.opacity(0.4)
    }
    
    var body: some View {
            HStack(spacing: 0) {
                Text(item.icon)
                    .font(.system(size: 32))
                    .frame(width: 40)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(item.title)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black)
                    
                    if let subtitle = item.subtitle {
                        Text(subtitle)
                            .font(.system(size: 10))
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke(item.isChecked ? Color.blue : borderColor, lineWidth: 1.5)
                        .frame(width: 20, height: 20)
                    
                    if item.isChecked {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 20, height: 20)
                        
                        Image(systemName: "checkmark")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(Color(.white))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .stroke(Color.black.opacity(0.06), lineWidth: 1)
                    )
            )
    }
}

#Preview {
    NavigationStack {
        SmartGearView(run: Run(location: "", date: .now, time: .now, conditions: Condition(temperature: "", snowType: .artificial, wind: .calm, visibylity: .cloudy), rideStyle: RideStyle(equipment: .ski, rideStyle: .freeride), memories: ""), path: .constant([]), viewModel: CIRunsViewModel())
    }
}
