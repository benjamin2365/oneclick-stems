import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(AudioApp());
}

class AudioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OneClick Stems',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: UploadPage(),
    );
  }
}

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  String status = "No file selected";

  Future<void> uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() => status = "Uploading...");

      var request = http.MultipartRequest(
        'POST',
        Uri.parse("http://YOUR_SERVER_IP:8000/separate/"),
      );
      request.files.add(await http.MultipartFile.fromPath('file', file.path));

      var res = await request.send();
      if (res.statusCode == 200) {
        setState(() => status = "Upload successful! Check server output.");
      } else {
        setState(() => status = "Upload failed!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("OneClick Stems")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(status),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: uploadFile,
              child: Text("Select & Upload MP3"),
            ),
          ],
        ),
      ),
    );
  }
}
