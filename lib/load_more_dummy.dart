import 'package:flutter/material.dart';

class LoadMoreDummy extends StatefulWidget {
  @override
  _LoadMoreDummyState createState() => _LoadMoreDummyState();
}

class _LoadMoreDummyState extends State<LoadMoreDummy> {
  //
  final ScrollController scrollController = ScrollController();
  final List<int> itemList = [];
  int lastIndex = 0;

  //
  @override
  void initState() {
    //
    super.initState();

    //
    scrollController.addListener(() {
      //
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        //
        loadMoreData();
      }
    });

    //
    loadInitialData();
  }

  //
  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  //
  void loadInitialData() {
    int i;
    for (i = 1; i <= 10; i++) {
      itemList.add(i);
    }
    lastIndex = i;

    setState(() {
      //
    });
  }

  //
  void loadMoreData() {
    int i;

    for (i = lastIndex; i < (lastIndex + 10); i++) {
      itemList.add(i);
    }
    lastIndex = i;

    setState(() {
      //
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        title: Text('Load More Dummy'),
      ),

      //
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(right: 5),
        child: Scrollbar(
          //
          thickness: 10,

          //
          child: ListView.builder(
            //
            controller: scrollController,

            //
            padding: EdgeInsets.all(16),
            itemCount: itemList.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Container(
                  height: 50,
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.all(16),
                  child: Text('${itemList[index].toString()}'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
