//
//  NativeViewController.swift
//  flutter_file_viewer
//
//  Created by Thomas Torbik on 9/28/21.
//

import Foundation
import PDFKit
import WebKit

class NativeView: NSObject, FlutterPlatformView {
    private var _view: UIView

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
        super.init()
        
        guard let data = args as? [String: Any] else {
            return //return error message here
        }
        
        guard let url = data["url"] as? String else { return }
        guard let fileType = data["fileType"] as? String else { return }
        guard let isLocalFile = data["isLocalFile"] as? Bool else { return }
        
        print(url)
        print(fileType)
        print(isLocalFile)
        
        switch fileType {
        case "PDF":
            if isLocalFile {
                createLocalPDFView(view: _view, path: url)
            } else {
                createWebPDFView(view: _view, path: url)
            }
        default:
            return
        }
    }

    func view() -> UIView {
        return _view
    }
    
    //this works
    func createWebPDFView(view _view: UIView, path: String) {
        let webview = WKWebView(frame: UIScreen.main.bounds)
        _view.addSubview(webview)
        webview.leadingAnchor.constraint(equalTo: _view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        webview.trailingAnchor.constraint(equalTo: _view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        webview.topAnchor.constraint(equalTo: _view.safeAreaLayoutGuide.topAnchor).isActive = true
        webview.bottomAnchor.constraint(equalTo: _view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        webview.load(URLRequest(url: URL(string: path)!))
    }
    
    func createLocalPDFView(view _view: UIView, path: String) {
        let pdfView = PDFView()
        
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        _view.addSubview(pdfView)

        pdfView.leadingAnchor.constraint(equalTo: _view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: _view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: _view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: _view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        pdfView.backgroundColor = .red
        guard let path = Bundle.main.url(forResource: "TestPDF", withExtension: "pdf") else { return }

        if let document = PDFDocument(url: path) {
            pdfView.document = document
        }
    }
}


//class WebPDFController: UIViewController {
//
//    var url: String?
//
//    init(url: String) {
//        self.url = url
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        self.view.backgroundColor = .green
//        let label = UILabel()
//        label.text = url
//
//        self.view.addSubview(label)
//    }
//}
