//
//  WebContentView.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 6/4/22.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    @State var url = "https://www.amazon.com"
    func makeUIView(context: UIViewRepresentableContext<WebView>) -> WebView.UIViewType {
        WKWebView(frame: .zero)
    }

    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        let request = URLRequest(url: URL(string: url)!)
        uiView.load(request)
    }

}

struct WebContentView: View {
    @State var url = "https://www.amazon.com"
    var body: some View {
        WebView(url: url)
    }
}

struct WebContentView_Previews: PreviewProvider {
    static var previews: some View {
        WebContentView(url: "https://www.amazon.com")
    }
}
