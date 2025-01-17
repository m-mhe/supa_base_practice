import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_sync/data_base_practice/ui/controllers/insertion_into_client_db.dart';
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
          _onAddingAClient(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> _onAddingAClient(BuildContext context) {
    return showDialog(
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
              GetBuilder<InsertionIntoClientDb>(builder: (controller) {
                return Visibility(
                  visible: !controller.loading,
                  replacement: const CircularProgressIndicator(),
                  child: ElevatedButton(
                      onPressed: () async {
                        await controller.insert(
                            name: _nameTEC.text, email: _emailTEC.text);
                        _nameTEC.clear();
                        _emailTEC.clear();
                        Get.back();
                      },
                      child: const Icon(Icons.add)),
                );
              })
            ],
          );
        });
  }
}
