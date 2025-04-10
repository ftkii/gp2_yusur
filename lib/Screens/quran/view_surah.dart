import '/Screens/quran/quran.dart';
import '/models/surah.dart';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart';

class ViewSurah extends StatefulWidget {
  var jsonData;
  ViewSurah({super.key, required this.jsonData});

  @override
  State<ViewSurah> createState() => _ViewSurahState();
}

class _ViewSurahState extends State<ViewSurah> {
  var searchQuery = "";
  var filteredData = [];
  bool isLoading = true;
  List<Surah> surahList = [];

  addFilteredData() async {
    await Future.delayed(const Duration(milliseconds: 600));
    setState(() {
      filteredData = widget.jsonData;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    filteredData = widget.jsonData;
    addFilteredData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Quran",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                  if (value == "") {
                    filteredData = widget.jsonData;
                    setState(() {});
                  }
                  if (searchQuery.length > 2 ||
                      searchQuery.toString().contains(" ")) {
                    setState(() {
                      filteredData =
                          widget.jsonData.where((sura) {
                            final suraName = sura["name"].toLowerCase();
                            final suraEnglishName =
                                sura["englishName"].toLowerCase();
                            return suraName.contains(
                                  searchQuery.toLowerCase(),
                                ) ||
                                suraEnglishName.contains(
                                  searchQuery.toLowerCase(),
                                );
                          }).toList();
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: "Search for Surah",
                  hintStyle: TextStyle(
                    color: Colors.black45,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Icon(Icons.search),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 78, 78, 78),
                      width: 2.1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder:
                    (context, index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Divider(color: Colors.grey),
                    ),

                itemCount: filteredData.length,
                itemBuilder: (context, index) {
                  String suraName = filteredData[index]["name"];
                  int suraNumberInQuran = filteredData[index]["number"];
                  String suraEnglishName = filteredData[index]["englishName"];
                  return Container(
                    child: ListTile(
                      leading: SizedBox(
                        height: 45,
                        width: 45,

                        child: Center(
                          child: Text(
                            suraNumberInQuran.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ),
                      ),
                      title: SizedBox(
                        width: 90,
                        child: Row(
                          children: [
                            Text(
                              suraName,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      subtitle: Text(
                        suraEnglishName,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: Text(
                        getPageNumber(suraNumberInQuran, 1).toString(),
                      ),
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (Builder) => Quran(
                                  pageNumber: getPageNumber(
                                    suraNumberInQuran,
                                    1,
                                  ),
                                  jsonData: widget.jsonData,
                                ),
                          ),
                        );
                      },
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
