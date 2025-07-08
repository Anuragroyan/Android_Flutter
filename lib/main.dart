import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

void main() {
  runApp(MaterialApp(home: SarcasmDemo()));
}

class SarcasmDemo extends StatefulWidget {
  @override
  _SarcasmDemoState createState() => _SarcasmDemoState();
}

class _SarcasmDemoState extends State<SarcasmDemo> {
  Interpreter? _interpreter;
  Map<String, int>? _wordIndex;
  bool _isLoading = true;
  String _result = "";
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadModelAndTokenizer();
  }

  Future<void> loadModelAndTokenizer() async {
    try {
      ByteData modelData = await rootBundle.load('assets/sarcasm/model.tflite');
      final modelBytes = modelData.buffer.asUint8List();
      _interpreter = await Interpreter.fromBuffer(modelBytes);

      final jsonStr = await rootBundle.loadString('assets/sarcasm/word_index.json');
      final Map<String, dynamic> raw = json.decode(jsonStr);
      _wordIndex = raw.map((key, value) => MapEntry(key, value as int));

      setState(() => _isLoading = false);
    } catch (e) {
      print("❌ Load error: $e");
      setState(() {
        _result = "Failed to load model or tokenizer.";
        _isLoading = false;
      });
    }
  }

  void classifyText(String text) {
    if (_interpreter == null || _wordIndex == null) return;

    List<String> words = text.toLowerCase().split(" ");
    List<int> sequence = words.map((word) => _wordIndex![word] ?? 1).toList();
    while (sequence.length < 32) {
      sequence.add(0);
    }
    if (sequence.length > 32) {
      sequence = sequence.sublist(0, 32);
    }

    final input = [sequence];
    final output = List.filled(1 * 1, 0.0).reshape([1, 1]);
    _interpreter!.run(input, output);

    final score = output[0][0];
    setState(() {
      _result = score > 0.5 ? "Sarcastic 😏" : "Not Sarcastic 🙂";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sarcasm Demo")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter a sentence',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => classifyText(_controller.text),
              child: Text("Detect Sarcasm"),
            ),
            SizedBox(height: 24),
            Text(
              _result,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _interpreter?.close();
    super.dispose();
  }
}