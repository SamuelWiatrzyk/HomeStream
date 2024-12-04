//
//  CategoryRow.swift
//  NetflixApp
//
//  Created by Samuel Wiatrzyk on 2023-07-25.
//
import SwiftUI

struct CategoryRow: View {
    var categoryName: String
    var items: [Equipment]
    
    @State private var currentIndex = 0
    @State private var isAutoScrolling = true
    @State private var tappedIndex: Int? = nil
    @AppStorage("hapticOn") var hapticOn = true
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .soft) // Soft impact haptic feedback

    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            ScrollViewReader { scrollView in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(items.indices, id: \.self) { index in
                            NavigationLink(destination: EquipmentDetail(equipment: items[index]), isActive: Binding<Bool>(
                                get: { tappedIndex == index },
                                set: { newValue in
                                    if newValue == false {
                                        tappedIndex = nil
                                    }
                                }
                            )) {
                                CategoryItem(equipment: items[index])
                                    .frame(width: 200, height: 300)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                    .id(index)
                                    .scaleEffect(index == currentIndex ? 1.02 : 1) // Scale effect when selected
                                    .gesture(
                                        TapGesture()
                                            .onEnded { _ in
                                                // Trigger haptic feedback on tap
                                                if hapticOn == true {
                                                    feedbackGenerator.prepare() // Prepare the generator before the gesture
                                                    feedbackGenerator.impactOccurred() // Perform the haptic feedback
                                                }
                                                    
                                                if index == currentIndex && tappedIndex == nil {
                                                    tappedIndex = index
                                                } else {
                                                    currentIndex = index
                                                    tappedIndex = nil
                                                }
                                            }
                                    )
                            }
                            .opacity(index == currentIndex ? 1 : 0.5)
                            .animation(.easeInOut(duration: 0.2))
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .onAppear {
            feedbackGenerator.prepare() // Prepare the feedback generator when the view appears
        }
    }

    private func stopAutoScrolling() {
        isAutoScrolling = false
    }

    private func findNearestIndex(for tappedIndex: Int, tapRadius: CGFloat = 400) -> Int {
        let tapX = CGFloat(tappedIndex) * (200 + 20) + 100 // X coordinate of tap in scroll view
        var nearestIndex = 0
        var minDistance = CGFloat.infinity
    
        for index in items.indices {
            let centerX = CGFloat(index) * (200 + 20) + 100 // X coordinate of center of item
            let distance = abs(centerX - tapX)
            
            // If the tap is within the tapRadius, consider it a valid tap for this index
            if distance <= tapRadius && distance < minDistance {
                minDistance = distance
                nearestIndex = index
            }
        }
        
        return nearestIndex
    }

}
