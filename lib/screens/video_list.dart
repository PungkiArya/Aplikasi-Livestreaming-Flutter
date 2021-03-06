import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/video_item.dart';
import '../models/video_model.dart';

class VideoList extends StatefulWidget {
  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  bool loading = false;
  bool isSearch = false;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      setState(() {
        loading = true;
      });

      Provider.of<VideoProvider>(context, listen: false)
          .getVideo(_searchController.text)
          .then((_) {
        setState(() {
          loading = false;
        });
      });
    });
    super.initState();
  }

  Future<void> _refreshData() async {
    setState(() {
      loading = true;
    });

    await Provider.of<VideoProvider>(context, listen: false)
        .getVideo(_searchController.text)
        .then((_) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearch
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Cari...',
                ),
                onSubmitted: (_) {
                  _refreshData();
                  FocusScope.of(context).unfocus();
                },
                onEditingComplete: () {
                  _refreshData();
                  FocusScope.of(context).unfocus();
                },
              )
            : Text('Live Streaming'),
        actions: <Widget>[
          IconButton(
            icon: Icon(isSearch ? Icons.cancel : Icons.search),
            onPressed: () {
              setState(() {
                isSearch = !isSearch;
                _searchController.clear();
              });
            },
          )
        ],
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                  stops: [0.3, 0.6, 0.9],
                  colors: [
                    Color.fromRGBO(78, 89, 235, 4),
                    Color.fromRGBO(30, 190, 178, 1),
                    Color.fromRGBO(222, 273, 200, 2),
                  ],
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 1, vertical: 2),
              child: RefreshIndicator(
                onRefresh: _refreshData,
                child: Consumer<VideoProvider>(
                  builder: (ctx, data, _) => ListView.builder(
                    itemCount: data.items.length,
                    itemBuilder: (ctx, i) => VideoItem(
                      data.items[i].videoId,
                      data.items[i].title,
                      data.items[i].channelTitle,
                      data.items[i].image,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
