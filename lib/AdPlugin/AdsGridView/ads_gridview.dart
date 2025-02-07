import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

enum AdsGridViewType { once, repeated, custom }

class AdsGridView extends StatelessWidget {
  const AdsGridView({
    this.padding,
    this.physics,
    this.controller,
    this.customAdsIndex = const [],
    this.itemMainAspectRatio = 1,
    required this.crossAxisCount,
    required this.itemCount,
    required this.adsIndex,
    required this.adsWidget,
    required this.itemWidget,
    required this.itemPadding,
    this.adsGridViewType = AdsGridViewType.once,
    Key? key,
  }) : super(key: key);

  final List customAdsIndex;
  final ScrollController? controller;
  final AdsGridViewType adsGridViewType;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final double? itemMainAspectRatio;
  final int crossAxisCount;
  final int itemCount;
  final int adsIndex;
  final EdgeInsetsGeometry itemPadding;
  final Widget adsWidget;
  final Widget Function(BuildContext context, int index) itemWidget;

  @override
  Widget build(BuildContext context) {
    int _itemCount = 0;
    if (itemCount < (crossAxisCount * adsIndex)) {
      _itemCount = itemCount;
    } else {
      _itemCount = itemCount + 1;
    }

    List indexList = [];
    if (AdsGridViewType.repeated == adsGridViewType) {
      int j = 0;
      for (int i = 0; i < itemCount; i++) {
        j++;
        indexList.add(i);
        if (j == adsIndex * crossAxisCount) {
          indexList.add("ads");
          j = 0;
        }
      }
    } else if (AdsGridViewType.custom == adsGridViewType) {
      List _customAdIndex = customAdsIndex;
      int j = 0;
      for (int i = 0; i < itemCount; i++) {
        if (i % crossAxisCount == 0) {
          j = i ~/ crossAxisCount;
          if (_customAdIndex.contains(j)) {
            _customAdIndex.remove(j);
            indexList.add("ads");
          }
        }
        indexList.add(i);
      }
    }

    return AdsGridViewType.once == adsGridViewType
        ? SingleChildScrollView(
            controller: controller,
            physics: physics,
            padding: padding,
            child: StaggeredGrid.count(
              crossAxisCount: crossAxisCount,
              children: List.generate(
                _itemCount,
                (index) {
                  return index == (crossAxisCount * adsIndex)
                      ? StaggeredGridTile.fit(crossAxisCellCount: crossAxisCount, child: adsWidget)
                      : StaggeredGridTile.count(
                          crossAxisCellCount: 1,
                          mainAxisCellCount: itemMainAspectRatio!,
                          child: Padding(
                            padding: itemPadding,
                            child: itemWidget(context, index < (crossAxisCount * adsIndex) ? index : (index - 1)),
                          ),
                        );
                },
              ),
            ),
          )
        : SingleChildScrollView(
            controller: controller,
            physics: physics,
            padding: padding,
            child: StaggeredGrid.count(
              crossAxisCount: crossAxisCount,
              children: List.generate(
                indexList.length,
                (index) {
                  return indexList[index] == "ads"
                      ? StaggeredGridTile.fit(crossAxisCellCount: crossAxisCount, child: adsWidget)
                      : StaggeredGridTile.count(
                          crossAxisCellCount: 1,
                          mainAxisCellCount: itemMainAspectRatio!,
                          child: Padding(
                            padding: itemPadding,
                            child: itemWidget(context, indexList[index]),
                          ),
                        );
                },
              ),
            ),
          );
  }
}
