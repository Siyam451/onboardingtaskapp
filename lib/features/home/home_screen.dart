import 'package:flutter/material.dart';

import '../../common-widgets/app_gradient_bacground_widget.dart';

class HomeScreen extends StatefulWidget {
  final String location;

  const HomeScreen({
    super.key,
    required this.location,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> alarms = [];

  void addAlarm() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    setState(() {
      alarms.add({
        'time': time.format(context),
        'date': DateTime.now().toString().split(' ')[0],
        'enabled': true,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2196F3),
        onPressed: addAlarm,
        child: const Icon(Icons.add),
      ),

      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text(
                  'Selected Location',
                  style: TextStyle(color: Colors.white70),
                ),

                const SizedBox(height: 8),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.location,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'Alarms',
                  style: TextStyle(color: Colors.white70),
                ),

                const SizedBox(height: 12),

                Expanded(
                  child: ListView.builder(
                    itemCount: alarms.length,
                    itemBuilder: (_, i) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(20),
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  alarms[i]['time'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  alarms[i]['date'],
                                  style: const TextStyle(
                                    color: Colors.white54,
                                  ),
                                ),
                              ],
                            ),

                            Switch(
                              value: alarms[i]['enabled'],
                              onChanged: (v) {
                                setState(() {
                                  alarms[i]['enabled'] = v;
                                });
                              },
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
