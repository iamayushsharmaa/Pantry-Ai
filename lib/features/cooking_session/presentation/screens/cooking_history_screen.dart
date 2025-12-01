import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CookingHistoryScreen extends StatelessWidget {
  const CookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cooking History')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users/current_user_id/analytics/cooking')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());
          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final completed = data['completed'] ?? false;
              final duration = data['durationMinutes'] ?? 0;
              return ListTile(
                leading: Icon(
                  completed ? Icons.check_circle : Icons.schedule,
                  color: completed ? Colors.green : Colors.orange,
                ),
                title: Text('Recipe ${data['recipeId']}'),
                subtitle: Text(
                  'Duration: $duration min • Completed: $completed',
                ),
                trailing: Text(
                  DateTime.fromMillisecondsSinceEpoch(
                    (data['timestamp'] as Timestamp).millisecondsSinceEpoch,
                  ).toString().split(' ')[0],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
