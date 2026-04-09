//
//  CINewRunView.swift
//  Cold Ice
//
//

import SwiftUI

struct CINewRunView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var path: [AppRoute]
    
    @State private var location = ""
    @State private var date: Date = Date.now
    @State private var time: Date = Date.now
    @State private var temperature: Double = 0
    @State private var snowType: SnowType = .powder
    @State private var windType: WindType = .calm
    @State private var visibilityType: VisibilityType = .sunny
    @State private var equipmentType: EquipmentType = .ski
    @State private var rideType: RideType = .park
    @State private var memories = ""
    
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    
    private let columns = [
            GridItem(.flexible(), spacing: 12),
            GridItem(.flexible(), spacing: 12)
        ]

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
                    
                    Text("New Run")
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
            
            ScrollView(showsIndicators: false) {
                VStack {
                    VStack(spacing: 20) {
                        textFiled(title: "LOCATION *") {
                            HStack {
                                Image(.locationIconCI)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 20)
                                
                                TextField("e.g., Krasnaya Polyana, Sheregesh", text: $location)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(.black)
                                
                            }
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(lineWidth: 1)
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                        }
                        
                        textFiled(title: "DATE *") {
                            HStack(alignment: .center) {
                                DatePicker(
                                    "",
                                    selection: $date,
                                    displayedComponents: .date
                                ).labelsHidden()
                                    .tint(.buttonBlue)
                                
                                Spacer()
                                
                                Image(.dateIconCI)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 20)
                            }
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(lineWidth: 1)
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                        }
                        
                        textFiled(title: "TIME *") {
                            HStack(alignment: .center) {
                                DatePicker(
                                    "",
                                    selection: $time,
                                    displayedComponents: .hourAndMinute
                                ).labelsHidden()
                                    .tint(.buttonBlue)
                                
                                Spacer()
                                
                                Image(.timeIconCI)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 20)
                            }
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(lineWidth: 1)
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                        }
                        
                        textFiled(title: "Conditions *") {
                            
                            VStack(spacing: 20) {
                                VStack(spacing: 10) {
                                    HStack {
                                        Text("Temperature")
                                            .font(.system(size: 14, weight: .semibold))
                                            .textCase(.uppercase)
                                            .foregroundColor(.secondaryGray)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        Text("\(Int(temperature))°C")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(.buttonBlue)
                                    }
                                    
                                    Slider(value: $temperature, in: -30...30, step: 1)
                                    
                                    HStack {
                                        Text("-30°")
                                        Spacer()
                                        Text("0°")
                                        Spacer()
                                        Text("+30°")
                                    }
                                    .font(.system(size: 10, weight: .regular))
                                    .foregroundColor(.secondaryGray)
                                }
                                
                                VStack {
                                    Text("Snow Type")
                                        .font(.system(size: 14, weight: .semibold))
                                        .textCase(.uppercase)
                                        .foregroundColor(.secondaryGray)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    HStack {
                                        ForEach(SnowType.allCases, id: \.self) { snowType in
                                            
                                            VStack {
                                                Image(uiImage: snowType.icon)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: 20)
                                                
                                                Text(snowType.text)
                                                    .font(.system(size: 9, weight: .semibold))
                                                    .foregroundColor( self.snowType == snowType ? .buttonBlue : .secondaryGray)
                                            }
                                            .padding(10)
                                            .frame(maxWidth: .infinity)
                                            .background(
                                                self.snowType == snowType ? .buttonBlue.opacity(0.1) : .clear
                                            )
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(lineWidth: 1)
                                                    .foregroundStyle(self.snowType == snowType ? .buttonBlue : .secondary)
                                            }
                                            .onTapGesture {
                                                self.snowType = snowType
                                            }
                                            
                                        }
                                    }
                                }
                                
                                VStack {
                                    Text("Wind")
                                        .font(.system(size: 14, weight: .semibold))
                                        .textCase(.uppercase)
                                        .foregroundColor(.secondaryGray)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    HStack(spacing: 0) {
                                        ForEach(Array(WindType.allCases.enumerated()), id: \.element.rawValue) { index, item in
                                            Button {
                                                withAnimation(.easeInOut(duration: 0.2)) {
                                                    windType = item
                                                }
                                            } label: {
                                                Text(item.text)
                                                    .font(.system(size: 10, weight: .regular))
                                                    .foregroundColor(windType == item ? .white : .black)
                                                    .frame(maxWidth: .infinity)
                                                    .padding(12)
                                                    .background {
                                                        if windType == item {
                                                            RoundedRectangle(cornerRadius: 7)
                                                                .fill(Color.blue)
                                                                .padding(4)
                                                        }
                                                    }
                                            }
                                            .buttonStyle(.plain)
                                            
                                            if index < WindType.allCases.count - 1 {
                                                Rectangle()
                                                    .fill(Color.black.opacity(0.15))
                                                    .frame(width: 1)
                                                    .opacity(shouldShowDivider(after: index) ? 1 : 0)
                                                    .padding(.vertical, 4)
                                            }
                                        }
                                    }
                                    .background(Color(.systemGray5))
                                    .clipShape(RoundedRectangle(cornerRadius: 7))
                                }
                                
                                VStack {
                                    Text("Visibility")
                                        .font(.system(size: 14, weight: .semibold))
                                        .textCase(.uppercase)
                                        .foregroundColor(.secondaryGray)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    HStack(spacing: 0) {
                                        ForEach(Array(VisibilityType.allCases.enumerated()), id: \.element.rawValue) { index, item in
                                            Button {
                                                withAnimation(.easeInOut(duration: 0.2)) {
                                                    visibilityType = item
                                                }
                                            } label: {
                                                Text(item.text)
                                                    .font(.system(size: 10, weight: .regular))
                                                    .foregroundColor(visibilityType == item ? .white : .black)
                                                    .frame(maxWidth: .infinity)
                                                    .padding(12)
                                                    .background {
                                                        if visibilityType == item {
                                                            RoundedRectangle(cornerRadius: 7)
                                                                .fill(Color.blue)
                                                                .padding(4)
                                                        }
                                                    }
                                            }
                                            .buttonStyle(.plain)
                                            
                                            if index < VisibilityType.allCases.count - 1 {
                                                Rectangle()
                                                    .fill(Color.black.opacity(0.15))
                                                    .frame(width: 1)
                                                    .opacity(shouldShowDividerVisibility(after: index) ? 1 : 0)
                                                    .padding(.vertical, 4)
                                            }
                                        }
                                    }
                                    .background(Color(.systemGray5))
                                    .clipShape(RoundedRectangle(cornerRadius: 7))
                                }
                            }
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(lineWidth: 1)
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                        }
                        
                        textFiled(title: "Ride Style *") {
                            VStack {
                                HStack(spacing: 0) {
                                    ForEach(EquipmentType.allCases, id: \.self) { equipment in
                                        Button {
                                            withAnimation(.easeInOut(duration: 0.2)) {
                                                self.equipmentType = equipment
                                            }
                                        } label: {
                                            Text(equipment.text)
                                                .font(.system(size: 10, weight: .regular))
                                                .foregroundColor(equipmentType == equipment ? .white : .black)
                                                .frame(maxWidth: .infinity)
                                                .padding(12)
                                                .background {
                                                    if equipmentType == equipment {
                                                        RoundedRectangle(cornerRadius: 7)
                                                            .fill(Color.blue)
                                                            .padding(4)
                                                    }
                                                }
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                                .background(Color(.systemGray5))
                                .clipShape(RoundedRectangle(cornerRadius: 7))
                                
                                LazyVGrid(columns: columns, spacing: 8) {
                                    ForEach(RideType.allCases, id: \.rawValue) { item in
                                        Button {
                                            withAnimation(.easeInOut(duration: 0.2)) {
                                                rideType = item
                                            }
                                        } label: {
                                            Text(item.text)
                                                .font(.system(size: 10, weight: .semibold))
                                                .foregroundColor(rideType == item ? .white : .black)
                                                .frame(maxWidth: .infinity)
                                                .padding(.vertical, 10)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .fill(rideType == item ? Color.blue : Color(.systemGray5))
                                                )
                                        }
                                        .buttonStyle(.plain)
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
                        
                        textFiled(title: "Memories") {
                            HStack {
                                
                                TextField("What was memorable about this run?", text: $memories)
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundStyle(.black)
                            }
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(lineWidth: 1)
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                        }
                        
                        VStack {
                            HStack {
                                Button {
                                    isShowingImagePicker = true
                                } label: {
                                    HStack(spacing: 0) {
                                        Image(systemName: "camera")
                                            .foregroundStyle(.buttonBlue)
                                            .bold()
                                        
                                        Text("Add Photo")
                                            .font(.system(size: 14, weight: .semibold))
                                            .foregroundStyle(.buttonBlue)
                                    }
                                }
                                
                                HStack(spacing: 4) {
                                    
                                    Image(systemName: "exclamationmark.circle")
                                        .foregroundStyle(.secondaryGray)
                                    
                                    Text("Local storage only")
                                        .font(.system(size: 12, weight: .regular))
                                        .foregroundStyle(.secondaryGray)
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            
                            if let image = selectedImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 60)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(lineWidth: 1)
                                            .foregroundStyle(.buttonBlue)
                                    }
                                    .overlay(alignment: .topTrailing) {
                                        Button {
                                            selectedImage = nil
                                        } label: {
                                            ZStack {
                                                Circle()
                                                    .frame(width: 13, height: 13)
                                                    .cornerRadius(12)
                                                    .foregroundColor(.red)
                                                Image(systemName: "xmark")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 8, weight: .semibold))
                                            }
                                        }
                                        .offset(x: 6, y: -6)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 1)
                                .foregroundStyle(.black.opacity(0.5))
                        }
                        
                        Button {
                            let run = Run(
                                location: location,
                                date: date,
                                time: time,
                                conditions:
                                    Condition(
                                        temperature: "\(temperature)",
                                        snowType: snowType,
                                        wind: windType,
                                        visibylity: visibilityType
                                    ),
                                rideStyle:
                                    RideStyle(
                                    equipment: equipmentType,
                                    rideStyle: rideType
                                ),
                                memories: memories,
                                imageData: selectedImage?.jpegData(compressionQuality: 0.8)
                            )
                            path.append(.smartGear(run))
                        } label: {
                            Text("Next")
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
                }
                .padding(24)
                .padding(.bottom, 150)
                .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                    ImagePicker(selectedImage: $selectedImage, isPresented: $isShowingImagePicker)
                }
            }
        }
    }
    
    func loadImage() {
        if let selectedImage = selectedImage {
            print("Selected image size: \(selectedImage.size)")
        }
    }
    
    @ViewBuilder func textFiled<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 8)  {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.secondaryGray)
            
            content()
        }
    }
    
    private func shouldShowDivider(after index: Int) -> Bool {
        let items = WindType.allCases
        let leftItem = items[index]
        let rightItem = items[index + 1]
        return windType != leftItem && windType != rightItem
    }
    
    private func shouldShowDividerVisibility(after index: Int) -> Bool {
        let items = VisibilityType.allCases
        let leftItem = items[index]
        let rightItem = items[index + 1]
        return visibilityType != leftItem && visibilityType != rightItem
    }
}

#Preview {
    CINewRunView(path: .constant([]))
}
