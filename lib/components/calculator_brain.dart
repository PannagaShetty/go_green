import 'package:gogreen/components/variables.dart';
import 'package:gogreen/constants.dart';

import 'variables.dart';
import 'variables.dart';
import 'variables.dart';
import 'variables.dart';
import 'variables.dart';
import 'variables.dart';
import 'variables.dart';

class CalculatorBrain {
  static void calculateFootprint() {
    electricityFootprint = eleValue * efEleValue;
    wasteFootprint = wasteValue * efWasteValue;
    wetWasteFootprint = wetWasteValue * efWetWasteValue;
    waterFootprint = waterValue * efWaterValue;
    lpgFootprint = lpgValue * efLpgValue;

    housingFootprint = (electricityFootprint +
            wasteFootprint +
            wetWasteFootprint +
            waterFootprint +
            lpgFootprint) /
        (5);
    housingFootprint = double.parse((housingFootprint).toStringAsFixed(2));

    bikeFootprint = efBikeValue * bikeValue;
    carFootprint = efCarValue * carValue;
    busFootprint = efBusValue * busValue;
    trainFootprint = efRailValue * railValue;
    aeroplaneFootprint = efAeroplaneValue * aeroplaneValue;
    travelFootprint = (bikeFootprint +
            carFootprint +
            busFootprint +
            trainFootprint +
            aeroplaneFootprint) /
        (5);
    travelFootprint = double.parse((travelFootprint).toStringAsFixed(2));

    meatFootprint = meatValue * efMeatValue;
    dairyFootprint = dairyValue * efDairyValue;
    vegetableFootprint = vegetableValue * efVegetableValue;
    fruitsFootprint = fruitsValue * efFruitsValue;
    snacksFootprint = (snacksValue / 1000) * efSnacksValue;
    drinksFootprint = drinksValue * efDrinksValue;
    grainFootprint = grainValue * efGrainsValue;
    foodFootprint = (meatFootprint +
            dairyFootprint +
            vegetableFootprint +
            fruitsFootprint +
            // snacksFootprint +
            // drinksFootprint +
            grainFootprint) /
        5;
    foodFootprint = double.parse((foodFootprint).toStringAsFixed(2));

    electricityFootprint = electricalValue;
    clothingFootprint = clothingValue;
    householdFootprint = householdValue;
    medicalFootprint = medicalValue;
    eWasteFootprint = eWasteValue;
    productFootprint = (electricityFootprint +
            clothingFootprint +
            householdFootprint +
            medicalFootprint +
            eWasteFootprint) /
        5;
    productFootprint = double.parse((productFootprint).toStringAsFixed(2));

    totalFootprint = (housingFootprint +
            travelFootprint +
            foodFootprint +
            productFootprint) /
        4;
    totalFootprint = double.parse((totalFootprint).toStringAsFixed(2));

    housingPercentage = totalFootprint != 0 ? housingFootprint / 100 : 0;
    travelPercentage = totalFootprint != 0 ? travelFootprint / 100 : 0;
    foodPercentage = totalFootprint != 0 ? foodFootprint / 100 : 0;
    productPercentage = totalFootprint != 0 ? productFootprint / 100 : 0;
  }
}
