import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flames App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const Homepage(title: "Flames"),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key, required this.title});

  final String title;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController yourNameController = TextEditingController();
  final TextEditingController partnerNameController = TextEditingController();

  Map<String, String> data = {
    "f": "You are a good friend to him/her",
    "l": "Think you are in love with her/him",
    "a": "You got affection with her/him",
    "m": "You two are getting married",
    "e": "You are enemies",
    "s": "You are like siblings",
  };

  /// 🔹 Fixed Recursive FLAMES Function
  String getTheRelationship(List<String> flames, int length) {
    int index = 0;
    while (flames.length > 1) {
      index = (index + length - 1) % flames.length;
      flames.removeAt(index);
    }
    return flames.first;
  }

  void findMyRelationship() {
    String yourName = yourNameController.text.trim().toLowerCase();
    String partnerName = partnerNameController.text.trim().toLowerCase();

    if (yourName.isEmpty || partnerName.isEmpty) return;

    List<String> name1 = yourName.split('');
    List<String> name2 = partnerName.split('');

    /// 🔹 Corrected Removal of Common Characters
    for (var char in List.of(name1)) {
      if (name2.contains(char)) {
        name1.remove(char);
        name2.remove(char);
      }
    }

    int totalLength = name1.length + name2.length;
    List<String> flames = ["f", "l", "a", "m", "e", "s"];
    final answer = getTheRelationship(flames, totalLength);

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Your Relationship'),
        content: Text(data[answer] ?? ""),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'OK');
              yourNameController.clear();
              partnerNameController.clear();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: yourNameController,
              decoration: const InputDecoration(
                labelText: "Your Name",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: partnerNameController,
              decoration: const InputDecoration(
                labelText: "Partner Name",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          MaterialButton(
            onPressed: findMyRelationship,
            child: const Text(
              "Find My Relationship",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
