//
//  CITricksView.swift
//  Cold Ice
//
//

import SwiftUI

struct CITricksView: View {
    @ObservedObject var viewModel: CIRunsViewModel
    @State private var selectedCategory: TrickCategory? = nil
    
    private var filteredTricks: [Trick] {
        guard let selectedCategory else { return viewModel.tricks }
        return viewModel.tricks.filter { $0.category == selectedCategory }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                HStack {
                    
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20)
                        .opacity(0)
                    
                    Text("Tricks Library")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.buttonBlue)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    NavigationLink {
                        CINewTrickView(viewModel: viewModel)
                            .navigationBarBackButtonHidden()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 20)
                            .foregroundStyle(.buttonBlue)
                    }
                    
                    
                }.padding(.horizontal, 24)
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(.secondary.opacity(0.2))
                    .shadow(color: .secondary.opacity(0.4), radius: 1, y: 2)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 25) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            Button {
                                selectedCategory = nil
                            } label: {
                                HStack {
                                    Text("All")
                                        .font(.system(size: 15, weight: .medium))
                                        .foregroundStyle(selectedCategory == nil ? .white: .secondaryGray)
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 16)
                                        .background(selectedCategory == nil ? .buttonBlue : .clear)
                                        .clipShape(RoundedRectangle(cornerRadius: 40))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 40)
                                                .stroke(lineWidth: 1)
                                                .foregroundStyle(.secondaryGray.opacity(0.2))
                                        }
                                    
                                }
                            }
                            
                            ForEach(TrickCategory.allCases, id: \.self) { category in
                                Text(category.text)
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundStyle(self.selectedCategory == category ? .white: .secondaryGray)
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 16)
                                    .background(self.selectedCategory == category ? .buttonBlue : .clear)
                                    .clipShape(RoundedRectangle(cornerRadius: 40))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 40)
                                            .stroke(lineWidth: 1)
                                            .foregroundStyle(.secondaryGray.opacity(0.2))
                                    }
                                    .onTapGesture {
                                        self.selectedCategory = category
                                    }
                            }
                        }
                        .padding(.horizontal, 24)
                    }.padding(.horizontal, -24)
                    
                    if viewModel.tricks.isEmpty {
                        VStack {
                            
                            Text("No tricks recorded yet")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.black)
                            
                            Text("Tap '+' to add your first trick.")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(.secondary)
                            
                        }
                        .padding(.top, 150)
                    } else {
                        VStack(spacing: 12) {
                            ForEach(filteredTricks, id: \.id) { trick in
                                NavigationLink {
                                    CITricksDetailsView(viewModel: viewModel, trick: trick)
                                        .navigationBarBackButtonHidden()
                                } label: {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 8) {
                                            VStack(alignment: .leading, spacing: 4) {
                                                Text(trick.name)
                                                    .font(.system(size: 16, weight: .bold))
                                                    .foregroundColor(.black)
                                                
                                                Text(trick.category.text)
                                                    .font(.system(size: 13))
                                                    .foregroundColor(.secondaryGray)
                                            }
                                            
                                            HStack {
                                                Text(trick.status.text)
                                                    .font(.system(size: 10, weight: .medium))
                                                    .foregroundStyle(trick.status.color)
                                                    .padding(.vertical, 5)
                                                    .padding(.horizontal, 16)
                                                    .background(trick.status.color.opacity(0.1))
                                                    .clipShape(RoundedRectangle(cornerRadius: 40))
                                                    .overlay {
                                                        RoundedRectangle(cornerRadius: 40)
                                                            .stroke(lineWidth: 1)
                                                            .foregroundStyle(trick.status.color)
                                                    }
                                                
                                                Text("\(trick.success)/\(trick.progress) Success")
                                                    .font(.system(size: 10, weight: .medium))
                                                    .foregroundStyle(.secondaryGray)
                                                    .padding(.vertical, 5)
                                                    .padding(.horizontal, 16)
                                                    .background(.secondaryGray.opacity(0.1))
                                                    .clipShape(RoundedRectangle(cornerRadius: 40))
                                                    .overlay {
                                                        RoundedRectangle(cornerRadius: 40)
                                                            .stroke(lineWidth: 0.5)
                                                            .foregroundStyle(.secondaryGray)
                                                    }
                                            }
                                            
                                            Text("\"\(trick.notes)\"")
                                                .font(.system(size: 10, weight: .regular))
                                                .foregroundColor(.secondaryGray)
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
                                }
                            }
                        }
                    }
                }
                .padding(24)
                .padding(.bottom, 150)
            }
                
                
        }
        
    }
}

#Preview {
    CITricksView(viewModel: CIRunsViewModel())
}
