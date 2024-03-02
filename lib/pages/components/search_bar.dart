import 'dart:ui';

import 'package:flightsky/pages/search_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GlassEffectSearchBar extends StatefulWidget {
  List<dynamic> list;
  GlassEffectSearchBar({required this.list});

  @override
  State<GlassEffectSearchBar> createState() => _GlassEffectSearchBarState();
}

class _GlassEffectSearchBarState extends State<GlassEffectSearchBar> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0), // Adjust the corner radius
      child: BackdropFilter(
        filter:
            ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // Adjust blur radius
        child: Container(
          width: 300, // Adjust width
          height: 60, // Adjust height
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1), // Adjust background opacity
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Center(
            child: TextField(
              controller: searchController,
              onSubmitted: (value) => {
                print(searchController.text),
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SearchView(
                    searchQuery: searchController.text,
                    list: widget.list,
                  ),
                )),
                searchController.clear(),
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
