import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return  MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage("assets/images/anhduwong.jpg"),
                  ),
                  Text('Lý Triều Dương',
                  style: TextStyle( 
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Bình Dương, Việt Nam',
                  style: TextStyle( 
                    fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10,
              left: 10, 
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1), 
                  borderRadius: BorderRadius.circular(8), 
                ),
                child: BackButton(
                  onPressed: () {
                  },
                ),
              )
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1), 
                  borderRadius: BorderRadius.circular(8), 
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.edit_square),
                  onPressed: () {
                  },
                ),
              ),
            ),
          ],
        )
      )
    );
  }
  
}
