import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:you_token/other/city_picker.dart';
import 'dart:convert';

class SecondPage extends StatefulWidget {
  _SecondPage createState() => _SecondPage();
}

class _SecondPage extends State<SecondPage> {
  String area = '北京';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.home),
          title: Text('北京租房'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 30.0,
              color: Color.fromRGBO(244, 244, 244, 1.0),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      CityPicker.showCityPicker(
                        context,
                        selectProvince: (province) {
                          print(province);
                        },
                        selectCity: (city) {
                          print(city);
                        },
                        selectArea: (area2) {
                          //   print(area2);
                          print(area2['name']);
                          setState(() {
                            area = area2['name'];
                          });
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 15.0,right: 2.0),
                      child: Row(
                        children: <Widget>[
                          Text('$area'),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ),
                  ),
                  Container(width: 1.0,height: 20.0,color: Colors.black12,),
                  Container(
                    width: MediaQuery.of(context).size.width*0.7,
                    child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 1.0),
                          icon: Icon(Icons.search,color: Colors.black38,),
                          hintStyle: TextStyle(),
                          hintText: '输入城区/商圈/小区名查房价',
                          border: InputBorder.none
                        )
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
