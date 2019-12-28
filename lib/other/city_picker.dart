import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

typedef void ChangeData(Map<String, dynamic> map);
typedef List<Widget> CreateWidgetList();

class CityPicker {
  static void showCityPicker(
    BuildContext context, {
    ChangeData selectProvince,
    ChangeData selectCity,
    ChangeData selectArea,
  }) {
    rootBundle.loadString('lib/other/province.json').then((v) {
      List data = json.decode(v);
      Navigator.push(
        context,
        new _CityPickerRoute(
            data: data,
            selectProvince: selectProvince,
            selectCity: selectCity,
            selectArea: selectArea,
            theme: Theme.of(context, shadowThemeOnly: true),
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel),
      );
    });
  }
}

class _CityPickerRoute<T> extends PopupRoute<T> {
  final ThemeData theme;
  final String barrierLabel;
  final List data;
  final ChangeData selectProvince;
  final ChangeData selectCity;
  final ChangeData selectArea;

  _CityPickerRoute({
    this.theme,
    this.barrierLabel,
    this.data,
    this.selectProvince,
    this.selectCity,
    this.selectArea,
  });

  @override
  Duration get transitionDuration => Duration(milliseconds: 2000);

  @override
  @override
  Color get barrierColor => Colors.black54;

  @override
  bool get barrierDismissible => true;

  AnimationController _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController =
        BottomSheet.createAnimationController(navigator.overlay);
    return _animationController;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    Widget bottomSheet = new MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: new _CityPickerWidget(
        route: this,
        data: data,
        selectProvince: selectProvince,
        selectCity: selectCity,
        selectArea: selectArea,
      ),
    );
    if (theme != null) {
      bottomSheet = new Theme(data: theme, child: bottomSheet);
    }
    return bottomSheet;
  }
}

class _CityPickerWidget extends StatefulWidget {
  final _CityPickerRoute route;
  final List data;
  final ChangeData selectProvince;
  final ChangeData selectCity;
  final ChangeData selectArea;

  _CityPickerWidget(
      {Key key,
      @required this.route,
      this.data,
      this.selectProvince,
      this.selectCity,
      this.selectArea});

  @override
  State createState() {
    return new _CityPickerState();
  }
}

class _CityPickerState extends State<_CityPickerWidget> {
  FixedExtentScrollController provinceController;
  FixedExtentScrollController cityController;
  FixedExtentScrollController areaController;
  int provinceIndex = 0, cityIndex = 0, areaIndex = 0;
  List province = new List();
  List city = new List();
  List area = new List();

  @override
  void initState() {
    super.initState();
    provinceController = new FixedExtentScrollController();
    cityController = new FixedExtentScrollController();
    areaController = new FixedExtentScrollController();
    setState(() {
      province = widget.data;
      city = widget.data[provinceIndex]['sub'];
      area = widget.data[provinceIndex]['sub'][cityIndex]['sub'];
    });
  }

  Widget _bottomView() {
    return new Container(
        width: double.infinity,
        color: Colors.white,
        child: new Column(
          children: <Widget>[
            new Expanded(
              child: new Row(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: new Text(
                      '取消',
                      style: new TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Map<String, dynamic> provinceMap = {
                        "code": province[provinceIndex]['code'],
                        "name": province[provinceIndex]['name']
                      };
                      Map<String, dynamic> cityMap = {
                        "code": province[provinceIndex]['sub'][cityIndex]
                            ['code'],
                        "name": province[provinceIndex]['sub'][cityIndex]
                            ['name']
                      };
                      Map<String, dynamic> areaMap = {
                        "code": province[provinceIndex]['sub'][cityIndex]['sub']
                            [areaIndex]['code'],
                        "name": province[provinceIndex]['sub'][cityIndex]['sub']
                            [areaIndex]['name']
                      };
                      if (widget.selectProvince != null) {
                        widget.selectProvince(provinceMap);
                      }
                      if (widget.selectCity != null) {
                        widget.selectCity(cityMap);
                      }
                      if (widget.selectArea != null) {
                        widget.selectArea(areaMap);
                      }
                      Navigator.pop(context);
                    },
                    child: new Text(
                      '确定',
                      style: new TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              flex: 1,
            ),
            new Row(
              children: <Widget>[
                new _MyCityPicker(
                  key: Key('province'),
                  controller: provinceController,
                  createWidgetList: () {
                    return province.map((v) {
                      return new Align(
                        child: new Text(
                          v['name'],
                          textScaleFactor: 1.2,
                          style: TextStyle(fontSize: 18.0),
                        ),
                        alignment: Alignment.centerLeft,
                      );
                    }).toList();
                  },
                  changed: (index) {
                    setState(() {
                      provinceIndex = index;
                      cityIndex = 0;
                      areaIndex = 0;
                      cityController.jumpToItem(0);
                      areaController.jumpToItem(0);
                      city = widget.data[provinceIndex]['sub'];
                      area =
                          widget.data[provinceIndex]['sub'][cityIndex]['sub'];
                    });
                  },
                ),
                new _MyCityPicker(
                  key: Key('city'),
                  controller: cityController,
                  createWidgetList: () {
                    return city.map((v) {
                      return new Align(
                        child: new Text(
                          v['name'],
                          textScaleFactor: 1.2,
                          style: TextStyle(fontSize: 18.0),
                        ),
                        alignment: Alignment.centerLeft,
                      );
                    }).toList();
                  },
                  changed: (index) {
                    setState(() {
                      cityIndex = index;
                      areaIndex = 0;
                      areaController.jumpToItem(0);
                      area =
                          widget.data[provinceIndex]['sub'][cityIndex]['sub'];
                    });
                  },
                ),
                new _MyCityPicker(
                  key: Key('area'),
                  controller: areaController,
                  createWidgetList: () {
                    return area.map((v) {
                      return new Align(
                        child: new Text(
                          v['name'],
                          textScaleFactor: 1.2,
                          style: TextStyle(fontSize: 18.0),
                        ),
                        alignment: Alignment.centerLeft,
                      );
                    }).toList();
                  },
                  changed: (index) {
                    setState(() {
                      areaIndex = index;
                    });
                  },
                ),
              ],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new AnimatedBuilder(
        animation: widget.route.animation,
        builder: (BuildContext context, Widget child) {
          return new ClipRect(
            child: new CustomSingleChildLayout(
              delegate: new _BottomPickerLayout(widget.route.animation.value),
              child: new GestureDetector(
                child: new Material(
                  color: Colors.transparent,
                  child: new Container(
                    width: double.infinity,
                    height: 260.0,
                    child: _bottomView(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MyCityPicker extends StatefulWidget {
  final CreateWidgetList createWidgetList;
  final Key key;
  final FixedExtentScrollController controller;
  final ValueChanged<int> changed;

  _MyCityPicker(
      {this.createWidgetList, this.key, this.controller, this.changed});

  @override
  State createState() {
    return new _MyCityPickerState();
  }
}

class _MyCityPickerState extends State<_MyCityPicker> {
  List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Container(
        padding: const EdgeInsets.all(6.0),
        alignment: Alignment.center,
        height: 220.0,
        child: CupertinoPicker(
          backgroundColor: Colors.white,
          scrollController: widget.controller,
          key: widget.key,
          itemExtent: 30.0,
          onSelectedItemChanged: (index) {
            if (widget.changed != null) {
              widget.changed(index);
            }
          },
          children: widget.createWidgetList().length > 0
              ? widget.createWidgetList()
              : [new Text('')],
        ),
      ),
      flex: 1,
    );
  }
}

class _BottomPickerLayout extends SingleChildLayoutDelegate {
  _BottomPickerLayout(this.progress, {this.itemCount, this.showTitleActions});

  final double progress;
  final int itemCount;
  final bool showTitleActions;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double maxHeight = 300.0;

    return new BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: 0.0,
      maxHeight: maxHeight,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double height = size.height - childSize.height * progress;
    return new Offset(0.0, height);
  }

  @override
  bool shouldRelayout(_BottomPickerLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
