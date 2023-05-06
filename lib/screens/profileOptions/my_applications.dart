import 'package:flutter/material.dart';

class MyApplications extends StatelessWidget {
  const MyApplications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
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
              child: const ListTile(
                leading: Text('Company'),
                trailing: Text('Status'),
                title: Text('My Application'),
                subtitle: Text('Name'),
              ),
            ),
          );
        },
      ),
    );
  }
}