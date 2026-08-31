//
//  ContentView.swift
//  boringNotchApp
//
//  Created by Harsh Vardhan Goswami  on 02/08/24
//  Modified by Richard Kunkli on 24/08/2024.
//
//  Stripped down to only render the inline system HUD (volume/brightness/etc).
//

import Combine
import Defaults
import SwiftUI

@MainActor
struct ContentView: View {
    @EnvironmentObject var vm: BoringViewModel
    @ObservedObject var coordinator = BoringViewCoordinator.shared
    @State private var isHovering: Bool = false
    @State private var gestureProgress: CGFloat = .zero

    private var currentNotchShape: NotchShape {
        NotchShape(
            topCornerRadius: cornerRadiusInsets.closed.top,
            bottomCornerRadius: cornerRadiusInsets.closed.bottom
        )
    }

    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                NotchLayout()
                    .frame(alignment: .top)
                    .padding(.horizontal, cornerRadiusInsets.closed.bottom)
                    .background(.black)
                    .clipShape(currentNotchShape)
                    .overlay(alignment: .top) {
                        Rectangle()
                            .fill(.black)
                            .frame(height: 1)
                            .padding(.horizontal, cornerRadiusInsets.closed.top)
                    }
            }
        }
        .padding(.bottom, 8)
        .frame(maxWidth: windowSize.width, maxHeight: windowSize.height, alignment: .top)
        .compositingGroup()
        .preferredColorScheme(.dark)
        .environmentObject(vm)
    }

    @ViewBuilder
    func NotchLayout() -> some View {
        VStack(alignment: .leading) {
            if coordinator.sneakPeek.show && (coordinator.sneakPeek.type != .music) && (coordinator.sneakPeek.type != .battery) {
                InlineHUD(
                    type: $coordinator.sneakPeek.type,
                    value: $coordinator.sneakPeek.value,
                    icon: $coordinator.sneakPeek.icon,
                    hoverAnimation: $isHovering,
                    gestureProgress: $gestureProgress
                )
                .transition(.opacity)
            } else {
                Rectangle().fill(.clear).frame(width: vm.closedNotchSize.width - 20, height: vm.effectiveClosedNotchHeight)
            }
        }
        .fixedSize()
    }
}

#Preview {
    let vm = BoringViewModel()
    return ContentView()
        .environmentObject(vm)
        .frame(width: vm.notchSize.width, height: vm.notchSize.height)
}
