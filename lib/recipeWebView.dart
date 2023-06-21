import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class RecipeWebView extends StatefulWidget {

  String recipeUrl;
  RecipeWebView(this.recipeUrl);

  @override
  State<RecipeWebView> createState() => _RecipeWebViewState();
}

class _RecipeWebViewState extends State<RecipeWebView> {

  //https
  late String securedUrl;

  var isLoading;

  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    isLoading = true;

    if (widget.recipeUrl.toString().contains("http://")){
      securedUrl = widget.recipeUrl.toString().replaceAll("http://","https://");
    }
    else{
      securedUrl = widget.recipeUrl;
    }

    controller = WebViewController()..loadRequest(Uri.parse(securedUrl))..setJavaScriptMode(JavaScriptMode.unrestricted);
    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: isLoading ? Center(child: CircularProgressIndicator()) : WebViewWidget(
          controller: controller,
        )


        // WebView(
        //   initialUrl: securedUrl,
        //   javascriptMode: JavascriptMode.unrestricted,
        // ),
      )

    );
  }
}
