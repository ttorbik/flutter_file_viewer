#import "FlutterFileViewerPlugin.h"
#if __has_include(<flutter_file_viewer/flutter_file_viewer-Swift.h>)
#import <flutter_file_viewer/flutter_file_viewer-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_file_viewer-Swift.h"
#endif

@implementation FlutterFileViewerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterFileViewerPlugin registerWithRegistrar:registrar];
}
@end
