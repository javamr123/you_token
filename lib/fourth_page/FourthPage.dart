import 'package:flutter/material.dart';

class FourthPage extends StatefulWidget {
  _FourthPage createState() => _FourthPage();
}

class _FourthPage extends State<FourthPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              height: 200.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage('lib/images/bg.jpg')),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 40.0),
                    height: 60.0,
                    width: 60.0,
                    child: CircleAvatar(
                      radius: 36.0,
                      backgroundImage: NetworkImage(
                          'https://c-ssl.duitang.com/uploads/item/201702/23/20170223093051_Jy8XP.thumb.700_0.jpeg'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Text(
                      '小赵同学',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    width: 81.0,
                    height: 28.0,
                    child: OutlineButton(
                      padding: EdgeInsets.all(5.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      disabledBorderColor: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Text(
                            '订阅邮件',
                            style:
                                TextStyle(color: Colors.white, fontSize: 13.0),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                            size: 19.0,
                          )
                        ],
                      ),
                      onPressed: () {
                        print('aa');
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 55.0,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: OutlineButton.icon(
                      disabledBorderColor: Colors.white,
                      onPressed: null,
                      icon: Icon(
                        Icons.library_books,
                        size: 18.0,
                      ),
                      label: Text('地址本'),
                    ),
                  ),
                  Expanded(
                    child: OutlineButton.icon(
                      disabledBorderColor: Colors.white,
                      onPressed: null,
                      icon: Icon(
                        Icons.message,
                        size: 18.0,
                      ),
                      label: Text('消息中心'),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 20.0,
              color: Color.fromRGBO(245, 245, 245, 1.0),
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text('管理钱包'),
              trailing: Icon(Icons.chevron_right),
            ),
            Container(
              height: 20.0,
              color: Color.fromRGBO(245, 245, 245, 1.0),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('使用设置'),
              trailing: Icon(Icons.chevron_right),
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.2),
                  width: MediaQuery.of(context).size.width*0.8,
                  color: Colors.black12,
                  height: 1.0,
                )
              ],
            ),
            ListTile(
              leading: Icon(Icons.help_outline),
              title: Text('帮助与反馈'),
              trailing: Icon(Icons.chevron_right),
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.2),
                  width: MediaQuery.of(context).size.width*0.8,
                  color: Colors.black12,
                  height: 1.0,
                )
              ],
            ),
            ListTile(
              leading: Icon(Icons.warning),
              title: Text('用户协议'),
              trailing: Icon(Icons.chevron_right),
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.2),
                  width: MediaQuery.of(context).size.width*0.8,
                  color: Colors.black12,
                  height: 1.0,
                )
              ],
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('关于我们'),
              trailing: Icon(Icons.chevron_right),
            ),
          ],
        ),
      ),
    );
  }
}
