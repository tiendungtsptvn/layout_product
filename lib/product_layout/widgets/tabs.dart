
import 'package:flutter/material.dart';

class TabsHeader extends StatefulWidget {
  const TabsHeader({Key? key}) : super(key: key);

  @override
  State<TabsHeader> createState() => _TabsHeaderState();
}

class _TabsHeaderState extends State<TabsHeader> {
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    _tabController = DefaultTabController.of(context)!;

    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        isScrollable: false,
        tabs: List.generate(
            tabs.length,
            (index) => Text(
                  tabs[index],
                  maxLines: 1,
              style: const TextStyle(
                fontSize: 16
              ),
                )),
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.black,
        indicatorColor: Colors.blue,

        indicatorPadding: EdgeInsets.zero,
        onTap: (visit) async {
        },
      ),
    );
  }
}

final List<String> tabs = ["Header", "Body", "Footer"];
