//
//  WebView.swift
//  SimpleBrowser
//
//  Created by H A on 28/09/2026.
//

import SwiftUI
import WebKit
import Combine

struct WebView: UIViewRepresentable {
    @ObservedObject var viewModel: ViewModel

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        var webViewOptionsSubscriber: AnyCancellable?

        init(webView: WebView) {
            self.parent = webView
        }

        deinit {
            webViewOptionsSubscriber?.cancel()
        }

        func webView(
            _ webView: WKWebView,
            didStartProvisionalNavigation navigation: WKNavigation?
        ) {
            webViewOptionsSubscriber =
                parent.viewModel.webViewOptionsPublisher.sink { webViewOption in
                    switch webViewOption {
                    case .back:
                        if webView.canGoBack {
                            webView.goBack()
                        }
                    case .forward:
                        if webView.canGoForward {
                            webView.goForward()
                        }
                    case .share:
                        self.parent.viewModel.shouldShowShareSheet = true
                    case .refresh:
                        webView.reload()
                    case .stop:
                        webView.stopLoading()
                    }
                }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(webView: self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        if let url = URL(string: "https://\(viewModel.urlString)") {
            webView.load(URLRequest(url: url))
        }
    }
}
