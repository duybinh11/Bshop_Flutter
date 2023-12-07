import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RateStar extends StatelessWidget {
  RateStar({super.key, required this.rateAvg, required this.fixSize});
  double? rateAvg;
  double fixSize;

  int numberStar(double count) {
    return count.toInt();
  }

  bool checkInt(double count) {
    int countInt = count.toInt();
    if (count - countInt == 0) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return rateAvg == null
        ? SizedBox(
            height: fixSize,
          )
        : Row(
            children: [
              Text(
                rateAvg!.toStringAsFixed(1),
                style: TextStyle(
                    color: Colors.amber,
                    fontWeight: FontWeight.w500,
                    fontSize: fixSize),
              ),
              Row(
                children: List.generate(
                    numberStar(rateAvg as double),
                    (index) => Icon(
                          size: fixSize,
                          Icons.star,
                          color: Colors.amber,
                        )),
              ),
              checkInt(rateAvg!) == false
                  ? Icon(
                      Icons.star_half,
                      size: fixSize,
                      color: Colors.amber,
                    )
                  : const SizedBox(),
              Row(
                children: List.generate(
                    checkInt(rateAvg!) == true
                        ? 5 - numberStar(rateAvg!)
                        : 4 - numberStar(rateAvg!),
                    (index) => Icon(
                          size: fixSize,
                          Icons.star_border,
                          color: Colors.amber,
                        )),
              ),
            ],
          );
  }
}
