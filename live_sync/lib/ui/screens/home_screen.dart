import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_sync/controllers/text_data_add_controller.dart';
import 'package:live_sync/controllers/text_data_edit_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../controllers/text_data_delete_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final TextEditingController _noteTitleTEC = TextEditingController();
final TextEditingController _noteSubTitleTEC = TextEditingController();
final Stream<List<Map<String, dynamic>>> _notesStream =
    Supabase.instance.client.from('notes').stream(primaryKey: ['id']);

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NOTE"),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _notesStream,
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return GetBuilder<TextDataDeleteController>(builder: (controller) {
              return Visibility(
                visible: !controller.loading,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: ListView.builder(
                    itemCount: snapShot.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onHorizontalDragEnd: (DragEndDetails slideValue) async {
                          final double? mainVelocity =
                              slideValue.primaryVelocity;
                          if (mainVelocity != null) {
                            if (mainVelocity < -1000) {
                              await controller.deleteTextData(
                                  id: snapShot.data![index]["id"]);
                            }
                          }
                        },
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                _noteTitleTEC.text =
                                    snapShot.data![index]["title"];
                                _noteSubTitleTEC.text =
                                    snapShot.data![index]["subtitle"];
                                return AlertDialog(
                                  title: const Text(
                                    "Edit this note into Supabase",
                                    textAlign: TextAlign.center,
                                  ),
                                  content: SizedBox(
                                    height: 150,
                                    width: double.maxFinite,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                    GetBuilder<TextDataEditController>(
                                        builder: (controller) {
                                      return Visibility(
                                        visible: !controller.loading,
                                        replacement:
                                            const CircularProgressIndicator(),
                                        child: ElevatedButton(
                                            onPressed: () async {
                                              await controller.editTextData(
                                                  title:
                                                      _noteTitleTEC.text.trim(),
                                                  subtitle:
                                                      _noteSubTitleTEC.text,
                                                  id: snapShot.data![index]
                                                      ["id"]);
                                              _noteTitleTEC.clear();
                                              _noteSubTitleTEC.clear();
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Update")),
                                      );
                                    })
                                  ],
                                );
                              });
                        },
                        child: Container(
                          color: Colors.lightGreen[100],
                          child: ListTile(
                            leading:
                                Text(snapShot.data![index]['id'].toString()),
                            title:
                                Text(snapShot.data![index]['title'].toString()),
                            subtitle: Text(
                                snapShot.data![index]['subtitle'].toString()),
                            trailing: Text(snapShot.data![index]['created_at']
                                .toString()
                                .split('T')[0]),
                          ),
                        ),
                      );
                    }),
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
            child: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.image_outlined),
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
                        title: const Text(
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
                          GetBuilder<TextDataAddController>(
                              builder: (controller) {
                            return Visibility(
                              visible: !controller.loading,
                              replacement: const CircularProgressIndicator(),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    await controller.addTextData(
                                        title: _noteTitleTEC.text.trim(),
                                        subtitle: _noteSubTitleTEC.text);
                                    _noteTitleTEC.clear();
                                    _noteSubTitleTEC.clear();
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Save")),
                            );
                          })
                        ],
                      );
                    });
              },
              child: const Icon(Icons.add_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
