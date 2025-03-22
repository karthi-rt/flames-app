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
  String yourName = "";
  String partnerName = "";

  // Map -> Dictionary (key, value) pairs
  Map<String, String> data = {
    "f": "You are a good friend 👬 to him/her",
    "l": "Think you are in love ❤️ with her/him",
    "a": "you got a affection 😊 with hier/him",
    "m": "You two are getting 💍 married",
    "e": "You are 😠 enemies",
    "s": "You are a 👫 sister/brother",
  };

  String getTheRelationship(List<String> flames, length) {
    final findRemovingData = length % flames.length;
    final local = [...flames];
    local.removeAt(
      findRemovingData == 0 ? flames.length - 1 : findRemovingData - 1,
    );

    if (flames.length == 1) {
      return flames.join('');
    }
    return getTheRelationship(local, length);
  }

  void findMyRelationship() {
    List<String> longestName = (yourName.length > partnerName.length
            ? yourName
            : partnerName)
        .toLowerCase()
        .split('');
    List<String> shortestName = (yourName.length < partnerName.length
            ? yourName
            : partnerName)
        .toLowerCase()
        .split('');
    // save full data of longestname in local [... - Spread]
    final local = [...longestName];

    for (var singleCharacter in local) {
      if (shortestName.contains(singleCharacter)) {
        longestName.remove(singleCharacter);
        shortestName.remove(singleCharacter);
      }
    }

    final totalLengthOfName = longestName.length + shortestName.length;
    List<String> flames = ["f", "l", "a", "m", "e", "s"];
    final answer = getTheRelationship(flames, totalLengthOfName);

    showDialog<String>(
      context: context,
      builder:
          (BuildContext context) => AlertDialog(
            title: const Text('Your Relationship'),
            content: Text(data[answer] ?? ""),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
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
        centerTitle: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (value) => yourName = value,
              decoration: InputDecoration(
                label: Text("Your Name"),
                border: OutlineInputBorder(),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (value) => partnerName = value,
              decoration: InputDecoration(
                label: Text("Partner Name"),
                border: OutlineInputBorder(),
              ),
            ),
          ),

          MaterialButton(
            onPressed: () {
              findMyRelationship();
            },
            child: Text(
              "Find My Relationship",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
