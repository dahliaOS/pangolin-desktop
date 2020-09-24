import 'dart:ffi';
import 'package:Pangolin/window/xlib_binding.dart';

WindowManager windowManager;

void initWindowManager() {
  Pointer<XDisplay> display = XOpenDisplay(Pointer.fromAddress(0));
  print("Display Information: ");
  print(" * Size: "+XDisplayWidth(display, 0).toString()+"x"+XDisplayHeight(display, 0).toString());
  int screens = XScreenCount(display);
  print(" * Total Screens: "+screens.toString());
  while(screens > 0) {
    Screen screen = XScreenOfDisplay(display, screens-1).ref;
    print("Screen #"+screens.toString()+":");
    print(" * Size: "+screen.width.toString()+"x"+screen.height.toString());
    screens--;
  }
  windowManager = WindowManager(display); // Create a new constructor
}

class WindowManager {
  Pointer<XDisplay> _display;
  int _root;
  static bool _wmAlreadyLoaded;

  WindowManager(this._display) {
    if(_display == Pointer.fromAddress(0)) {
      print("Pangolin Window Service: Unable to connect to default X display");
      _root = XDefaultRootWindow(_display);
    }
  }

  static int onXError(XDisplay display, XErrorEvent errorEvent) {
    return 0;
  }

  static int onWMDetected(Pointer<XDisplay> display, Pointer<XErrorEvent> errorEvent) {
    if(errorEvent.ref.error_code == 10) {
      _wmAlreadyLoaded = true;
    }
    return 0;
  }

  void run() {
    _wmAlreadyLoaded = false;
    XSetErrorHandler(onWMDetected);
    XSelectInput(_display, _root, XCB_EVENT_MASK_SUBSTRUCTURE_REDIRECT | XCB_EVENT_MASK_SUBSTRUCTURE_NOTIFY);
    XSync(_display, 0);
    if(_wmAlreadyLoaded) {
      print(XDisplayString(_display).toString() + " was already running.");
    }

    while(true) {
      int _event;
      Pointer<Int32> _mDisplayAddress;
      Pointer<Int32> _mEvent;
      _mDisplayAddress.value = _display.address;
      _mEvent.value = _event;
      XNextEvent(_mDisplayAddress, _mEvent);
      print(_event.toString());
    }
  }
}