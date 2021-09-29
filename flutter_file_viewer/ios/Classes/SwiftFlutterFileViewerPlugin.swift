import Flutter
import UIKit

public class SwiftFlutterFileViewerPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let factory = NativeViewFactory(messenger: registrar.messenger())
    registrar.register(factory, withId: "NativeView")
    // let channel = FlutterMethodChannel(name: "viewtypehere", binaryMessenger: registrar.messenger())
    // let instance = SwiftFlutterFileViewerPlugin()
    // registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    // if (call.method == "showPDF") {
    //   guard let args = call.arguments else { return }
    //   if let args = args as? String {
        
    //   }

    //   //show viewcontroller here for the pdf
    //   // result.success()
    // } else {
    //   // result.notImplemented()
    // }
    // result(call)
    // print(call)
    result("iOS " + UIDevice.current.systemVersion)
  // }
}
}

class NativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }
    
    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return NativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }
}
