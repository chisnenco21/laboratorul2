import 'dart:convert';
import 'package:flutter/material.dart';

void main() => runApp(BarberApp());

class BarberApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BarberHomePage(),
    );
  }
}

class BarberHomePage extends StatefulWidget {
  @override
  _BarberHomePageState createState() => _BarberHomePageState();
}

class _BarberHomePageState extends State<BarberHomePage> {
  List<dynamic> barbershops = [];

  @override
  void initState() {
    super.initState();
    loadBarbershops();
  }

  Future<void> loadBarbershops() async {
    final String response = await DefaultAssetBundle.of(context)
        .loadString("assets/barbershops.json");
    final data = json.decode(response);
    setState(() {
      barbershops = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.location_on, color: Colors.grey[600]),
            SizedBox(width: 8),
            Text(
              "Chișinău",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage("asset/fotop.png"),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              "Dinu Chisnenco",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: barbershops.length,
                itemBuilder: (context, index) {
                  final barbershop = barbershops[index];
                  return barbershopCard(
                    context: context,
                    title: barbershop['title'],
                    distance: barbershop['distance'],
                    rating: barbershop['rating'],
                    imageUrl: barbershop['imageUrl'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget barbershopCard({
    required BuildContext context,
    required String title,
    required String distance,
    required double rating,
    required String imageUrl,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(imageUrl),
          radius: 30,
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(distance),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, color: Colors.amber),
            Text(rating.toString(),
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
