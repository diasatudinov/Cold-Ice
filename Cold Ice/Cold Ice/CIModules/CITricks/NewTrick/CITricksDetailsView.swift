//
//  CITricksDetailsView.swift
//  Cold Ice
//
//

import SwiftUI

struct CITricksDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: CIRunsViewModel
    let trick: Trick
    
    @State private var notes = ""
    @State private var status: TrickStatus = .learning
    @State private var progress = 0
    @State private var success = 0
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 14)
                            .bold()
                    }
                    
                    Text("Tricks Library")
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
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(trick.name)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.black)
                            
                            Text(trick.category.text)
                                .font(.system(size: 13))
                                .foregroundColor(.secondaryGray)
                            
                            Text(trick.description)
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(trick.difficulty.image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 12)
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 4, y: 1)
                    
                    textFiled(title: "Status") {
                        HStack(spacing: 0) {
                            ForEach(Array(TrickStatus.allCases.enumerated()), id: \.element.rawValue) { index, item in
                                Button {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        status = item
                                    }
                                } label: {
                                    Text(item.text)
                                        .font(.system(size: 10, weight: .regular))
                                        .foregroundColor(status == item ? .white : .black)
                                        .frame(maxWidth: .infinity)
                                        .padding(12)
                                        .background {
                                            if status == item {
                                                RoundedRectangle(cornerRadius: 7)
                                                    .fill(Color.blue)
                                                    .padding(4)
                                            } else {
                                                RoundedRectangle(cornerRadius: 7)
                                                    .fill(Color.clear)
                                                    .padding(4)
                                            }
                                        }
                                }
                                .buttonStyle(.plain)
                                
                                if index < TrickStatus.allCases.count - 1 {
                                    Rectangle()
                                        .fill(Color.black.opacity(0.15))
                                        .frame(width: 1)
                                        .opacity(shouldShowDividerStatus(after: index) ? 1 : 0)
                                        .padding(.vertical, 4)
                                }
                            }
                        }
                        .background(Color(.systemGray5).opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 7))

                    }
                    
                    textFiled(title: "Progress Tracker") {
                        
                        VStack {
                            HStack {
                                
                                Text("Progress Tracker")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundStyle(.black)
                                
                                HStack {
                                    Button {
                                        if progress > 0 {
                                            progress -= 1
                                        }
                                    } label: {
                                       Image(systemName: "minus.circle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 21)
                                            .foregroundStyle(.red)
                                    }
                                    
                                    Text("\(progress)")
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundStyle(.black)
                                    
                                    Button {
                                        progress += 1
                                        
                                    } label: {
                                       Image(systemName: "plus.circle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 21)
                                            .foregroundStyle(.buttonBlue)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            
                            HStack {
                                
                                Text("Successful Landings")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundStyle(.buttonBlue)
                                
                                HStack {
                                    Button {
                                        if success > 0 {
                                            success -= 1
                                        }
                                    } label: {
                                       Image(systemName: "minus.circle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 21)
                                            .foregroundStyle(.red)
                                    }
                                    
                                    Text("\(success)")
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundStyle(.buttonBlue)
                                    
                                    Button {
                                        success += 1
                                        
                                    } label: {
                                       Image(systemName: "plus.circle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 21)
                                            .foregroundStyle(.buttonBlue)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(radius: 4, y: 1)
                    }
                    
                    textFiled(title: "Notes") {
                        HStack {
                            
                            TextField("e.g. Needs more rotation, fear on takeoff...", text: $notes)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(.black)
                            
                        }
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 1)
                                .foregroundStyle(.black.opacity(0.5))
                        }
                    }
                    
                }
                .padding(24)
            }
            
            Button {
                viewModel.edit(trick, status: status, progress: progress, success: success, notes: notes)
                
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Save")
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
            .padding(24)
        }
        .onAppear {
            self.status = trick.status
            self.progress = trick.progress
            self.success = trick.success
            self.notes = trick.notes
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
                .textCase(.uppercase)
            
            content()
        }
    }
    
    private func shouldShowDividerStatus(after index: Int) -> Bool {
        let items = TrickStatus.allCases
        let leftItem = items[index]
        let rightItem = items[index + 1]
        return status != leftItem && status != rightItem
    }
}

#Preview {
    CITricksDetailsView(viewModel: CIRunsViewModel(), trick:
                            Trick(
                                name: "180 Frontside",
                                category: .butters,
                                difficulty: .one,
                                description: "Half turn front facing",
                                status: .dropped,
                                notes: ""
                            )
    )
}
