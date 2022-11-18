import 'package:country_state_substate_city/country_state_sub_state_city.dart';
import 'package:flutter/material.dart';

import 'address_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController streetAddress = TextEditingController();

  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Address'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            CountryStateCityPicker(
              country: country,
              state: state,
              city: city,
              district: district,
              streetAddress: streetAddress,
            ),
            const SizedBox(height: 8.0),
            Container(
              color: isSaving ? Colors.white : Colors.blue,

              ///change color and allow loading
              width: 250,
              child: isSaving
                  ? const CircularProgressIndicator(
                      color: Colors.blueGrey,
                    )
                  : TextButton(
                      onPressed: () {
                        if (district.text.isNotEmpty &&
                                streetAddress.text.isNotEmpty ||
                            city.text.isNotEmpty ||
                            state.text.isNotEmpty) {
                          //todo: save data to firebase

                          isSaving = true;

                          //todo: save data and navigate to different page
                          ///
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return AddressPage(
                              country: country.text,
                              state: state.text,
                              city: city.text,
                              district: district.text,
                              address: streetAddress.text,
                            );
                          }));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                      'All fill required',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0))));
                        }
                        isSaving = false;

                        print('save data');
                        print(district.text);
                        print(streetAddress.text);
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    country.dispose();
    state.dispose();
    city.dispose();
    district.dispose();
    streetAddress.dispose();
  }
}
