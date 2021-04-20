import 'package:gogreen/components/variables.dart';
import 'package:gogreen/constants.dart';

class CalculatorBrain {
  static void calculateFootprint() {
    electricityFootprint = (eleValue / 7) * 12 * efEleValue;
    wasteFootprint = wasteValue * efWasteValue * 52;
    wetWasteFootprint = wetWasteValue*efWetWasteValue*52;
    waterFootprint = waterValue * 365 * efWaterValue;
    lpgFootprint = lpgValue * efLpgValue * 12;

    housingFootprint = (electricityFootprint +
            wasteFootprint +wetWasteFootprint+
            waterFootprint +
            lpgFootprint) /
        (totalPeopleInHouse * 1000);
    housingFootprint = double.parse((housingFootprint).toStringAsFixed(2));

    bikeFootprint = efBikeValue * 365 * bikeValue;
    carFootprint = efCarValue * 365 * carValue;
    busFootprint = efBusValue * 365 * busValue;
    trainFootprint = efRailValue * 12 * railValue;
    aeroplaneFootprint = efAeroplaneValue * 12 * aeroplaneValue;
    travelFootprint = (bikeFootprint +
            carFootprint +
            busFootprint +
            trainFootprint +
            aeroplaneFootprint) /
        (1000);
    travelFootprint = double.parse((travelFootprint).toStringAsFixed(2));

    meatFootprint = meatValue * efMeatValue * 52;
    dairyFootprint = dairyValue * efDairyValue * 52;
    vegetableFootprint = vegetableValue * 52 * efVegetableValue;
    fruitsFootprint = fruitsValue * 52 * efFruitsValue;
    snacksFootprint = (snacksValue / 1000) * 52 * efSnacksValue;
    drinksFootprint = drinksValue * 52 * efDrinksValue;
    grainFootprint = grainValue * 52 * efGrainsValue;
    foodFootprint = (meatFootprint +
            dairyFootprint +
            vegetableFootprint +
            fruitsFootprint +
            snacksFootprint +
            drinksFootprint +
            grainFootprint) /
        1000;
    foodFootprint = double.parse((foodFootprint).toStringAsFixed(2));

    electricityFootprint = 0;
    clothingFootprint = 0;
    householdFootprint = 0;
    medicalFootprint = 0;
    productFootprint = (electricityFootprint +
            clothingFootprint +
            householdFootprint +
            medicalFootprint) /
        100;
    productFootprint = double.parse((productFootprint).toStringAsFixed(2));

    totalFootprint =
        housingFootprint + travelFootprint + foodFootprint + productFootprint;
    totalFootprint = double.parse((totalFootprint).toStringAsFixed(2));

    housingPercentage =
        totalFootprint != 0 ? housingFootprint / totalFootprint : 0;
    travelPercentage =
        totalFootprint != 0 ? travelFootprint / totalFootprint : 0;
    foodPercentage = totalFootprint != 0 ? foodFootprint / totalFootprint : 0;
    productPercentage =
        totalFootprint != 0 ? productFootprint / totalFootprint : 0;
  }
}
