import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import './model/city_model.dart';
import './model/country_model.dart';
import './model/state_model.dart';

class CountryStateCityPicker extends StatefulWidget {
  final TextEditingController country;
  final TextEditingController state;
  final TextEditingController city;
  final TextEditingController district;
  final TextEditingController streetAddress;
  final InputBorder? textFieldInputBorder;

  const CountryStateCityPicker(
      {super.key,
      required this.country,
      required this.state,
      required this.city,
      required this.district,
      required this.streetAddress,
      this.textFieldInputBorder});

  @override
  _CountryStateCityPickerState createState() => _CountryStateCityPickerState();
}

class _CountryStateCityPickerState extends State<CountryStateCityPicker> {
  List<CountryModel> _countryList = [];
  List<StateModel> _stateList = [];
  List<CityModel> _cityList = [];

  List<CountryModel> _countrySubList = [];
  List<StateModel> _stateSubList = [];
  List<CityModel> _citySubList = [];

  String _title = '';

  @override
  void initState() {
    super.initState();
    _getCountry();
  }

  Future<void> _getCountry() async {
    _countryList.clear();
    var jsonString = await rootBundle.loadString('assets/country.json');
    List<dynamic> body = json.decode(jsonString);
    setState(() {
      _countryList =
          body.map((dynamic item) => CountryModel.fromJson(item)).toList();
      _countrySubList = _countryList;
    });
  }

  //get state function
  Future<void> _getState(String countryId) async {
    _stateList.clear();
    _cityList.clear();
    List<StateModel> subStateList = [];
    var jsonString = await rootBundle.loadString('assets/state.json');
    List<dynamic> body = json.decode(jsonString);

    subStateList =
        body.map((dynamic item) => StateModel.fromJson(item)).toList();
    for (var element in subStateList) {
      if (element.countryId == countryId) {
        setState(() {
          _stateList.add(element);
        });
      }
    }
    _stateSubList = _stateList;
  }

  //GET CITY function
  Future<void> _getCity(String stateId) async {
    _cityList.clear();
    List<CityModel> subCityList = [];
    var jsonString = await rootBundle.loadString('assets/city.json');
    List<dynamic> body = json.decode(jsonString);

    subCityList = body.map((dynamic item) => CityModel.fromJson(item)).toList();
    for (var element in subCityList) {
      if (element.stateId == stateId) {
        setState(() {
          _cityList.add(element);
        });
      }
    }
    _citySubList = _cityList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5.0),

        ///Country TextField
        TextField(
          controller: widget.country,
          onTap: () {
            setState(() => _title = 'Country');
            _showDialog(context);
          },
          decoration: InputDecoration(
              isDense: true,
              hintText: 'Select Country',
              suffixIcon: Icon(Icons.arrow_drop_down),
              border: widget.textFieldInputBorder ?? OutlineInputBorder()),
          readOnly: true,
        ),
        const SizedBox(height: 8.0),

        ///State TextField
        TextField(
          controller: widget.state,
          onTap: () {
            setState(() => _title = 'State');
            if (widget.country.text.isNotEmpty) {
              _showDialog(context);
            } else {
              _showSnackBar('Select Country');
            }
          },
          decoration: InputDecoration(
              isDense: true,
              hintText: 'Select State',
              suffixIcon: const Icon(Icons.arrow_drop_down),
              border: widget.textFieldInputBorder ?? OutlineInputBorder()),
          readOnly: true,
        ),
        const SizedBox(height: 8.0),

        ///City TextField
        TextField(
          controller: widget.city,
          onTap: () {
            setState(() => _title = 'City');
            if (widget.state.text.isNotEmpty) {
              _showDialog(context);
            } else {
              _showSnackBar('Select State');
            }
          },
          decoration: InputDecoration(
              isDense: true,
              hintText: 'Select City',
              suffixIcon: const Icon(Icons.arrow_drop_down),
              border: widget.textFieldInputBorder ?? OutlineInputBorder()),
        ),

        const SizedBox(height: 8.0),

        ///District TextField
        TextField(
          controller: widget.district,
          onTap: () {
            setState(() => _title = 'District');
            if (widget.city.text.isNotEmpty) {
              //_showDialog(context);
            } else {
              _showSnackBar('Select City');
            }
          },
          decoration: InputDecoration(
              isDense: true,
              hintText: 'Select District',
              border: widget.textFieldInputBorder ?? OutlineInputBorder()),
        ),

        const SizedBox(height: 8.0),

        //Street address TextField
        TextFormField(
          controller: widget.streetAddress,
          onTap: () {
            setState(() => _title = 'District');
            if (widget.district.text.isNotEmpty) {
              //_showDialog(context);
            } else {
              _showSnackBar('Enter your district');
            }
          },
          decoration: const InputDecoration(
            isDense: true,
            hintText: 'Street address',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  void _showDialog(BuildContext context) {
    TextEditingController controller = TextEditingController();
    TextEditingController controller2 = TextEditingController();
    TextEditingController controller3 = TextEditingController();

    showGeneralDialog(
      barrierLabel: _title,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      context: context,
      pageBuilder: (context, __, ___) {
        return Material(
          color: Colors.transparent,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * .7,
                  margin: const EdgeInsets.only(top: 60, left: 12, right: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      //add button
                      Text(_title,
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 17,
                              fontWeight: FontWeight.w500)),

                      SizedBox(height: 10),

                      ///Text Field
                      TextField(
                        controller: _title == 'Country'
                            ? controller
                            : _title == 'State'
                                ? controller2
                                : controller3,
                        onChanged: (val) {
                          setState(() {
                            if (_title == 'Country') {
                              _countrySubList = _countryList
                                  .where((element) => element.name
                                      .toLowerCase()
                                      .contains(controller.text.toLowerCase()))
                                  .toList();
                            } else if (_title == 'State') {
                              _stateSubList = _stateList
                                  .where((element) => element.name
                                      .toLowerCase()
                                      .contains(controller2.text.toLowerCase()))
                                  .toList();
                            } else if (_title == 'City') {
                              _citySubList = _cityList
                                  .where((element) => element.name
                                      .toLowerCase()
                                      .contains(controller3.text.toLowerCase()))
                                  .toList();
                            }
                          });
                        },
                        style: TextStyle(
                            color: Colors.grey.shade800, fontSize: 16.0),
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: "Search here...",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 5),
                            isDense: true,
                            prefixIcon: Icon(Icons.search)),
                      ),

                      ///Dropdown Items
                      Expanded(
                        child: Container(
                          child: ListView.builder(
                            itemCount: _title == 'Country'
                                ? _countrySubList.length
                                : _title == 'State'
                                    ? _stateSubList.length
                                    : _citySubList.length,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {
                                  setState(() {
                                    if (_title == "Country") {
                                      widget.country.text =
                                          _countrySubList[index].name;
                                      _getState(_countrySubList[index].id);
                                      _countrySubList = _countryList;
                                      widget.state.clear();
                                      widget.city.clear();
                                    } else if (_title == 'State') {
                                      widget.state.text =
                                          _stateSubList[index].name;
                                      _getCity(_stateSubList[index].id);
                                      _stateSubList = _stateList;
                                      widget.city.clear();
                                    } else if (_title == 'City') {
                                      widget.city.text =
                                          _citySubList[index].name;
                                      _citySubList = _cityList;
                                      //_districtSubList = _districtList;
                                    }
                                  });
                                  controller.clear();
                                  controller2.clear();
                                  controller3.clear();
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20.0, left: 10.0, right: 10.0),
                                  child: Text(
                                      _title == 'Country'
                                          ? _countrySubList[index].name
                                          : _title == 'State'
                                              ? _stateSubList[index].name
                                              : _citySubList[index].name,
                                      style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 16.0)),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (_title == 'City' && _citySubList.isEmpty) {
                            widget.city.text = controller3.text;
                          }
                          _countrySubList = _countryList;
                          _stateSubList = _stateList;
                          _citySubList = _cityList;

                          controller.clear();
                          controller2.clear();
                          controller3.clear();
                          Navigator.pop(context);
                        },
                        child: Text('Close'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, -1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 16.0))));
  }
}
