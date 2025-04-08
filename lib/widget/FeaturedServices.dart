import 'package:flutter/material.dart';

class FeaturedService extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const FeaturedService({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 500,
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, // عدد الأعمدة (مربعات في كل صف)
            crossAxisSpacing: 10, // المسافة الأفقية بين المربعات
            mainAxisSpacing: 10, // المسافة العمودية بين المربعات
            childAspectRatio: 4, // نسبة العرض إلى الارتفاع لكل مربع
          ),
          itemCount: items.length + 1, // عدد المربعات بناءً على القائمة
          itemBuilder: (context, index) {
            if (index == items.length) {
              // عنصر أخير لإضافة مساحة
              return const SizedBox(
                height: 50,
              );
            }
            final item = items[index];
            return GestureDetector(
              onTap: () {
                // عند الضغط على العنصر
                Navigator.push(
                    context,
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => item['page'],
                      ),
                    ) as Route<Object?>);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 243, 243, 243),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0xffffD9D9D9), // لون الـ stroke (الحدود)
                    width: 2, // سماكة الـ stroke
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset(
                            item["image"],
                            width: 50,
                            height: 50,
                          ),
                          SizedBox(
                            width: 60,
                          ),
                          Text(
                            item['text'],
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
