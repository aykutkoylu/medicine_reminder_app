import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_reminder_app/add_new_medicine_pages/add_new_medicine_page2.dart';
import 'package:medicine_reminder_app/widget/medicine_form_widget.dart';

class AddNewMedicinePage1 extends StatefulWidget {
  const AddNewMedicinePage1({Key? key}) : super(key: key);

  @override
  State<AddNewMedicinePage1> createState() => _AddNewMedicinePage1State();
}

class _AddNewMedicinePage1State extends State<AddNewMedicinePage1> {
  TextEditingController controller = TextEditingController();
  IconData icon = Icons.water_drop;
  List medicineformName = ['Drops', 'Capsules', 'Tablet'];
  List<IconData> medicineform = [Icons.water_drop, FontAwesomeIcons.capsules, FontAwesomeIcons.tablets];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 12),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 72,
            child: Row(
              children: [
                Spacer(),
                Text('Add New Medicine',
                    style: GoogleFonts.abel(
                      textStyle: TextStyle(fontSize: 24, color: Colors.black87, fontWeight: FontWeight.w600),
                    )),
                Spacer(),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: FaIcon(
                      FontAwesomeIcons.xmark,
                      color: Colors.grey[400],
                      size: 28,
                    )),
                SizedBox(width: 16),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 3,
                height: 5,
                color: Colors.cyan,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 3 * 2,
                height: 5,
                color: Colors.cyan[100],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 32,
                ),
                Text(
                  'Enter the name of medicine',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey[700]),
                ),
                SizedBox(height: 12),
                Container(
                  height: 56,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade500),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Center(
                      child: TextField(
                        maxLength: 24,
                        cursorHeight: 24,
                        cursorColor: Colors.black,
                        controller: controller,
                        decoration: InputDecoration.collapsed(hintText: ''),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Text(
                  'Choose a medicine form',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey[700]),
                ),
                SizedBox(height: 12),
                Container(
                  height: 112,
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: medicineformName.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, i) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: MedicineFormWidget(
                              icon: medicineform[i],
                              onPress: () {
                                icon = medicineform[i];
                                selectedIndex = i;
                                setState(() {});
                              },
                              pressedColor: selectedIndex == i ? Colors.redAccent : Colors.grey.shade300,
                              name: medicineformName[i],
                              pressedTextColor: selectedIndex == i ? Colors.white : Colors.grey.shade600),
                        );
                      }),
                ),
              ],
            ),
          ),
          Spacer(),
          InkWell(
            child: Container(
              width: 240,
              height: 40,
              decoration: BoxDecoration(color: Colors.cyan, borderRadius: BorderRadius.all(Radius.circular(40))),
              alignment: Alignment.center,
              child: Text(
                'Next >',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            onTap: () {
              if (controller.text.isNotEmpty)
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddNewMedicinePage2(
                              medicineForm: icon,
                              medicineName: controller.text,
                            )));
            },
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}
