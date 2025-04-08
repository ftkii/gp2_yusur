import 'package:flutter/material.dart';
import 'package:yusur_app/widget/arrow.dart';
import '/widget/fatwa_tile.dart';

class FatwaScreen extends StatelessWidget {
  const FatwaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Fatwas",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16, top: 16),
            child: ArrowIcon(),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: const [
                    FatwaTile(
                      title: 'Umrah for the Deceased',
                      content:
                          'The majority of scholars agree that performing Umrah on behalf of a deceased person is permissible, whether it is a voluntary act or an obligatory one.',
                    ),
                    FatwaTile(
                      title:
                          'Is It Permissible to Wear a Belt Over Ihram Garments?',
                      content:
                          'There is nothing wrong with wearing a belt while in ihram.',
                    ),
                    FatwaTile(
                      title: 'Is It Permissible for a Pilgrim to Use Perfume?',
                      content:
                          'It is not permissible for a person in the state of Ihram to apply perfume to the garment (Rida) and lower wrap (Izar).',
                    ),
                    FatwaTile(
                      title:
                          'Is It Permissible To Perform Hajj on Behalf Of a Living Person?',
                      content:
                          'Hajj is required if one is able, but if unable, then it is not obligatory.',
                    ),
                    FatwaTile(
                      title:
                          'What Are the Things Prohibited for a Person in Ihram for Hajj or Umrah?',
                      content:
                          'Cutting hair, trimming nails, applying perfume, wearing sewn clothes (for men), covering the head (for men), hunting, Al-Jima’a, and conducting a marriage contract.',
                    ),
                    FatwaTile(
                      title: 'What Are the Days of Tashreeq?',
                      content:
                          'They are the three days following the Day of Nahr, which are the 11th, 12th, and 13th of the month of Dhul-Hijjah.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
