import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran/quran.dart' as quran;
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../widget/arrow.dart';
import 'header_widget.dart';
import 'view_surah.dart';

class Quran extends StatefulWidget {
  var pageNumber;
  var jsonData;

  Quran({super.key, required this.pageNumber, required this.jsonData});

  @override
  State<Quran> createState() => _QuranState();
}

class _QuranState extends State<Quran> {
  String getVerseQCF(int start, int i) {
    return quran.getVerse(start, i, verseEndSymbol: true).trim();
  }

  int index = 0;
  late PageController _pageController;

  setIndex() {
    setState(() {
      index = widget.pageNumber;
    });
  }

  @override
  void initState() {
    setIndex();
    _pageController = PageController(initialPage: index);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]); //  تحديد الاتجاه الافتراضي للشاشة
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    ); // تحديد الوضع الافتراضي للشاشة
    WakelockPlus.enable(); // تفعيل الشاشة
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    ); // تحديد الوضع الافتراضي للشاشة
    WakelockPlus.disable(); // تعطيل الشاشة
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: PageView.builder(
        reverse: true,
        scrollDirection: Axis.horizontal,

        controller: _pageController,
        itemCount: quran.totalPagesCount,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              color: Color(0xffFFFCE7),
              child: Image.asset(
                "images/quranImages/quran.jpg", // for the cover page
                fit: BoxFit.fill,
              ),
            );
          }
          return Container(
            width: double.infinity,
            height: screenSize.height,
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 218, 211, 201),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(right: 12, left: 12),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 55,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 159, 149, 134),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Color.fromARGB(255, 0, 0, 0),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10, top: 5),
                                child: ArrowIcon(
                                  //prePage: ViewSurah(jsonData: widget.jsonData),
                                ),
                              ),

                              if (index != 0)
                                Padding(
                                  padding: EdgeInsets.only(right: 15, top: 5),
                                  child: Text(
                                    widget.jsonData[quran.getPageData(
                                          index,
                                        )[0]["surah"] -
                                        1]["name"], // name of the surah
                                    style: const TextStyle(fontSize: 18),
                                    textAlign:
                                        TextAlign
                                            .start, //put it to the left side
                                  ),
                                ),
                              if (index == 0)
                                Text(
                                  "Quran", //for the cover page
                                  style: const TextStyle(fontSize: 14),
                                  textAlign: TextAlign.start,
                                ),
                            ],
                          ),
                        ),

                        if ((index == 1 || index == 2))
                          SizedBox(height: (screenSize.height * .15)),
                        SizedBox(height: 30),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Padding(
                            padding: EdgeInsets.zero,
                            child: SizedBox(
                              width: double.infinity,
                              child: RichText(
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.justify,
                                softWrap: true,
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 30,
                                    color: Colors.black,
                                  ),
                                  children:
                                      quran.getPageData(index).expand((e) {
                                        List<InlineSpan> spans = [];
                                        for (
                                          var i = e["start"];
                                          i <= e["end"];
                                          i++
                                        ) {
                                          if (i == 1) {
                                            spans.add(
                                              WidgetSpan(
                                                child: HeaderWidget(
                                                  e: e,
                                                  jsonData: widget.jsonData,
                                                ),
                                              ),
                                            );
                                            if (index != 187 && index != 1) {
                                              spans.add(
                                                WidgetSpan(
                                                  child: Container(
                                                    // al basmala
                                                    width: double.infinity,
                                                    child: Text(
                                                      quran.basmala,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        height: 1.75,
                                                        letterSpacing: 0,
                                                        wordSpacing: 0,
                                                        fontFamily: "Uthmanic",
                                                        fontSize: 23.9,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }

                                            if (index == 187) {
                                              spans.add(
                                                WidgetSpan(
                                                  child: Container(height: 10),
                                                ),
                                              );
                                            }
                                          }
                                          spans.add(
                                            TextSpan(
                                              text:
                                                  i == e["start"]
                                                      ? "${getVerseQCF(e["surah"], i).replaceAll("  ", "").substring(0, 1)}${getVerseQCF(e["surah"], i).replaceAll("  ", "").substring(1)}"
                                                      : getVerseQCF(
                                                        e["surah"],
                                                        i,
                                                      ).replaceAll('  ', ''),
                                              style: TextStyle(
                                                color: Colors.black,
                                                height:
                                                    (index == 1 || index == 2)
                                                        ? 2
                                                        : 1.95,
                                                letterSpacing: 0,
                                                wordSpacing: 0,
                                                fontFamily: "Uthmanic",
                                                fontSize:
                                                    index == 1 || index == 2
                                                        ? 28
                                                        : index == 145 ||
                                                            index == 201
                                                        ? index == 532 ||
                                                                index == 533
                                                            ? 24.5
                                                            : 24.4
                                                        : 24.9,
                                              ),
                                            ),
                                          );
                                        }
                                        return spans;
                                      }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // page number
                        Container(
                          width: 60,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 194, 194, 194),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "$index",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
