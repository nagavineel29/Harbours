//
//  ContentView.swift
//  Harbours
//
//  Created by naga vineel golla on 2/21/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ContentViewModel = ContentViewModel()

    var body: some View {
        VStack {
            Text(Constants.title)
                .font(.largeTitle)
                .bold()
            
            Spacer()
            
            if !viewModel.showingDimensionsSheet, viewModel.rows != 0, viewModel.columns != 0 {
                Grid() {
                    ForEach(0 ..< viewModel.rows, id: \.self) { row in
                        GridRow {
                            ForEach(0 ..< viewModel.columns, id: \.self) { column in
                                TextField("", value: Binding(
                                    get: { if viewModel.matrixVals[row].count > column { return viewModel.matrixVals[row][column] } else { return 0 }},
                                    set: { (newValue) in return viewModel.matrixVals[row][column] = newValue}
                                ), format: .number)
                                .keyboardType(.numberPad)
                                .id(UUID())
                            }
                        }
                    }
                }
                .frame(alignment: .center)
            }
            
            Spacer()
            
            if !viewModel.matrixVals.isEmpty {
                Button(Constants.calculate) {
                    viewModel.Calculate()
                }
                
                VStack {
                    if let path = viewModel.result.path, let cost = viewModel.result.cost {
                        cost < 51 ? Text(Constants.yes) : Text(Constants.no)
                        
                        Text("\(cost)")
                        
                        Text(path.map { String($0) }.joined(separator: ", "))
                            .padding()
                    }
                }
            }
            
            Button(Constants.enterDimensions) {
                viewModel.showingDimensionsSheet.toggle()
            }
            .sheet(isPresented: $viewModel.showingDimensionsSheet) {
                        VStack{
                            HStack{
                                Text(Constants.dimensions)
                                    .font(.title)
                            }
                            HStack{
                                Text(Constants.rows)
                                TextField(Constants.numberOfRows, value: $viewModel.rows, format: .number)
                                    .onChange(of: viewModel.rows ) { newValue in
                                        if newValue > Constants.maximumLength {
                                            viewModel.rows = Constants.maximumLength
                                        }
                                    }
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .padding()
                            }
                            HStack{
                                Text(Constants.columns)
                                TextField(Constants.numberOfColumns, value: $viewModel.columns, format: .number)
                                    .onChange(of: viewModel.columns ) { newValue in
                                        if newValue > Constants.maximumLength {
                                            viewModel.columns = Constants.maximumLength
                                        }
                                    }
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .padding()
                            }
                            
                            Button(Constants.done) {
                                viewModel.initializeMatrix()
                                viewModel.showingDimensionsSheet.toggle()
                                viewModel.result = (nil,nil)
                            }
                            .buttonStyle(.bordered)
                        }
                        .frame(alignment: .center)
                        .presentationDetents([.height(250)])
                        
                    }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
