import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyListings extends StatelessWidget {
  const MyListings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(icon: const Icon(CupertinoIcons.left_chevron), 
          onPressed: () {
            Navigator.pop(context);
          },),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('My Applications'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder:(context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Container(
                decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
              child: ListTile(
                trailing: CupertinoButton(
                  onPressed: () { 
                    
                  },
                  child: const Text('Delete')),
                title: const Text('My Listings'),
                subtitle: const Text('Name'),
              ),
            ),
          );
        },
      ),
    );
  }
}