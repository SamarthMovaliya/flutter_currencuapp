import 'package:flutter/material.dart';
import 'package:sky_scrapper_currency_converter/apiHelper/apiHelper.dart';

import '../GlobalClass/global.dart';

class dropDown2 extends StatefulWidget {
  const dropDown2({Key? key}) : super(key: key);

  @override
  State<dropDown2> createState() => _dropDown2State();
}

class _dropDown2State extends State<dropDown2> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade700,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: DropdownButton(
                dropdownColor: Colors.blueGrey,
                style: const TextStyle(color: Colors.white),
                borderRadius: BorderRadius.circular(20),
                icon: const Icon(
                  Icons.list,
                  color: Colors.white,
                  size: 30,
                ),
                isExpanded: true,
                underline: Container(),
                value: from,
                items: allCountry
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    from = val;
                  });
                }),
          ),
        ),
      ),
    );
  }
}
