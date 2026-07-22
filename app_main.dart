import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF0A2540),
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const NoonApp());
}

class NoonApp extends StatelessWidget {
  const NoonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noon Report Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0A2540),
        useMaterial3: true,
      ),
      home: const WebShell(),
    );
  }
}

class WebShell extends StatefulWidget {
  const WebShell({super.key});

  @override
  State<WebShell> createState() => _WebShellState();
}

class _WebShellState extends State<WebShell> {
  late final WebViewController _controller;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFF0A2540))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            if (mounted) setState(() => _loading = false);
          },
        ),
      )
      ..loadFlutterAsset('assets/index.html');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A2540),
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_loading)
              const Center(
                child: CircularProgressIndicator(color: Color(0xFFFBBF24)),
              ),
          ],
        ),
      ),
    );
  }
}
