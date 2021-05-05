import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Grid List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(title),
        ),
        body: ArucoGrid(),
      ),
    );
  }
}

class ArucoGrid extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ArucoGrid();
}

class _ArucoGrid extends State<ArucoGrid> {
//  String _selectedLocation = 'Please choose a location'; // Option 1
  List<String> _gridCols =  ['1', '2', '3', '4']; // Option 2
  String _selectedLocation; // Option 2

  int max_markers = 100;
  int cols = 1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Positioned(
          width: size.width,
          height: size.height * 0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: size.width / 3,
                height: 50,
                child:  DropdownButton(
                  isExpanded: true,
                  hint: Text('Cols'), // Not necessary for Option 1
                  value: _selectedLocation,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedLocation = newValue;
                      cols = int.parse(newValue);
                    });
                  },
                  items: _gridCols.map((location) {
                    return DropdownMenuItem(
                      child: new Text(location),
                      value: location,
                    );
                  }).toList(),
                ),
              ),
              Container(
                width: size.width / 3,
                height: 50,
                child:  TextField(
                  decoration: new InputDecoration(labelText: "Enter your number"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                  ], // Only numbers can be entered
                  onSubmitted: (newValue) {
                    setState(() {
                      max_markers = int.parse(newValue);
                    });
                  },
                ),
              )
            ],
          )
        ),
        Positioned(
          height: size.height * 0.8,
          width: size.width,
          bottom: 0,
          child: GridView.count(
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: cols,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(max_markers, (index) {
                  String image_asset = "assets/DICT_6X6_250/$index.png";
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: size.width/cols - 20,
                          height: size.width/cols - 20,
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: new AssetImage(image_asset),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          child: Text(
                            'ID $index',
                          ),
                        ),
                      ),
                      
                    ],
                  );
                }),
              ),
        ),
      ],
    );
  }
}