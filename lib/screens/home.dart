import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home screen')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Text('Set valid API base URL in order to continue'),
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Please enter URL', suffixIcon: Icon(Icons.api)),
            ),
            const Spacer(),
            TextButton(
                onPressed: () {},
            style:  ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)
            ),
                child:  const Text(
                  'Start counting process',
                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                ),
            )
          ],
        ),
      ),
    );
  }
}
