import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(AgeCalculatorApp());
}

class AgeCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Age Calculator',
      home: AgeCalculator(),
    );
  }
}

class AgeCalculator extends StatefulWidget {
  @override
  _AgeCalculatorState createState() => _AgeCalculatorState();
}

class _AgeCalculatorState extends State<AgeCalculator> {
  DateTime? _selectedDate;
  String _ageResult = '';
  String _quote = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Age Calculator'),
      ),
      body: Center(
        child: Container(
          width: 450,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Determine Your Age in Seconds!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _selectDate(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen, // Change the button color here
                ),
                child: Text('Select Date of Birth'),
              ),
              SizedBox(height: 20),
              if (_selectedDate != null)
                Text(
                  'Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
                  style: TextStyle(fontSize: 18),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  calculateAge();
                },
                child: Text('Calculate Age'),
              ),
              SizedBox(height: 20),
              Text(
                'Age: $_ageResult',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                '$_quote',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void calculateAge() {
    if (_selectedDate != null) {
      DateTime now = DateTime.now();

      if (_selectedDate!.isBefore(now)) {
        Duration difference = now.difference(_selectedDate!);
        int age = (difference.inDays / 365).floor();

        setState(() {
          _ageResult = '$age years';
          _setQuote(age);
        });
      } else {
        setState(() {
          _ageResult = 'Invalid date of birth';
          _quote = '';
        });
      }
    } else {
      setState(() {
        _ageResult = 'Please select date of birth';
        _quote = '';
      });
    }
  }

  void _setQuote(int age) {
    if (age < 18) {
      _quote = 'You are young and full of potential!';
    } else if (age >= 18 && age <= 35) {
      _quote = 'You are in the prime of your life!';
    } else {
      _quote = 'Wisdom comes with age. Embrace it!';
    }
  }
}
