import 'package:flutter/material.dart';

class ExamDashboard extends StatefulWidget {
  const ExamDashboard({Key? key}) : super(key: key);

  @override
  State<ExamDashboard> createState() => _ExamDashboardState();
}

class _ExamDashboardState extends State<ExamDashboard> {
  final List<Map<String, dynamic>> exams = [
    {
      'title': 'MATH',
      'description': 'devoir de controle',
      'date': '29/3/2025',
      'icon': Icons.calculate,
    },
    {
      'title': 'Geography',
      'description': 'devoir de synthèse',
      'date': '24/7/2024',
      'icon': Icons.public,
    },
    {
      'title': 'History',
      'description': 'devoir de controle',
      'date': '01/2/2024',
      'icon': Icons.book,
    },
    {
      'title': 'English',
      'description': 'devoir de controle',
      'date': '11/4/2025',
      'icon': Icons.flag,
    },
    {
      'title': 'Music',
      'description': 'devoir de controle',
      'date': '06/2/2025',
      'icon': Icons.music_note,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EXAM DASHBOARD'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Add new exam logic
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'All Exams:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    // Filter logic
                  },
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: exams.length,
                itemBuilder: (context, index) {
                  final exam = exams[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Icon(
                        exam['icon'],
                        size: 40,
                        color: Colors.blue,
                      ),
                      title: Text(
                        exam['title'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(exam['description']),
                          Text(
                            exam['date'],
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.visibility, color: Colors.blue),
                            onPressed: () {
                              // View exam logic
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.green),
                            onPressed: () {
                              // Edit exam logic
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              // Delete exam logic
                              setState(() {
                                exams.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}