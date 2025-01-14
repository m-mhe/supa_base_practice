import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController _nameTEC = TextEditingController();
  final TextEditingController _emailTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Base Practice"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    "Add a client",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                  content: SizedBox(
                    height: MediaQuery.sizeOf(context).height / 2.5,
                    child: Column(
                      children: [
                        TextField(
                          controller: _nameTEC,
                        ),
                        TextField(
                          controller: _emailTEC,
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () async {
                          await Supabase.instance.client.from('client').insert({
                            'name': _nameTEC.text,
                            'email': _emailTEC.text,
                          });
                        },
                        child: const Icon(Icons.add))
                  ],
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
