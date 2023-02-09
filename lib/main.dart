import 'package:flutter/material.dart';
import 'package:sky_scrapper_currency_converter/GlobalClass/global.dart';
import 'package:sky_scrapper_currency_converter/apiHelper/apiHelper.dart';
import 'package:sky_scrapper_currency_converter/views/dropDown2.dart';
import 'package:sky_scrapper_currency_converter/views/dropdown.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatefulWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: myScaffold(),
    );
  }
}

class myScaffold extends StatefulWidget {
  const myScaffold({Key? key}) : super(key: key);


  @override
  State<myScaffold> createState() => _myScaffoldState();
}

class _myScaffoldState extends State<myScaffold> {
  late Future data;
@override
  void setState(VoidCallback fn) {

    super.setState(fn);
  }
  @override
  void initState() {
    data = apiHelper.api.fetchCurrencyData(To: to, From: from);
    super.initState();
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: const Text(
          'Currency Converter',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
        ),
      ),
      body: StatefulBuilder(
        builder: (context, _) {
          return FutureBuilder(
            future: data,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('It has error ${snapshot.error}'),
                );
              } else if (snapshot.hasData) {

                global allDatas = snapshot.data as global;
                print(allDatas.result.toString());
                return Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          dropDown(),
                          SizedBox(
                            width: 10,
                          ),
                          dropDown2(),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: controller,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          cursorColor: Colors.amber,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(
                              Icons.monetization_on,
                              color: Colors.white,
                            ),
                            labelText: 'Money',
                            labelStyle: const TextStyle(color: Colors.amber),
                            hintText: 'Amount',
                            hintStyle: const TextStyle(
                                color: Colors.white60,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                  width: 2,
                                  color: Colors.amber,
                                  style: BorderStyle.solid),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                  width: 2,
                                  color: Colors.white70,
                                  style: BorderStyle.solid),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                  width: 2,
                                  color: Colors.white70,
                                  style: BorderStyle.solid),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              alignment: Alignment.center,
                              height: 60,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.shade600,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                allDatas.result.toString(),
                                style: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              height: 60,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    apiHelper.api
                                        .fetchCurrencyData(From: from, To: to);
                                  });
                                },
                                child: const Text(
                                  'Calculate',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
      backgroundColor: Colors.blueGrey.shade800,
    );
  }
}
