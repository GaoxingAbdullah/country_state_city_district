import 'package:flutter/material.dart';

class AddressPage extends StatefulWidget {
  const AddressPage(
      {Key? key,
      required this.country,
      required this.state,
      required this.city,
      required this.district,
      required this.address})
      : super(key: key);
  final String country;
  final String state;
  final String city;
  final String district;
  final String address;

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
            "Your address: ${widget.country} ${widget.state} ${widget.city} ${widget.district} ${widget.address}"),
      ),
    );
  }
}
