import 'package:flutter/material.dart';

//يوضح المهمام وحالتها هل هي مكتمله ويقدر يضغط عليها
class TaskTile extends StatelessWidget {
  final int stepNumber;
  final String title;
  final bool isCompleted;
  final bool isLast;
  final VoidCallback onTap;

  const TaskTile({
    super.key,
    required this.stepNumber,
    required this.title,
    required this.isCompleted,
    required this.isLast,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Positioned(
            left: 40,
            top: 0,
            bottom: isLast ? 20 : 0,
            child: Container(
              width: 2,
              color: const Color(0xFF8B7E6A),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: const Color(0xFFB7AD9F), width: 1.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: const Color(0xFFB7AD9F),
                          child: Text(
                            stepNumber.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(title,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        Icon(
                          isCompleted
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                          color: const Color(0xFFB7AD9F),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
