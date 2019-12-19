import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:you_token/first_page/tabsPage.dart';

class FirstPage extends StatefulWidget {
  _FirstPge createState() => _FirstPge();
}

class _FirstPge extends State<FirstPage> {
  var address =
      '0xe5bd47a9d44477682b9f1bcc61c961bd94c2ca8424f3548f1f7b49733cc24331';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '钱包',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: Icon(
            Icons.format_align_center,
            color: Colors.black,
          ),
          actions: <Widget>[
            Icon(
              Icons.center_focus_weak,
              color: Colors.black,
            )
          ],
          elevation: 0.0,
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 200.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/images/head_bg.jpg')),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 25.0, left: 15.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 100.0,
                              child: Text(
                                'ETH-Wallet',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17.0),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 190.0,
                            ),
                            Container(
                              width: 75.0,
                              child: Icon(
                                Icons.more_horiz,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 15.0,top: 8.0),
                        //width: 190.0,
                        child: Row(
                          children: <Widget>[
                            Text(address.substring(0, 10), style: TextStyle(color: Colors.white),),
                            Text('...', style: TextStyle(color: Colors.white),),
                            Text(address.substring(address.length-10, address.length), style: TextStyle(color: Colors.white),),
                            Icon(Icons.apps, color: Colors.white, size: 15.0)
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width-100.0, top: 70.0),
                    child: Row(
                      children: <Widget>[
                        Text('￥', style: TextStyle(color: Colors.white, fontSize: 20.0),),
                        SizedBox(width: 5.0,),
                        Text('0.00', style: TextStyle(color: Colors.white, fontSize: 20.0),)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 300.0,
              child: TabsDemo(),
            )
          ],
        ),
      ),
    );
  }
}


