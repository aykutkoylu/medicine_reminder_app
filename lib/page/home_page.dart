import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medicine_reminder_app/add_new_medicine_pages/add_new_medicine_page1.dart';
import 'package:medicine_reminder_app/classes/medicine.dart';
import 'package:medicine_reminder_app/medicine_data.dart';
import 'package:medicine_reminder_app/widget/Dates_widget.dart';
import 'package:medicine_reminder_app/widget/medicine_card_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndexBottomBar = 0;
  int date = 0;
  int selectedIndex = 0;
  var now = DateTime.now();
  var day = [];
  var weekName = [];
  var weekNameReversed = [];
  int selectedDay = 1;

  @override
  void initState() {
    dayAndWeek();
    super.initState();
  }

  void dayAndWeek() {
    for (int i = date; i > date - 7; i--)
      day.add(DateTime(now.year, now.month, 1).subtract(Duration(days: i)).day.toString());
    for (int i = date + 1; i < date + 8; i++)
      weekName.add(DateFormat.E().format(DateTime.now().subtract(Duration(days: i)))[0]);
    weekNameReversed.addAll(weekName.reversed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                elevation: 8,
                child: Container(
                  width: double.infinity,
                  height: 88,
                  child: Row(
                    children: [
                      Spacer(),
                      Text('Today\'s Meds',
                          style: GoogleFonts.abel(
                            textStyle: TextStyle(fontSize: 24, color: Colors.black87, fontWeight: FontWeight.w600),
                          )),
                      Spacer(),
                      Icon(
                        Icons.date_range,
                        color: Colors.grey,
                        size: 32,
                      ),
                      SizedBox(width: 12),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Text(
                          '${DateFormat.MMMM().format(DateTime.now().subtract(Duration(days: date)))}, ${DateFormat.y().format(DateTime.now().subtract(Duration(days: date)))}',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        Spacer(),
                        InkWell(
                          child: Icon(Icons.arrow_back_ios),
                          onTap: () {
                            selectedIndex = 0;
                            day.clear();
                            weekName.clear();
                            weekNameReversed.clear();
                            date = date + 7;
                            dayAndWeek();
                            setState(() {});
                          },
                        ),
                        SizedBox(width: 12),
                        InkWell(
                          child: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            selectedIndex = 0;
                            day.clear();
                            weekName.clear();
                            date = date - 7;
                            dayAndWeek();
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Container(
                      height: 64,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          itemCount: day.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, i) {
                            selectedIndex == i ? selectedDay = -int.parse(day[i]) : '';

                            return Padding(
                                padding: const EdgeInsets.only(left: 4, right: 4),
                                child: DatesWidget(
                                  day: day[i],
                                  weekName: weekNameReversed[i],
                                  onPress: () {
                                    selectedIndex = i;
                                    setState(() {});
                                  },
                                  pressedColor: selectedIndex == i ? Colors.cyan : Colors.grey.shade300,
                                  pressedTextColor: selectedIndex == i ? Colors.white : Colors.grey.shade600,
                                ));
                          }),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 380,
                      width: double.infinity,
                      child: ListView.builder(
                          itemCount: medicineData.length,
                          itemBuilder: (_, i) {
                            return Padding(
                                padding: const EdgeInsets.all(12),
                                child: MedicineCardWidget(medicine: medicineData[i]));
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                elevation: 12,
                iconSize: 28,
                unselectedItemColor: Colors.grey.shade600,
                selectedItemColor: Colors.cyan,
                currentIndex: selectedIndexBottomBar,
                onTap: (index) {
                  selectedIndexBottomBar = index;
                  setState(() {});
                },
                items: [
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.clock),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.kitMedical),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.settings,
                      size: 32,
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.info,
                      size: 30,
                    ),
                    label: '',
                  ),
                ]),
          ),
          Positioned(
            bottom: 32,
            left: (MediaQuery.of(context).size.width - 64) / 2,
            child: InkWell(
              child: Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(color: Colors.redAccent.shade100, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              onTap: () {
                Navigator.push((context), MaterialPageRoute(builder: (context) => AddNewMedicinePage1()))
                    .then((value) => setState(() {}));
              },
            ),
          ),
        ],
      ),
    );
  }
}
