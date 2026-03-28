import 'package:flutter/material.dart';

class Slivers extends StatelessWidget {
  const Slivers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [


          // SliverSafeArea(sliver: sliver),
          SliverAppBar(
            expandedHeight: 400,
            title: Text("data"),
            pinned: false,
            //
            flexibleSpace: Text("data"),
            collapsedHeight: 300,
            elevation: 1,
            floating: true,
            snap: true,
          ),
          SliverGrid.builder(
            itemCount: 4,
            itemBuilder: (context, index) => Text("data"),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 200,
            delegate: SliverChildBuilderDelegate(
              (context, index) => Text("data"),
              childCount: 10,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Text("data"),
              childCount: 1,
            ),
          ),
          SliverPrototypeExtentList(
            delegate: SliverChildBuilderDelegate(
              childCount: 4,
              (context, index) => Text("data"),
            ),
            prototypeItem: Container(height: 10),
          ),
          SliverFillViewport(
            viewportFraction: 0.4,

            delegate: SliverChildListDelegate([
              Container(color: Colors.amber, child: Text("data")),
            ]),
          ),
        ],
      ),
    );
  }
}
