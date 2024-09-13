import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:table_calendar/table_calendar.dart';

class MyTaskScreen extends StatefulWidget {
  MyTaskScreen({super.key});

  @override
  _MyTaskScreenState createState() => _MyTaskScreenState();
}

class _MyTaskScreenState extends State<MyTaskScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFF0E181E),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildProfileSection(context),
            _buildCalendar(),
            Expanded(child: _buildTaskList(context)),
            _buildAddTaskButton(context),
            _buildBottomBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar() {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.grey.withOpacity(0.3), // Light grey border
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(10.0), // Optional: round the corners
    ),
    margin: const EdgeInsets.symmetric(horizontal: 16.0), // Optional: Add some space around the calendar
    padding: const EdgeInsets.all(8.0), // Optional: Add padding inside the border
    child: TableCalendar(
      locale: 'cs_CZ', // Set the calendar to Czech language
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: _selectedDay,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
        });
      },
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Color.fromARGB(255, 35, 74, 97),
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.blueAccent,
          shape: BoxShape.circle,
        ),
        defaultTextStyle: TextStyle(color: Colors.white),
        weekendTextStyle: TextStyle(color: Colors.white),
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 16),
        leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
        rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: Colors.white),
        weekendStyle: TextStyle(color: Colors.white),
      ),
    ),
  );
}

  Widget _buildTaskList(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('tasks')
        .where('dueDate', isEqualTo: _selectedDay.toIso8601String().split('T').first)
        .orderBy('createdAt', descending: true)
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }

      if (snapshot.hasError) {
        print("Error fetching tasks: ${snapshot.error}");
        return Center(
          child: Text(
            'Chyba při načítání úkolů',
            style: TextStyle(color: Colors.white),
          ),
        );
      }

      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return Center(
          child: Text(
            'Žádné úkoly pro tento den',
            style: TextStyle(color: Colors.white),
          ),
        );
      }

      final tasks = snapshot.data!.docs;
      return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          var task = tasks[index];
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.withOpacity(0.3), // Light grey border
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0), // Optional: round the corners
            ),
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
            padding: const EdgeInsets.all(8.0), // Optional: Add padding inside the border
            child: ListTile(
              title: Text(
                task['title'],
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                task['dueTime'] != null ? task['dueTime'] : '',
                style: TextStyle(color: Colors.grey),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.redAccent),
                onPressed: () => _deleteTask(task.id),
              ),
            ),
          );
        },
      );
    },
  );
}



  Widget _buildAddTaskButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        onPressed: () => _showAddTaskDialog(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 35, 74, 97),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text('Přidat úkol'),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final titleController = TextEditingController();
    TimeOfDay? selectedTime;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Přidat úkol'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Název úkolu'),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      selectedTime = pickedTime;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 35, 74, 97),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  selectedTime != null
                      ? 'Čas: ${selectedTime!.format(context)}'
                      : 'Vybrat čas',
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _addTask(titleController.text, selectedTime);
                Navigator.of(context).pop();
              },
              child: Text('Přidat'),
            ),
          ],
        );
      },
    );
  }

  void _addTask(String title, TimeOfDay? selectedTime) async {
    if (title.isEmpty) return;

    final userUid = user.uid;
    final dueTime = selectedTime != null
        ? selectedTime.format(context)
        : ''; // Save time as a formatted string

    final task = {
      'title': title,
      'dueTime': dueTime,
      'dueDate': _selectedDay.toIso8601String().split('T').first, // Store only the date part
      'createdAt': Timestamp.now(),
    };

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .collection('tasks')
        .add(task);
  }

  void _deleteTask(String taskId) async {
    final userUid = user.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .collection('tasks')
        .doc(taskId)
        .delete();
  }

  Widget _buildProfileSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      color: Color(0xFF0E181E),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Přihlášen jako: ${user.email!}',
            style: const TextStyle(
              color: Color(0xFFE0F0FF),
              fontSize: 16,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.15,
            ),
          ),
          IconButton(
            icon: Icon(Icons.logout, color: Color(0xFFE0F0FF)),
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed('/home');
              } catch (e) {
                print('Error signing out: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to sign out. Please try again.')),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Color(0xFF12222B),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomBarButton(context, 'skupiny', Icons.group, '/groups'),
          _buildBottomBarButton(context, 'cíle', Icons.flag, '/goals'),
          _buildBottomBarButton(context, 'úkoly', Icons.task, '/mytasks', isSpecial: true),
          _buildBottomBarButton(context, 'chat', Icons.chat, '/chat'),
          _buildBottomBarButton(context, 'nastavení', Icons.settings, '/settings'),
        ],
      ),
    );
  }

  Widget _buildBottomBarButton(BuildContext context, String label, IconData icon, String route, {bool isSpecial = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isSpecial)
          Container(
            width: 64,
            height: 32,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 35, 74, 97),
              borderRadius: BorderRadius.circular(32),
            ),
            child: IconButton(
              icon: Icon(icon, size: 24, color: Colors.white),
              onPressed: () {
              },
            ),
          )
        else
          IconButton(
            icon: Icon(icon, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, route);
            },
          ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFFD7E2FF),
            fontSize: 12,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.50,
          ),
        ),
      ],
    );
  }
}
