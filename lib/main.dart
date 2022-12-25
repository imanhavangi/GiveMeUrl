import 'package:flutter/material.dart';
import 'package:givemeurl/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'آدرس یاب',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'آدرس یاب'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // phone and username controllers
  final phoneController = TextEditingController();
  final usernameController = TextEditingController();
  String link = '';
  // future
  late Future<Link> futureLink;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // SizedBox(
            //   height: 10,
            // ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                width: 300,
                child: TextField(
                  controller: usernameController,
                  // textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'نام کاربری',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                width: 300,
                child: TextField(
                  controller: phoneController,
                  // textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'شماره همراه یا ایمیل',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Services.createUserLogin(
                        phoneController.text, usernameController.text)
                    .then((value) => {
                          if (value.status == 'success')
                            {
                              setState(() {
                                link = value.link;
                              }),
                            }
                          else
                            {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Text(
                                        value.message,
                                        textDirection: TextDirection.rtl,
                                      ),
                                      backgroundColor: Colors.red))
                            }
                        });
              },
              child: const Text('جستجو'),
            ),
            SizedBox(
              height: 20,
            ),
            // Text Button for get link
            link != ''
                ? TextButton(
                    onPressed: () {
                      launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication);
                      // futureLink = Services.createUserLogin(
                      //     phoneController.text, usernameController.text);
                      // setState(() {});
                    },
                    child: Text(link),

                  )
                : Container(),
          ]),
        ),
      ),
      // body: Container(
      //     height: 300,
      //     width: 400,
      //     child: WebView(initialUrl: 'http://givemedomain.xyz/')),
      // body: Container(
      //     child: WebView(
      //         initialUrl:
      //             'https://sdfsdfhwefnokd.ladesk.com/scripts/generateWidget.php?v=5.35.3.12&t=1671875064&cwid=xed81cl0&cwrt=C&cwt=chat_mobile&vid=zz94i7o97lqrdxusi57awy7gztlow&ud=%7B%7D&pt=&ref=https%3A%2F%2Fsdfsdfhwefnokd.ladesk.com%2Fcontactwidgettest%2Fpreview.php%3Fcwid%3Dxed81cl0%26type%3DC')),
      //       body: Center(
      //         child: Container(
      //           color: Colors.red,
      //           height: 700,
      //           width: 400,
      //           child: Html(data: '''
      // <!DOCTYPE html>
      // <html>
      // <head>
      // <meta charset="utf-8">
      // <meta name="viewport" content="width=device-width, initial-scale=1.0">
      // <title>1</title>

      // </head>
      // <body>
      // <p>1</p>
      //     <script type="text/javascript"> (function(d, src, c) { var t=d.scripts[d.scripts.length - 1],s=d.createElement('script');s.id='la_x2s6df8d';s.async=true;s.src=src;s.onload=s.onreadystatechange=function(){var rs=this.readyState;if(rs&&(rs!='complete')&&(rs!='loaded')){return;}c(this);};t.parentElement.insertBefore(s,t.nextSibling);})(document, 'https://tehranbet.ladesk.com/scripts/track.js', function(e){ LiveAgent.createButton('837ejlt8', e); }); </script>
      // </body>
      // </html>'''),
      //         ),
      //       ),
    );
  }
}
