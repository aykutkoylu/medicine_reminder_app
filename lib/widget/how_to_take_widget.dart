import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HowTheTakeWidget extends StatelessWidget {
  final Color colorPlate;
  final Color colorMedicine;
  final int left;
  final Function onPressed;
  const HowTheTakeWidget({
    Key? key,
    required this.colorPlate,
    required this.colorMedicine,
    required this.left,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Material(
        elevation: 8,
        shadowColor: Colors.black45,
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: Container(
            width: MediaQuery.of(context).size.width * .28,
            height: MediaQuery.of(context).size.height * .1,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.05),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                    child: FaIcon(
                  FontAwesomeIcons.utensils,
                  size: 28,
                  color: colorPlate,
                )),
                Positioned(
                    left: left.toDouble(), top: 30, child: CircleAvatar(minRadius: 4, backgroundColor: colorMedicine))
              ],
            )),
      ),
      onTap: () {
        onPressed.call();
      },
    );
  }
}
