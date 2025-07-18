//
//  GridViews.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 17/7/2568 BE.
//

import SwiftUI

struct GridViews: View {
    @State private var items: [Int] = Array(0..<30)
    @State private var isRefresh = false
    @State private var isLoading = false
    
    var basicGrid: some View {
        Grid(alignment: .top,
             horizontalSpacing: 20,
             verticalSpacing: 50) {
            GridRow {
                Text("(0, 0)")
                Text("(1, 0)")
                Text("(2, 0)")
            }.background(Color.red)
                .frame(width: 100)
            
            GridRow {
                Text("(0, 1)")
                Text("(1, 1)")
                Text("(2, 1)")
            }.background(Color.blue)
                .gridCellAnchor(.bottom)
            
            Divider()
                .gridCellUnsizedAxes(.horizontal)
            
            GridRow {
                Text("(0, 2)")
                Text("(1, 2)")
                Text("(2, 2)")
            }.background(Color.green)
            
            //            GridRow {
            //                Text("Footer")
            //            }.gridCellColumns(3)
            Text("Footer")
        }
    }
    
    var lazyGrid: some View {
        ScrollView {
            if isRefresh {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .transition(.opacity)
            }
            
            LazyVGrid(columns: [
                GridItem(.fixed(100),
                         spacing: 10,
                         alignment: .leading),
                GridItem(.flexible(minimum: 50, maximum: .infinity),
                         spacing: 10,
                         alignment: .leading),
                GridItem(.flexible(minimum: 50, maximum: .infinity),
                         spacing: 10,
                         alignment: .leading),
            ]) {
                ForEach(items, id: \.self) { col in
                    Text("\(col)")
                        .frame(height: 100)
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.2))
                        .border(Color.gray)
                        .onAppear {
                            if col == items.last {
                                Task {
                                    await fetchMoreItems()
                                }
                            }
                        }
                }
                
                if isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .transition(.opacity)
                }
            }
            .padding(20)
            .animation(.easeInOut, value: isLoading)
        }
        .refreshable {
            if isRefresh == false {                
                await refreshItems()
            }
        }
    }
    
    func fetchMoreItems() async {
        guard !isLoading else { return }
        isLoading = true
        try? await Task.sleep(nanoseconds: 1_000_000_000) // Simulate network delay
        let next = items.count..<(items.count + 20)
        await MainActor.run {
            items.append(contentsOf: next)
            isLoading = false
        }
    }
    
    
    func refreshItems() async {
        isRefresh = true
        try? await Task.sleep(nanoseconds: 1_000_000_000) // Simulate refresh delay
        await MainActor.run {
            items = Array(0..<30)
            isRefresh = false
        }
    }
    
    var body: some View {
        lazyGrid
    }
}

#Preview {
    GridViews()
}
