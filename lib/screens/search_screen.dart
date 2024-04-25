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

    searchController.addListener(() async {
      final query = searchController.text;
      setState(() => searchResults.clear());
      if (query == '') return;
      await updateSearchResults(query);
      setState(() {});
    });
  }

  Future<void> updateSearchResults(String query) async {
    final queryResult = await Get.find<QueryManager>().search(query);
    queryResult.docs.forEach((doc) {
      searchResults.add(
        FlotesWidgets.NoteTile(
          document: doc,
          onTap: () => Get.toNamed('/editor', arguments: doc),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Column(
        children: [
          TextField(
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
          Expanded(
            child: ListView(
              children: searchResults.toList(),
            ),
          ),
        ],
      ),
    );
  }
}
