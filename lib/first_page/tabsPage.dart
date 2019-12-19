import 'package:flutter/material.dart';

class _Page {
  _Page({this.label});

  final String label;

  String get id => label[0];

  @override
  String toString() => '$runtimeType("$label")';
}

class _CardData {
  _CardData({this.name, this.enable, this.disable, this.amount});

  final String name;
  int enable;
  int disable;
  int amount;
}

final Map<_Page, List<_CardData>> _allPages = <_Page, List<_CardData>>{
  _Page(label: '资产账户'): <_CardData>[
    /*_CardData(
      name: "BTC",
      enable: '4.000000',
      disable: '0.00000',
      amount: '0.00000',
    ),
    _CardData(
      name: 'ETH',
      enable: '3.000000',
      disable: '0.00000',
      amount: '0.00000',
    ),*/
    _CardData(
      name: 'G A',
      enable: 0,
      disable: 0,
      amount: 0,
    ),
    /* _CardData(
      name: 'GABC',
      enable: 0,
      disable: 0,
      amount: 0,
    )*/
  ],
  _Page(label: '释放账户'): <_CardData>[
    _CardData(
      name: 'G A',
      enable: 0,
      disable: 0,
      amount: 0,
    ),
    /* _CardData(
      name: 'GABC',
       enable: 0,
       disable: 0,
       amount: 0,
    ),*/
  ],
};

class _CardDataItem extends StatelessWidget {
  const _CardDataItem({this.page, this.data});

  final _Page page;
  final _CardData data;

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    final size = MediaQuery
        .of(context)
        .size;
    final width = size.width;

    return GestureDetector(
      onTap: () {},
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: Text(
                  data.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 230.0),
                  child: Icon(
                    Icons.chevron_right,
                    color: Color.fromRGBO(190, 204, 214, 0.8),
                  ),
                  alignment: Alignment.topRight,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            children: <Widget>[
              Container(
                width: width / 3,
                padding: EdgeInsets.only(top: 5.0),
                child: Text('可用',
                    style: TextStyle(
                      color: Colors.grey,
                    )),
              ),
              Container(
                width: width / 3,
                padding: EdgeInsets.only(top: 5.0),
                child: Text('冻结',
                    style: TextStyle(
                      color: Colors.grey,
                    )),
              ),
              Container(
                padding: EdgeInsets.only(top: 5.0),
                child: Text('折合(CNY)',
                    style: TextStyle(
                      color: Colors.grey,
                    )),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                width: width / 3,
                padding: EdgeInsets.only(top: 5.0),
                child: Text("${data.enable}"),
              ),
              Container(
                width: width / 3,
                padding: EdgeInsets.only(top: 5.0),
                child: Text("${data.disable}"),
              ),
              Container(
                padding: EdgeInsets.only(top: 5.0),
                child: Text("${data.amount}"),
              ),
            ],
          ),
          Divider(
            color: Color.fromRGBO(186, 191, 195, 0.5),
          ),
        ],
      ),
    );
  }
}

class TabsDemo extends StatefulWidget {
  @override
  _TabsDemo createState() => _TabsDemo();
}

class _TabsDemo extends State<TabsDemo> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _allPages.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: SliverAppBar(
                  leading: Text(''),
                  primary: false,
                  pinned: true,
                  expandedHeight: kMinInteractiveSize,
                  backgroundColor: Colors.white10,
                  flexibleSpace: TabBar(
                    tabs: _allPages.keys.map<Widget>((_Page page) => Tab(text: page.label),).toList(),
                    labelColor: Colors.black,
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: _allPages.keys.map<Widget>((_Page page) {
              return SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      key: PageStorageKey<_Page>(page),
                      slivers: <Widget>[
                        SliverOverlapInjector(
                          handle:
                          NestedScrollView.sliverOverlapAbsorberHandleFor(
                              context),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16.0,
                          ),
                          sliver: SliverFixedExtentList(
                            itemExtent: 100.0,
                            delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                final _CardData data = _allPages[page][index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 3.0,
                                  ),
                                  child: _CardDataItem(
                                    page: page,
                                    data: data,
                                  ),
                                );
                              },
                              childCount: _allPages[page].length,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
