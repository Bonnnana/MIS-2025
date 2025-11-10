import 'package:flutter/material.dart';
import '../data/exams_data.dart';
import '../widgets/exam_list.dart';
import '../models/exam.dart';

class MyHomePage extends
StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final List<Exam> _sorted;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadExams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4EFEF),
        title: Text(
          widget.title,
          style: const TextStyle(color: Color(0xFF47332A)),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: ExamList(exams: _sorted),
          ),

          Positioned(
            right: 16,
            bottom: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color:Color(0xFF47332A),
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.notes,
                      color: Color(0xFF47332A), size: 22),
                  const SizedBox(width: 6),
                  Text(
                    "Вкупно испити: ${_sorted.length}",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF47332A)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _loadExams() async {
    setState(() {
      _sorted = [...exams]..sort((a, b) => a.dateTime.compareTo(b.dateTime));
      _isLoading = false;
    });
  }
}
