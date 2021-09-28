//
//  PDFController.swift
//  flutter_file_viewer
//
//  Created by Thomas Torbik on 9/28/21.
//

import Foundation

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
        guard let isLocalFile = data["isLocalFile"] else { return }
        
        print(url)
        print(fileType)
        print(isLocalFile)
        
        // iOS views can be created here
        createPDFView(view: _view)
    }

    func view() -> UIView {
        return _view
    }

    func createPDFView(view _view: UIView){
        _view.backgroundColor = UIColor.blue
        let nativeLabel = UILabel()
        nativeLabel.text = "Native text from iOS"
        nativeLabel.textColor = UIColor.white
        nativeLabel.textAlignment = .center
        nativeLabel.frame = CGRect(x: 0, y: 0, width: 180, height: 48.0)
        _view.addSubview(nativeLabel)
    }
}
