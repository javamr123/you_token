import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:you_token/first_page/firstPage.dart';
import 'package:you_token/second_page/SecondPage.dart';
import 'package:you_token/third_page/ThirdPage.dart';
import 'package:you_token/fourth_page/FourthPage.dart';

class Navigation extends StatefulWidget{
  _Navigation createState() => _Navigation();
}

class _Navigation extends State<Navigation>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTextStyle(
        style: CupertinoTheme.of(context).textTheme.textStyle,
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.folder_open),
                title: Text('钱包'),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                title: Text('交易'),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.search),
                title: Text('市场'),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.profile_circled),
                title: Text('我的'),
              ),
            ],
          ),
          tabBuilder: (BuildContext context, int index) {
            assert(index >= 0 && index <= 3);
            switch (index) {
              case 0:
                return CupertinoTabView(
                  builder: (BuildContext context) => FirstPage(),
                );
                break;
              case 1:
                return CupertinoTabView(
                  builder: (BuildContext context) => SecondPage(),
                );
                break;
              case 2:
                return CupertinoTabView(
                  builder: (BuildContext context) => ThirdPage(),
                );
                break;
              case 3:
                return CupertinoTabView(
                  builder: (BuildContext context) => FourthPage(),
                );
                break;
            }
            return null;
          },
        ),
      ),
    );
  }
}