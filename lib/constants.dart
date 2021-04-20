import 'package:flutter/material.dart';

const kPaddingInputContainer = EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0);

const kPaddingButton = EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0);

const kTextFieldDecoration = InputDecoration(
  hintText: '',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
const kInputBoxHeaderTextDecoration = TextStyle(
  color: Colors.white,
  fontSize: 22,
  fontWeight: FontWeight.bold,
);

const kInputBoxTextDecoration = TextStyle(
  fontSize: 18,
  color: Color(0xFF424242),
);

const kBackgroundColor = Color(0xFFF3F6FF);

const kInputBoxHeadingPadding = const EdgeInsets.all(10.0);

const kInputContainerDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
      topLeft: Radius.circular(15.0),
      bottomLeft: Radius.circular(15.0),
      bottomRight: Radius.circular(15.0),
      topRight: Radius.circular(15.0)),
  boxShadow: <BoxShadow>[
    BoxShadow(
        color: Color(0x80000000), offset: Offset(1.1, 1.1), blurRadius: 10.0),
  ],
);

const kInputTextColor = Colors.black;
const kDiscalimerTextStyle = TextStyle(
  color: Color(0x88000000),
);
const kLinkTextStyle = TextStyle(
  color: Colors.blue,
);

const double maxEleValue = 8000;
const double maxWaterValue = 500;
const double maxLpgValue = 100;
const double maxWasteValue = 200;
const double maxWetWasteValue = 200;
const double maxBikeValue = 1000;
const double maxBusValue = 1000;
const double maxCarValue = 1000;
const double maxRailValue = 5000;
const double maxAeroplaneValue = 5000;
const double maxMeatValue = 25;
const double maxDairyValue = 50;
const double maxVegetableValue = 25;
const double maxFruitsValue = 25;
const double maxSnacksValue = 7000;
const double maxDrinksValue = 30;
const double maxGrainValue = 100;
const double maxElectricalValue = 50000;
const double maxMedicalValue = 50000;
const double maxClothingValue = 50000;
const double maxHouseholdValue = 50000;

const int maxEleValueD = 4000;
const int maxWaterValueD = 500;
const int maxLpgValueD = 100;
const int maxWasteValueD = 100;
const int maxWetWasteValueD = 100;
const int maxBikeValueD = 500;
const int maxBusValueD = 500;
const int maxCarValueD = 500;
const int maxRailValueD = 2500;
const int maxAeroplaneValueD = 2500;
const int maxMeatValueD = 25;
const int maxDairyValueD = 50;
const int maxVegetableValueD = 25;
const int maxFruitsValueD = 25;
const int maxSnacksValueD = 7000;
const int maxDrinksValueD = 30;
const int maxGrainValueD = 100;
const int maxElectricalValueD = 25000;
const int maxMedicalValueD = 25000;
const int maxClothingValueD = 25000;
const int maxHouseholdValueD = 25000;

const double efEleValue = 1;
const double efWaterValue = 1;
const double efLpgValue = 1;
const double efWasteValue = 1;
const double efWetWasteValue = 1;
const double efBikeValue = 1;
const double efBusValue = 1;
const double efCarValue = 1;
const double efRailValue = 1;
const double efAeroplaneValue = 1;
const double efMeatValue = 1;
const double efDairyValue = 1;
const double efVegetableValue = 1;
const double efFruitsValue = 1;
const double efSnacksValue = 1;
const double efDrinksValue = 1;
const double efGrainsValue = 1;
const double efElectricalValue = 1;
const double efMedicalValue = 1;
const double efClothingValue = 1;
const double efHouseholdValue = 1;
const double efEwasteValue = 1;
