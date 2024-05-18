import 'package:flotes/widgets/widgets.dart' as FlotesWidgets;
import 'package:flotes/services/query_manager.dart' show QueryManager;

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchController;
  late FocusNode searchFocusNode;
  late List<FlotesWidgets.NoteTile> searchResults;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchFocusNode = FocusNode();
    searchResults = [];
  }

  Future<void> updateSearchResults(String query) async {
    final collection = await Get.find<QueryManager>().search(query);

    final queryResult = collection.docs.where((doc) {
      return doc['Title']
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase());
    });

    queryResult.forEach((doc) {
      searchResults.add(
        FlotesWidgets.NoteTile(
          document: doc,
          onTap: () {
            searchFocusNode.unfocus();
            Get.toNamed('/editor', arguments: doc);
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onEditingComplete: () async {
              searchResults.clear();
              final query = searchController.text;
              setState(() {});
              if (query == '') return;
              await updateSearchResults(query);
              setState(() {});
            },
            autofocus: false,
            focusNode: searchFocusNode,
            controller: searchController,
            maxLines: 1,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              alignLabelWithHint: true,
              hintText: 'Search',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: searchResults.toList(),
            ),
          ),
        ],
      ),
    );
  }
}
