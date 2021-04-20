import 'dart:core';

import 'package:flutter/material.dart';

String userName;
int totalPeopleInHouse = 1;
double eleValue = 0;
double waterValue = 0;
double lpgValue = 0;
double wasteValue = 0;
double wetWasteValue = 0;
double bikeValue = 0;
double busValue = 0;
double carValue = 0;
double railValue = 0;
double aeroplaneValue = 0;
double meatValue = 0;
double dairyValue = 0;
double vegetableValue = 0;
double fruitsValue = 0;
double snacksValue = 0;
double drinksValue = 0;
double grainValue = 0;
double electricalValue = 0;
double medicalValue = 0;
double clothingValue = 0;
double householdValue = 0;
double eWasteValue = 0;

bool housingContainerVisibility = true;

bool travelContainerVisibility = false;

bool foodContainerVisibility = false;

bool productContainerVisibility = false;

int containerCount = 1;

double electricityFootprint = 0;
double waterFootprint = 0;
double lpgFootprint = 0;
double wasteFootprint = 0;
double wetWasteFootprint = 0;

double bikeFootprint = 0;
double carFootprint = 0;
double busFootprint = 0;
double trainFootprint = 0;
double aeroplaneFootprint = 0;

double meatFootprint = 0;
double dairyFootprint = 0;
double vegetableFootprint = 0;
double fruitsFootprint = 0;
double snacksFootprint = 0;
double drinksFootprint = 0;
double grainFootprint = 0;

double electricalFootprint = 0;
double householdFootprint = 0;
double clothingFootprint = 0;
double medicalFootprint = 0;
double eWasteFootprint = 0;

double housingFootprint = 0;
double travelFootprint = 0;
double foodFootprint = 0;
double productFootprint = 0;

double totalFootprint = 0;

double housingPercentage = 0;
double travelPercentage = 0;
double foodPercentage = 0;
double productPercentage = 0;

double userLatitude = 0;
double userLongitude = 0;

class Reset {
  static void reset() {
    totalPeopleInHouse = 1;
    eleValue = 0;
    waterValue = 0;
    lpgValue = 0;
    wasteValue = 0;
    wetWasteValue = 0;
    bikeValue = 0;
    busValue = 0;
    carValue = 0;
    railValue = 0;
    aeroplaneValue = 0;
    meatValue = 0;
    dairyValue = 0;
    vegetableValue = 0;
    fruitsValue = 0;
    snacksValue = 0;
    drinksValue = 0;
    grainValue = 0;
    electricalValue = 0;
    medicalValue = 0;
    clothingValue = 0;
    householdValue = 0;
    eWasteValue = 0;
    housingContainerVisibility = true;
    travelContainerVisibility = false;
    foodContainerVisibility = false;
    productContainerVisibility = false;
    containerCount = 1;
  }
}
