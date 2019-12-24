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
  _Page(label: '资产'): <_CardData>[
    _CardData(
      name: 'ETH',
      enable: 0,
      disable: 0,
      amount: 0,
    ),

  ],
  _Page(label: '收藏'): <_CardData>[
    _CardData(
      name: 'ETH',
      enable: 0,
      disable: 0,
      amount: 0,
    ),
  ]
};

class _CardDataItem extends StatelessWidget {
  const _CardDataItem({this.page, this.data});

  final _Page page;
  final _CardData data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
        child: Container(
          height: 50.0,
          child: Row(
            children: <Widget>[
              Container(
                child: Image(image: AssetImage('lib/images/eth.jpg')),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0),
                child: Text('ETH', style: TextStyle(fontSize: 20.0),),
              ),
              SizedBox(width: MediaQuery.of(context).size.width-220.0,),
              Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: Text('0'),
                    ),
                    Row(
                      children: <Widget>[
                        Text('￥'),
                        Text('0.00')
                      ],
                    )
                  ],
                )
            ],
          ),
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
                            itemExtent: 65.0,
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
