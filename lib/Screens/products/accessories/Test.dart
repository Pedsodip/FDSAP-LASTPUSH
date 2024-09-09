import 'package:flutter/material.dart';

class TypeFilterPage extends StatefulWidget {
  @override
  _TypeFilterPageState createState() => _TypeFilterPageState();
}

class _TypeFilterPageState extends State<TypeFilterPage> {
  final List<String> _options = ['Option 1', 'Option 2', 'Option 3', 'Option 4', 'Option 5'];
  String _selectedOption = 'Option 1'; // Default value

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text('Filter Menu Example')),
      body: Center(
        child: Container(
          width: screenWidth * 0.7,
          height: 50,
          child: DropdownButtonFormField<String>(
            value: _selectedOption,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color.fromARGB(255, 240, 240, 240),
              labelText: 'Type',
              labelStyle: const TextStyle(
                color: Color.fromARGB(255, 156, 153, 147),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 198, 198, 198),
                  width: 2.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 240, 240, 240),
                  width: 2.0,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            ),
            items: _options.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedOption = newValue!;
              });
            },
          ),
        ),
      ),
    );
  }
}
