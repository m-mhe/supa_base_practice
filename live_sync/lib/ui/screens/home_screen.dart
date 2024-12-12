import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final TextEditingController _noteTitleTEC = TextEditingController();
final TextEditingController _noteSubTitleTEC = TextEditingController();
final Stream<List<Map<String, dynamic>>> _notesStream =
    Supabase.instance.client.from('notes').stream(primaryKey: ['id']);

void _saveToSyncDB() async {
  await Supabase.instance.client
      .from('notes')
      .insert({'title': _noteTitleTEC.text, 'subtitle': _noteSubTitleTEC.text});
  _noteTitleTEC.clear();
  _noteSubTitleTEC.clear();
}

Future<void> _deleteFromSyncDB(int id) async {
  await Supabase.instance.client.from('notes').delete().eq("id", id);
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NOTE"),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _notesStream,
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return ListView.builder(
                itemCount: snapShot.data!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onHorizontalDragEnd: (DragEndDetails slideValue) {
                      final double? mainVelocity = slideValue.primaryVelocity;
                      if (mainVelocity != null) {
                        if (mainVelocity > 1000) {
                          _deleteFromSyncDB(snapShot.data![index]["id"]);
                        }
                      }
                    },
                    child: Container(
                      color: Colors.lightGreen[100],
                      child: ListTile(
                        leading: Text(snapShot.data![index]['id'].toString()),
                        title: Text(snapShot.data![index]['title'].toString()),
                        subtitle:
                            Text(snapShot.data![index]['subtitle'].toString()),
                        trailing:
                            Text(snapShot.data![index]['created_at'].toString()),
                      ),
                    ),
                  );
                });
          } else if (snapShot.hasError) {
            return Center(
              child: Text(snapShot.error.toString()),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: FloatingActionButton(onPressed: (){},
              child: Icon(Icons.image_outlined),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          "Add a note into Supabase",
                          textAlign: TextAlign.center,
                        ),
                        content: SizedBox(
                          height: 150,
                          width: double.maxFinite,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextField(
                                controller: _noteTitleTEC,
                              ),
                              TextField(
                                controller: _noteSubTitleTEC,
                                maxLines: 3,
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                _saveToSyncDB();
                                Navigator.pop(context);
                              },
                              child: const Text("Save"))
                        ],
                      );
                    });
              },
              child: Icon(Icons.add_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
