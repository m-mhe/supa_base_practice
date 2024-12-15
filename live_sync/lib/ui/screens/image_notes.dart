import 'package:flutter/material.dart';
import 'package:live_sync/ui/screens/image_upload_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImageNotes extends StatelessWidget {
  const ImageNotes({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<List<Map<String, dynamic>>> imageUrlStream =
        Supabase.instance.client.from("images").stream(primaryKey: ["id"]);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Notes"),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
          stream: imageUrlStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: GridView.builder(
                  itemCount: snapshot.data?.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      childAspectRatio: 1),
                  itemBuilder: (BuildContext context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  snapshot.data?[index]["image_url"]), fit: BoxFit.cover)),
                    );
                  }),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return const ImageUploadScreen();
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
