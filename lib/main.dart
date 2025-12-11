import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Internship'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool showName = false;
  List<String> tasks = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _tasksController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _tasksController.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    if (_counter >= 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Counter cannot be greater than 10')),
      );
      return;
    }
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    if (_counter <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Counter cannot be less than 0')),
      );
      return;
    }
    setState(() {
      _counter--;
    });
  }

  void _showCircularBar() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Loading..."),
            ],
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).pop(); // Close the dialog
      setState(() {
        showName = true;
      });
    });
  }

  void _addTask() {
    final t = _tasksController.text.trim();
    if (t.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a task')));
      return;
    }
    setState(() {
      tasks.add(t);
      _tasksController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    // sample numbered items for last column
    final numberedItems = ['Item 1', 'Item 2', 'Item 3'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Counterr:'),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: const Text('Increment'),
                    onPressed: _incrementCounter,
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    child: const Text('Decrement'),
                    onPressed: _decrementCounter,
                  ),
                ],
              ),
              Container(
                width: 300,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Text(
                      'Task 2',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter a search term',
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _showCircularBar,
                          child: const Text('Submit'),
                        ),
                      ],
                    ),

                    if (showName && _nameController.text.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Text(
                        'Hello, ${_nameController.text}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],

                    const SizedBox(height: 12),
                    const Text(
                      'Task 3',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _tasksController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Task',
                            ),
                            onSubmitted: (_) => _addTask(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _addTask,
                          child: const Text('Add Task'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 160,
                      child: tasks.isEmpty
                          ? const Center(child: Text('No tasks yet'))
                          : ListView.builder(
                              itemCount: tasks.length,
                              itemBuilder: (context, index) {
                                final item = tasks[index];
                                return ListTile(
                                  title: Text(item),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      setState(() => tasks.removeAt(index));
                                    },
                                  ),
                                );
                              },
                            ),
                    ),
                    const SizedBox(height: 12),
                    const Text("Taks 5"),
                    const SizedBox(height: 8),
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        'https://avatars.githubusercontent.com/u/9919?s=200&v=4',
                      ),
                    ),
                  ],
                ),
              ),

              // ---- last column container with Row and numbered list ----
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Row Example",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(Icons.star, color: Colors.yellow, size: 40),
                        Icon(Icons.heart_broken, color: Colors.red, size: 40),
                        Icon(Icons.settings, color: Colors.blue, size: 40),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Column Example",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Numbered list (1, 2, 3) shown in the last "column"
                    // Using Column so it lays out inline with parent column (no extra scrolling)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(numberedItems.length, (i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "• ",
                                style: TextStyle(
                                  fontSize: 20,
                                  height: 1.2,
                                ), // bullet
                              ),
                              Expanded(
                                child: Text(
                                  numberedItems[i],
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      "Card Example",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Card(
                      elevation: 3,
                      child: ListTile(
                        leading: Icon(Icons.info, color: Colors.blue, size: 52),
                        title: Text("Practice Card Title"),
                        subtitle: Text("This is the dummy card Description"),
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "List Items",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),

                        Card(
                          elevation: 1,
                          surfaceTintColor: Colors.white,
                          child: Column(
                            children: const [
                              ListTile(title: Text("List Item 1")),
                              Divider(height: 05),
                              ListTile(title: Text("List Item 2")),
                              Divider(height: 0.5),
                              ListTile(title: Text("List Item 3")),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
