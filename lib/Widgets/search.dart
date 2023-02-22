import 'package:flutter/material.dart';

// ignore: camel_case_types
class searchScreen extends SearchDelegate {
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null); //is its null close the seaching screen
          } else {
            query = '';
          } // else clear the textfield
        },
      );
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            close(context, null);
          },
        )
      ];

  @override
  Widget buildResults(BuildContext context) {
    Center(
      child: Text(
        query,
        style: const TextStyle(fontSize: 64),
      ),
    );
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}
