//
//  CINewTrickView.swift
//  Cold Ice
//
//

import SwiftUI

struct CINewTrickView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: CIRunsViewModel
    
    @State private var name = ""
    @State private var selectedCategory: TrickCategory = .spins
    @State private var difficulty: Difficulty = .one
    @State private var description = ""
    
    var body: some View {
        VStack(spacing: 0) {
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
                    
                    Text("New Trick")
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
                        textFiled(title: "Trick Name *") {
                            HStack {
                                
                                TextField("e.g., Double Cork 1080", text: $name)
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
                        
                        textFiled(title: "Category *") {
                            
                            Menu {
                                ForEach(TrickCategory.allCases, id: \.self) { category in
                                    Button {
                                        selectedCategory = category
                                    } label: {
                                        HStack {
                                            Text(category.text)
                                            
                                            if selectedCategory == category {
                                                Image(systemName: "checkmark")
                                            }
                                        }
                                    }
                                }
                            } label: {
                                HStack {
                                    Text(selectedCategory.text)
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.buttonBlue)
                                }
                                .padding()
                                .overlay {
                                    RoundedRectangle(cornerRadius: 24)
                                        .stroke(lineWidth: 1)
                                        .foregroundStyle(.black.opacity(0.5))
                                }
                            }
                        }
                        
                        textFiled(title: "Difficulty") {
                            HStack {
                                ForEach(Difficulty.allCases, id: \.self) { difficulty in
                                    
                                    Image(difficulty.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 15)
                                        .padding(.vertical, 9)
                                        .padding(.horizontal, 16)
                                        .background(self.difficulty == difficulty ? .buttonBlue : .clear)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(lineWidth: 1)
                                                .foregroundStyle(.secondaryGray.opacity(0.2))
                                        }
                                        .onTapGesture {
                                            self.difficulty = difficulty
                                        }
                                    
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                        }
                        
                        textFiled(title: "Description (Optional)") {
                            HStack {
                                
                                TextField("Short description of the technique...", text: $description)
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
                }
                .padding(24)
            }
            
            Button {
                
                let trick = Trick(name: name, category: selectedCategory, difficulty: difficulty, description: description, status: .learning, notes: "")
                viewModel.add(trick)
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
}

#Preview {
    CINewTrickView(viewModel: CIRunsViewModel())
}
