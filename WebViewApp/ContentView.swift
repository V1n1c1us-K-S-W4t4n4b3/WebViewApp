//
//  ContentView.swift
//  WebViewApp
//
//  Created by Usuario on 29/06/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    let url: String
    @Binding var goback: Bool
    @Binding var goForward: Bool
    
    func makeUIView(context: Context) -> WKWebView{
        let wb = WKWebView()
        
        if let myURL = URL(string: url), UIApplication.shared.canOpenURL(myURL) {
            let request = URLRequest(url: myURL)
            wb.load(request)
        }else{
            let message = "ERROR - URL malformed :\(url)"
            wb.loadHTMLString("<h1 style=\"font-size: 100px;\">\(message)</h1>", baseURL: nil)
        }
        
        return wb
    }
    
    func updateUIView(_ wb: WKWebView, context: Context) {
        if goback {
            wb.goBack()
            goback = false
        }else if goForward {
            wb.goForward()
            goForward = false
        }
    }
}

struct ContentView: View {
    
    @State private var isPresent = false
    @State private var isGoBack = false
    @State private var isGoForward = false
    
    var body: some View {
        VStack {
            Button("Abrir Site"){
                isPresent = true
            }
            .sheet(isPresented: $isPresent){
                VStack{
                    WebView(url: "https://github.com/V1n1c1us-K-S-W4t4n4b3",
                            goback: $isGoBack, goForward: $isGoForward)
                    
                    HStack{
                        Spacer()
                        
                        Button("Voltar"){
                            isGoBack = true
                            
                        }
                        
                        Spacer()
                        
                        Button("Avançar"){
                            isGoForward = true
                        }
                        
                        Spacer()
                    }
                }
                .navigationTitle("Site")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
