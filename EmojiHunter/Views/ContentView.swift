//
//  ContentView.swift
//  EmojiHunter
//
//  Created by H A on 07/11/2026.
//
import SwiftUI

struct ContentView: View {
    @State private var viewModel = GameViewModel()

    private var showNextScreen: Bool {
        (viewModel.showNext || viewModel.emojiStatus == .found)
            && viewModel.emojiStatus != .gameOver
    }

    var body: some View {
        ZStack {
            // MARK: Level 1 – NEXT screen or live camera
            if showNextScreen {
                Color.black
                    .ignoresSafeArea()

                Button {
                    viewModel.startSearch()
                } label: {
                    Text("NEXT")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.green, in: RoundedRectangle(cornerRadius: 10))
                }
            } else {
                // The $ creates a Binding (a two-way connection) to the view model's emojiStatus,
                // so the camera's Coordinator can write .found back into our state.
                CustomCameraRepresentable(
                    emojiString: emojiObjects[viewModel.currentLevel].emojiName,
                    emojiFound: $viewModel.emojiStatus
                )
                .ignoresSafeArea()
            }

            // MARK: Level 2 – messages at the bottom of the screen
            VStack(spacing: 12) {
                Spacer()

                if viewModel.emojiStatus == .gameOver {
                    Button {
                        viewModel.restartGame()
                    } label: {
                        Text("GAME OVER\nTap to restart")
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 14)
                            .background(Color.red, in: RoundedRectangle(cornerRadius: 10))
                    }
                } else {
                    if viewModel.emojiStatus == .searching {
                        Text("\(viewModel.timeRemaining)")
                            .font(.system(size: 60, weight: .heavy, design: .rounded))
                            .foregroundStyle(.yellow)
                            .shadow(color: .black.opacity(0.6), radius: 4)
                            .onReceive(viewModel.timer) { _ in
                                viewModel.adjustTime()
                            }
                    }

                    viewModel.emojiResultText()
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.6), radius: 4)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .padding(.horizontal)
                }
            }
            .padding(.bottom, 30)
        }
        .preferredColorScheme(.dark)
        .statusBarHidden()
    }
}

#Preview {
    ContentView()
}
