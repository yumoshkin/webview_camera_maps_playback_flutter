import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import 'package:flutter_app_webview/widgets/action_bar.dart';
import 'package:flutter_app_webview/widgets/url_textfield.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final WebViewController _controller;
  final _urlController = TextEditingController(text: 'https://flutter.dev');
  var _isLoading = false;
  var _canGoForward = false;
  var _canGoBack = false;

  @override
  void initState() {
    super.initState();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) async {
            _isLoading = false;
            _canGoForward = await _controller.canGoForward();
            _canGoBack = await _controller.canGoBack();
            setState(() {});
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(_urlController.text));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  void goForward() {
    _controller.goForward();
  }

  void goBack() async {
    _controller.goBack();
  }

  void reload() async {
    final url = _urlController.text.trim();
    if (url.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      await _controller.loadRequest(Uri.parse(url));
    }
  }

  void stop() {
    _controller.goBack();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        // bottom: ActionBar(),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 56),
            child: WebViewWidget(controller: _controller),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ActionBar(
                  goForward: goForward,
                  goBack: goBack,
                  reload: reload,
                  stop: stop,
                  isLoading: _isLoading,
                  canGoForward: _canGoForward,
                  canGoBack: _canGoBack),
              UrlTextField(controller: _urlController),
            ],
          ),
        ],
      ),
    );
  }
}
