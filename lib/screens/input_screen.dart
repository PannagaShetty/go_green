import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:gogreen/components/slider.dart';
import 'package:gogreen/constants.dart';
import 'package:gogreen/components/round_icon_button.dart';
import 'package:gogreen/components/variables.dart';
import 'package:gogreen/components/custom_button.dart';
import 'package:gogreen/components/input_text.dart';
import 'package:gogreen/icon_constants.dart';
import 'package:gogreen/screens/result_screen.dart';
import 'package:gogreen/components/input_container_heading.dart';
import 'package:geolocator/geolocator.dart';

import 'package:location_permissions/location_permissions.dart';
import 'package:app_settings/app_settings.dart';

class InputScreen extends StatefulWidget {
  static String id = 'input_screen';

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  ScrollController _scrollController = new ScrollController();
  bool locEnabled = true;
  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  Future<void> getCurrentLocation() async {
    try {
      ServiceStatus serviceStatus =
          await LocationPermissions().checkServiceStatus();
      print(serviceStatus);
      if (serviceStatus == ServiceStatus.disabled) {
        AppSettings.openLocationSettings();
        setState(() {
          locEnabled = false;
        });
      } else {
        setState(() {
          locEnabled = true;
        });
      }
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

      userLatitude = position.latitude;
      userLongitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          elevation: 0.0,
          title: Text(
            "Go Green",
            style: TextStyle(
              fontSize: 28,
              color: kInputTextColor,
              fontFamily: 'Pacifico',
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: kBackgroundColor,
        body: locEnabled == false
            ? Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Enable Location',
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                      CustomButton(
                        inputText: 'Enabled',
                        onPress: () {
                          getCurrentLocation();
                        },
                      )
                    ],
                  ),
                ),
              )
            : Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Part(${containerCount.toString()} of 4)',
                      style: TextStyle(
                        color: kInputTextColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 45,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: <Widget>[
                          //housing container
                          Visibility(
                            visible: housingContainerVisibility,
                            child: Padding(
                              padding: kPaddingInputContainer,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    InputHeadingContainer(
                                      text: 'Housing',
                                      image: AssetImage('images/house1.jpg'),
                                      fontSize: 25.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        // InputText(
                                        //   text:
                                        //       'Total Number of People in the House',
                                        // ),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.center,
                                        //   children: <Widget>[
                                        //     RoundIconButton(
                                        //       buttonIcon: Icons.remove,
                                        //       onPress: () {
                                        //         setState(() {
                                        //           if (totalPeopleInHouse > 1) {
                                        //             totalPeopleInHouse--;
                                        //           }
                                        //         });
                                        //       },
                                        //     ),
                                        //     Text(
                                        //       totalPeopleInHouse.toString(),
                                        //       style: kInputBoxTextDecoration,
                                        //     ),
                                        //     RoundIconButton(
                                        //       buttonIcon: Icons.add,
                                        //       onPress: () {
                                        //         setState(() {
                                        //           totalPeopleInHouse++;
                                        //         });
                                        //       },
                                        //     ),
                                        //   ],
                                        // ),

                                        InputText(
                                          text:
                                              'Your Average Monthly Electricity Bill Amount (in Rupees)',
                                        ),
                                        CustomSlider(
                                          icon: kElectricityIcon,
                                          max: maxEleValue,
                                          min: 0.0,
                                          value: eleValue,
                                          division: maxEleValueD,
                                          unit: '₹',
                                          onPress: (value) {
                                            setState(
                                              () {
                                                eleValue = value;
                                              },
                                            );
                                          },
                                          onPressPlus: () {
                                            setState(() {
                                              eleValue++;
                                            });
                                          },
                                          onPressMinus: () {
                                            setState(() {
                                              if (eleValue > 0) {
                                                eleValue--;
                                              }
                                            });
                                          },
                                        ),
                                        InputText(
                                          text:
                                              'Average consumption of Water per day in House(in Liters)',
                                        ),
                                        CustomSlider(
                                          value: waterValue,
                                          min: 0.0,
                                          max: maxWaterValue,
                                          icon: kWaterIcon,
                                          unit: 'L',
                                          onPress: (value) {
                                            setState(
                                              () {
                                                waterValue = value;
                                              },
                                            );
                                          },
                                          onPressPlus: () {
                                            setState(() {
                                              waterValue++;
                                            });
                                          },
                                          onPressMinus: () {
                                            setState(() {
                                              if (waterValue > 0) {
                                                waterValue--;
                                              }
                                            });
                                          },
                                          division: maxWaterValueD,
                                        ),
                                        InputText(
                                          text:
                                              'Average Amount of LPG used per month (in Kg)',
                                        ),
                                        CustomSlider(
                                          division: maxLpgValueD,
                                          min: 0.0,
                                          max: maxLpgValue,
                                          icon: kLpgIcon,
                                          unit: 'kg',
                                          value: lpgValue,
                                          onPress: (value) {
                                            setState(
                                              () {
                                                lpgValue = value;
                                              },
                                            );
                                          },
                                          onPressPlus: () {
                                            setState(() {
                                              lpgValue++;
                                            });
                                          },
                                          onPressMinus: () {
                                            setState(() {
                                              if (lpgValue > 0) {
                                                lpgValue--;
                                              }
                                            });
                                          },
                                        ),
                                        InputText(
                                          text:
                                              'Average Amount of Dry Waste Dumped per week (in Kg)',
                                        ),
                                        CustomSlider(
                                          division: maxWasteValueD,
                                          min: 0.0,
                                          max: maxWasteValue,
                                          icon: kWasteIcon,
                                          unit: 'kg',
                                          value: wasteValue,
                                          onPress: (value) {
                                            setState(
                                              () {
                                                wasteValue = value;
                                              },
                                            );
                                          },
                                          onPressPlus: () {
                                            setState(() {
                                              wasteValue++;
                                            });
                                          },
                                          onPressMinus: () {
                                            setState(() {
                                              if (wasteValue > 0) {
                                                wasteValue--;
                                              }
                                            });
                                          },
                                        ),
                                        InputText(
                                          text:
                                              'Average Amount of Wet Waste Dumped per week (in Kg)',
                                        ),
                                        CustomSlider(
                                          division: maxWetWasteValueD,
                                          min: 0.0,
                                          max: maxWetWasteValue,
                                          icon: kWetWasteIcon,
                                          unit: 'kg',
                                          value: wetWasteValue,
                                          onPress: (value) {
                                            setState(
                                              () {
                                                wetWasteValue = value;
                                              },
                                            );
                                          },
                                          onPressPlus: () {
                                            setState(() {
                                              wetWasteValue++;
                                            });
                                          },
                                          onPressMinus: () {
                                            setState(() {
                                              if (wetWasteValue > 0) {
                                                wetWasteValue--;
                                              }
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        CustomButton(
                                          inputText: '< Previous',
                                          onPress: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        CustomButton(
                                          inputText: 'Next >',
                                          onPress: () {
                                            setState(() {
                                              travelContainerVisibility = true;
                                              housingContainerVisibility =
                                                  false;
                                              containerCount = 2;
                                            });
                                            _scrollController.animateTo(
                                              0.0,
                                              curve: Curves.easeOut,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    //housing container end
                                  ],
                                ),
                                decoration: kInputContainerDecoration,
                              ),
                            ),
                          ),
                          //housing container end

                          //travel container
                          Visibility(
                            visible: travelContainerVisibility,
                            child: Padding(
                              padding: kPaddingInputContainer,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    InputHeadingContainer(
                                      text: 'Travel',
                                      image: AssetImage('images/traffic.jpg'),
                                      fontSize: 25.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        InputText(
                                          text:
                                              'Average Distance travelled in Bike per Day (in KM)',
                                        ),
                                        CustomSlider(
                                          icon: kBikeIcon,
                                          max: maxBikeValue,
                                          min: 0.0,
                                          value: bikeValue,
                                          division: maxBikeValueD,
                                          unit: 'km',
                                          onPress: (value) {
                                            setState(
                                              () {
                                                bikeValue = value;
                                              },
                                            );
                                          },
                                          onPressPlus: () {
                                            setState(() {
                                              bikeValue++;
                                            });
                                          },
                                          onPressMinus: () {
                                            setState(() {
                                              if (bikeValue > 0) {
                                                bikeValue--;
                                              }
                                            });
                                          },
                                        ),
                                        InputText(
                                          text:
                                              'Average Distance travelled in Car per Day (in KM)',
                                        ),
                                        CustomSlider(
                                          value: carValue,
                                          min: 0.0,
                                          max: maxCarValue,
                                          icon: kCarIcon,
                                          unit: 'km',
                                          onPress: (value) {
                                            setState(
                                              () {
                                                carValue = value;
                                              },
                                            );
                                          },
                                          division: maxCarValueD,
                                          onPressPlus: () {
                                            setState(() {
                                              carValue++;
                                            });
                                          },
                                          onPressMinus: () {
                                            setState(() {
                                              if (carValue > 0) {
                                                carValue--;
                                              }
                                            });
                                          },
                                        ),
                                        InputText(
                                          text:
                                              'Average Distance travelled in Bus per Day (in KM)',
                                        ),
                                        CustomSlider(
                                          division: maxBusValueD,
                                          min: 0.0,
                                          max: maxBusValue,
                                          icon: kBusIcon,
                                          unit: 'km',
                                          value: busValue,
                                          onPress: (value) {
                                            setState(
                                              () {
                                                busValue = value;
                                              },
                                            );
                                          },
                                          onPressPlus: () {
                                            setState(() {
                                              busValue++;
                                            });
                                          },
                                          onPressMinus: () {
                                            setState(() {
                                              if (busValue > 0) {
                                                busValue--;
                                              }
                                            });
                                          },
                                        ),
                                        InputText(
                                          text:
                                              'Average Distance travelled in Rail per Month (in KM)',
                                        ),
                                        CustomSlider(
                                          division: maxRailValueD,
                                          min: 0.0,
                                          max: maxRailValue,
                                          icon: kTrainIcon,
                                          unit: 'km',
                                          value: railValue,
                                          onPress: (value) {
                                            setState(
                                              () {
                                                railValue = value;
                                              },
                                            );
                                          },
                                          onPressPlus: () {
                                            setState(() {
                                              railValue++;
                                            });
                                          },
                                          onPressMinus: () {
                                            setState(() {
                                              if (railValue > 0) {
                                                railValue--;
                                              }
                                            });
                                          },
                                        ),
                                        InputText(
                                          text:
                                              'Average Distance travelled in Aeroplane per Month (in KM)',
                                        ),
                                        CustomSlider(
                                          division: maxAeroplaneValueD,
                                          min: 0.0,
                                          max: maxAeroplaneValue,
                                          icon: kAeroplaneIcon,
                                          unit: 'km',
                                          value: aeroplaneValue,
                                          onPress: (value) {
                                            setState(
                                              () {
                                                aeroplaneValue = value;
                                              },
                                            );
                                          },
                                          onPressPlus: () {
                                            setState(() {
                                              aeroplaneValue++;
                                            });
                                          },
                                          onPressMinus: () {
                                            setState(() {
                                              if (aeroplaneValue > 0) {
                                                aeroplaneValue--;
                                              }
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        CustomButton(
                                          inputText: '< Previous',
                                          onPress: () {
                                            setState(() {
                                              housingContainerVisibility = true;
                                              travelContainerVisibility = false;
                                              containerCount = 1;
                                            });
                                            _scrollController.animateTo(
                                              0.0,
                                              curve: Curves.easeOut,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                            );
                                          },
                                        ),
                                        CustomButton(
                                          inputText: 'Next >',
                                          onPress: () {
                                            setState(() {
                                              travelContainerVisibility = false;
                                              foodContainerVisibility = true;
                                              containerCount = 3;
                                            });
                                            _scrollController.animateTo(
                                              0.0,
                                              curve: Curves.easeOut,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    //housing container end
                                  ],
                                ),
                                decoration: kInputContainerDecoration,
                              ),
                            ),
                          ),
                          //travel container end

                          //Food container
                          Visibility(
                            visible: foodContainerVisibility,
                            child: Padding(
                              padding: kPaddingInputContainer,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    InputHeadingContainer(
                                      text: 'Food',
                                      image: AssetImage('images/food.jpg'),
                                      fontSize: 25.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        InputText(
                                          text:
                                              'Average amount of Meat consumed per week (in kg)',
                                        ),
                                        CustomSlider(
                                          icon: kMeatIcon,
                                          max: maxMeatValue,
                                          min: 0.0,
                                          value: meatValue,
                                          division: maxMeatValueD,
                                          unit: 'kg',
                                          onPress: (value) {
                                            setState(
                                              () {
                                                meatValue = value;
                                              },
                                            );
                                          },
                                          onPressPlus: () {
                                            setState(() {
                                              meatValue++;
                                            });
                                          },
                                          onPressMinus: () {
                                            setState(() {
                                              if (meatValue > 0) {
                                                meatValue--;
                                              }
                                            });
                                          },
                                        ),
                                        InputText(
                                          text:
                                              'Average amount of Dairy Products consumed per week (in Liters)',
                                        ),
                                        CustomSlider(
                                          value: dairyValue,
                                          min: 0.0,
                                          max: maxDairyValue,
                                          icon: kDairyIcon,
                                          unit: 'L',
                                          onPress: (value) {
                                            setState(
                                              () {
                                                dairyValue = value;
                                              },
                                            );
                                          },
                                          division: maxDairyValueD,
                                          onPressPlus: () {
                                            setState(() {
                                              dairyValue++;
                                            });
                                          },
                                          onPressMinus: () {
                                            setState(() {
                                              if (dairyValue > 0) {
                                                dairyValue--;
                                              }
                                            });
                                          },
                                        ),
                                        InputText(
                                          text:
                                              'Average amount of Vegetables consumed per week (in kg)',
                                        ),
                                        CustomSlider(
                                          division: maxVegetableValueD,
                                          min: 0.0,
                                          max: maxVegetableValue,
                                          icon: kVegetablesIcon,
                                          unit: 'kg',
                                          value: vegetableValue,
                                          onPress: (value) {
                                            setState(
                                              () {
                                                vegetableValue = value;
                                              },
                                            );
                                          },
                                          onPressPlus: () {
                                            setState(() {
                                              vegetableValue++;
                                            });
                                          },
                                          onPressMinus: () {
                                            setState(() {
                                              if (vegetableValue > 0) {
                                                vegetableValue--;
                                              }
                                            });
                                          },
                                        ),
                                        InputText(
                                          text:
                                              'Average amount of Fruits consumed per week (in kg)',
                                        ),
                                        CustomSlider(
                                          division: maxFruitsValueD,
                                          min: 0.0,
                                          max: maxFruitsValue,
                                          icon: kFruitsIcon,
                                          unit: 'kg',
                                          value: fruitsValue,
                                          onPress: (value) {
                                            setState(
                                              () {
                                                fruitsValue = value;
                                              },
                                            );
                                          },
                                          onPressPlus: () {
                                            setState(() {
                                              fruitsValue++;
                                            });
                                          },
                                          onPressMinus: () {
                                            setState(() {
                                              if (fruitsValue > 0) {
                                                fruitsValue--;
                                              }
                                            });
                                          },
                                        ),
                                        InputText(
                                          text:
                                              'Average amount of Grains consumed per week(in kg)',
                                        ),
                                        CustomSlider(
                                          division: maxGrainValueD,
                                          min: 0.0,
                                          max: maxGrainValue,
                                          icon: kGrainIcon,
                                          unit: 'kg',
                                          value: grainValue,
                                          onPress: (value) {
                                            setState(
                                              () {
                                                grainValue = value;
                                              },
                                            );
                                          },
                                          onPressPlus: () {
                                            setState(() {
                                              grainValue++;
                                            });
                                          },
                                          onPressMinus: () {
                                            setState(() {
                                              if (grainValue > 0) {
                                                grainValue--;
                                              }
                                            });
                                          },
                                        ),
                                        InputText(
                                          text:
                                              'Average amount of Snacks consumed per week (in Grams)',
                                        ),
                                        CustomSlider(
                                          division: maxSnacksValueD,
                                          min: 0.0,
                                          max: maxSnacksValue,
                                          icon: kSnacksIcon,
                                          unit: 'g',
                                          value: snacksValue,
                                          onPress: (value) {
                                            setState(
                                              () {
                                                snacksValue = value;
                                              },
                                            );
                                          },
                                          onPressPlus: () {
                                            setState(() {
                                              snacksValue++;
                                            });
                                          },
                                          onPressMinus: () {
                                            setState(() {
                                              if (snacksValue > 0) {
                                                snacksValue--;
                                              }
                                            });
                                          },
                                        ),
                                        InputText(
                                          text:
                                              'Average amount of Soft Drinks consumed per week (in Liters)',
                                        ),
                                        CustomSlider(
                                          value: drinksValue,
                                          min: 0.0,
                                          max: maxDrinksValue,
                                          icon: kDrinksIcon,
                                          unit: 'L',
                                          onPress: (value) {
                                            setState(
                                              () {
                                                drinksValue = value;
                                              },
                                            );
                                          },
                                          division: maxDrinksValueD,
                                          onPressPlus: () {
                                            setState(() {
                                              drinksValue++;
                                            });
                                          },
                                          onPressMinus: () {
                                            setState(() {
                                              if (drinksValue > 0) {
                                                drinksValue--;
                                              }
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        CustomButton(
                                          inputText: '< Previous',
                                          onPress: () {
                                            setState(() {
                                              foodContainerVisibility = false;
                                              travelContainerVisibility = true;
                                              containerCount = 2;
                                            });
                                            _scrollController.animateTo(
                                              0.0,
                                              curve: Curves.easeOut,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                            );
                                          },
                                        ),
                                        CustomButton(
                                          inputText: 'Next >',
//                                    onPress: () {
//                                      setState(() {
//                                        foodContainerVisibility = false;
//                                        productContainerVisibility = true;
//                                        containerCount = 4;
//                                      });
//                                      _scrollController.animateTo(
//                                        0.0,
//                                        curve: Curves.easeOut,
//                                        duration:
//                                            const Duration(milliseconds: 300),
//                                      );
//                                    },
                                        ),
                                      ],
                                    ),
                                    CustomButton(
                                      inputText: 'Calculate Footprint',
                                      onPress: () {
                                        Navigator.pushNamed(
                                            context, ResultScreen.id);
                                      },
                                    ),
                                    //housing container end
                                  ],
                                ),
                                decoration: kInputContainerDecoration,
                              ),
                            ),
                          ),
                          //Food container

                          //product container
//                          Visibility(
//                            visible: productContainerVisibility,
//                            child: Padding(
//                              padding: kPaddingInputContainer,
//                              child: Container(
//                                child: Column(
//                                  crossAxisAlignment:
//                                      CrossAxisAlignment.stretch,
//                                  children: <Widget>[
//                                    InputHeadingContainer(
//                                      text: 'Product',
//                                      image: AssetImage('images/shop.jpg'),
//                                      fontSize: 25.0,
//                                    ),
//                                    Column(
//                                      crossAxisAlignment:
//                                          CrossAxisAlignment.start,
//                                      children: <Widget>[
//                                        SizedBox(
//                                          height: 10.0,
//                                        ),
//                                        InputText(
//                                          text:
//                                              'Average ₹ spent on Electrical product per month(in Rupees)',
//                                        ),
//                                        CustomSlider(
//                                          icon: kElectricalIcon,
//                                          max: maxElectricalValue,
//                                          min: 0.0,
//                                          value: electricalValue,
//                                          division: maxElectricalValueD,
//                                          unit: '₹',
//                                          onPress: (value) {
//                                            setState(
//                                              () {
//                                                electricalValue = value;
//                                              },
//                                            );
//                                          },
//                                        ),
//                                        InputText(
//                                          text:
//                                              'Average ₹ spent on clothing product per month (in Rupees)',
//                                        ),
//                                        CustomSlider(
//                                          value: clothingValue,
//                                          min: 0.0,
//                                          max: maxClothingValue,
//                                          icon: kClothesIcon,
//                                          unit: '₹',
//                                          onPress: (value) {
//                                            setState(
//                                              () {
//                                                clothingValue = value;
//                                              },
//                                            );
//                                          },
//                                          division: maxClothingValueD,
//                                        ),
//                                        InputText(
//                                          text:
//                                              'Average ₹ spent on Household product per month (in Rupees)',
//                                        ),
//                                        CustomSlider(
//                                          division: maxHouseholdValueD,
//                                          min: 0.0,
//                                          max: maxHouseholdValue,
//                                          icon: kHouseholdIcon,
//                                          unit: '₹',
//                                          value: householdValue,
//                                          onPress: (value) {
//                                            setState(
//                                              () {
//                                                householdValue = value;
//                                              },
//                                            );
//                                          },
//                                        ),
//                                        InputText(
//                                          text:
//                                              'Average ₹ spent on Medical product per month (in Rupees)',
//                                        ),
//                                        CustomSlider(
//                                          division: maxMedicalValueD,
//                                          min: 0.0,
//                                          max: maxMedicalValue,
//                                          icon: kMedicalIcon,
//                                          unit: '₹',
//                                          value: medicalValue,
//                                          onPress: (value) {
//                                            setState(
//                                              () {
//                                                medicalValue = value;
//                                              },
//                                            );
//                                          },
//                                        ),
//                                      ],
//                                    ),
//                                    Row(
//                                      mainAxisAlignment:
//                                          MainAxisAlignment.spaceBetween,
//                                      children: <Widget>[
//                                        CustomButton(
//                                          inputText: '< Previous',
//                                          onPress: () {
//                                            setState(() {
//                                              foodContainerVisibility = true;
//                                              productContainerVisibility =
//                                                  false;
//                                              containerCount = 1;
//                                            });
//                                            _scrollController.animateTo(
//                                              0.0,
//                                              curve: Curves.easeOut,
//                                              duration: const Duration(
//                                                  milliseconds: 300),
//                                            );
//                                          },
//                                        ),
//                                        CustomButton(
//                                          inputText: 'next >',
//                                        ),
//                                      ],
//                                    ),
//                                    CustomButton(
//                                      inputText: 'Calculate Footprint',
//                                      onPress: () {
//                                        Navigator.pushNamed(
//                                            context, ResultScreen.id);
//                                      },
//                                    ),
//                                    //housing container end
//                                  ],
//                                ),
//                                decoration: kInputContainerDecoration,
//                              ),
//                            ),
//                          ),
                          //product container end
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
