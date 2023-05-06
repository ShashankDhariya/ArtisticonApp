import 'dart:developer';
import 'package:flutter/material.dart';

class RentSearchBar extends StatefulWidget {
  const RentSearchBar({super.key});

  @override
  State<RentSearchBar> createState() => _RentSearchBarState();
}

class _RentSearchBarState extends State<RentSearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Container(
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 40,
      ),
      height: 300,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: const DecorationImage(
          image: AssetImage('assets/images/search_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fast Search',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'You can search quickly for any service you want',
            style: TextStyle(
              height: 1.8,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Perform search with query
                    log('Searching for ${_searchController.text}');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/search.png',
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
