import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:layout_example/product_layout/widgets/sticky_tab_bar_delegate.dart';
import 'package:layout_example/product_layout/widgets/tabs.dart';
import 'package:miniplayer/miniplayer.dart';

const double heightItem = 900;

class ProductLayout extends StatefulWidget {
  const ProductLayout(
      {Key? key,
      this.headerWidget,
      this.headerHeight,
      this.miniplayerController})
      : super(key: key);
  final Widget? headerWidget;
  final double? headerHeight;
  final MiniplayerController? miniplayerController;

  @override
  State<ProductLayout> createState() => _ProductLayoutState();
}

class _ProductLayoutState extends State<ProductLayout> {
  final headerKey = GlobalKey(debugLabel: "headerKey");
  final bodyKey = GlobalKey(debugLabel: "bodyKey");
  final footerKey = GlobalKey(debugLabel: "footerKey");

  ScrollController scrollController = ScrollController();

  bool isTabBar = false;
  @override
  Widget build(BuildContext context) {
    // scrollController.addListener(() {
    //   if (widget.miniplayerController != null) {
    //     if (scrollController.position.pixels < -60) {
    //       widget.miniplayerController!.animateToHeight(state: PanelState.MIN);
    //     }
    //   }
    // });
    return Column(
      children: [
        Flexible(
          child: DefaultTabController(
            length: tabs.length,
            child: Wrap(
              children: [
                Container(height: 20,color: Colors.red,),
                CustomScrollView(
                  controller: scrollController,
                  shrinkWrap: true,
                  cacheExtent: 5000,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  slivers: [
                    // SliverAppBar(
                    //   automaticallyImplyLeading: false,
                    //   stretch: true,
                    //   onStretchTrigger: () {
                    //     return Future<void>.value();
                    //   },
                    //   expandedHeight: (widget.headerWidget != null &&
                    //           widget.headerHeight != null)
                    //       ? widget.headerHeight
                    //       : 300,
                    //   flexibleSpace: FlexibleSpaceBar(
                    //     stretchModes: const <StretchMode>[
                    //       StretchMode.fadeTitle,
                    //     ],
                    //     centerTitle: true,
                    //     background: widget.headerWidget ??
                    //         Image.network(
                    //           "https://cf.shopee.vn/file/d04f15a8e03ff968ac03eb572e89cb8e",
                    //           errorBuilder: (context, error, stackTrace) {
                    //             return Image(
                    //               image: const AssetImage(
                    //                   "assets/images/default_image.png"),
                    //               height: 300,
                    //               width: width,
                    //               fit: BoxFit.fill,
                    //             );
                    //           },
                    //           height: 300,
                    //           width: width,
                    //           fit: BoxFit.fill,
                    //         ),
                    //   ),
                    // ),
                    SliverToBoxAdapter(
                      child: widget.headerWidget,
                    ),
                    (isTabBar)
                        ? SliverPersistentHeader(
                      pinned: true,
                      floating: true,
                      delegate:
                      StickyTabBarDelegate(child: const TabsHeader()),
                    )
                        : SliverPersistentHeader(
                      pinned: true,
                      floating: true,
                      delegate: StickyTabBarDelegate(
                          child:
                          CupertinoSlidingSegmentedControl<GlobalKey>(
                              children: {
                                headerKey: const Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    'Header',
                                    style: TextStyle(
                                        color: CupertinoColors.black),
                                  ),
                                ),
                                bodyKey: const Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    'Body',
                                    style: TextStyle(
                                        color: CupertinoColors.black),
                                  ),
                                ),
                                footerKey: const Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    'Footer',
                                    style: TextStyle(
                                        color: CupertinoColors.black),
                                  ),
                                ),
                              },
                              onValueChanged: (GlobalKey? key) {
                                if (key != null) {
                                  Scrollable.ensureVisible(
                                      key.currentContext!,
                                      duration:
                                      const Duration(seconds: 1));
                                }
                              })),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return (isTabBar)
                              ? SizedBox(
                            height: 1000,
                            child: TabBarView(
                              children:
                              List.generate(tabs.length, (index) {
                                return SizedBox(
                                    height: 100,
                                    child: Text("Tab: $index"));
                              }),
                            ),
                          )
                              : SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.green.withOpacity(0.4),
                                  key: headerKey,
                                  height: heightItem,
                                  child:
                                  const Text("HEADING\nThis heading"),
                                ),
                                Container(
                                  color: Colors.orange.withOpacity(0.4),
                                  key: bodyKey,
                                  height: heightItem,
                                  child: const Text("BODY\nThis body"),
                                ),
                                Container(
                                  color: Colors.yellow.withOpacity(0.4),
                                  key: footerKey,
                                  height: heightItem,
                                  child:
                                  const Text("FOOTER\nThis footer"),
                                ),
                              ],
                            ),
                          );
                        },
                        childCount: 1,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
