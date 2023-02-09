import 'package:flutter/cupertino.dart';
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
    return (isIos == false)
        ? MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blueGrey.shade900,
                title: const Text(
                  'Currency Converter',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
                ),
                actions: [
                  Switch(
                      value: isIos,
                      onChanged: (val) {
                        setState(() {
                          isIos = val;
                        });
                      }),
                ],
              ),
              body: body(),
              backgroundColor: Colors.blueGrey.shade800,
            ),
          )
        : CupertinoApp(
      debugShowCheckedModeBanner: false,
            home: CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                middle: Text('Currency Converter'),
                trailing: CupertinoSwitch(
                  value: isIos,
                  onChanged: (val) {
                    setState(() {
                      isIos = val;
                    });
                  },
                ),
              ),
              child: body(),
            ),
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
        actions: [
          Switch(
              value: isIos,
              onChanged: (val) {
                setState(() {
                  isIos = val;
                });
              }),
        ],
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
                          onChanged: (val) {
                            setState(() {
                              amt = double.parse(val);
                            });
                          },
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
                                    data = apiHelper.api.fetchCurrencyData(
                                        From: from, To: to, amount: amt);
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

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  late Future data;

  @override
  void initState() {
    data = apiHelper.api.fetchCurrencyData(To: to, From: from);
    super.initState();
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              (isIos)
                  ? SizedBox(
                      height: 80,
                    )
                  : Container(),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    (isIos)
                        ? GestureDetector(
                      onTap: (){
                        showCupertinoModalPopup(context: context, builder: (context){
                          return Column(
                            children: [
                              Expanded(
                                flex: 3,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    color: Colors.black26,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: CupertinoPicker(
                                    backgroundColor: Colors.white,
                                    useMagnifier: true,
                                    itemExtent: 30,
                                    children: allCountry.map((e) {
                                      return Text(
                                        e,
                                        style: TextStyle(
                                          color: Colors.black
                                              .withOpacity(0.5),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }).toList(),
                                    onSelectedItemChanged: (value) {
                                      setState(() {
                                        int i = value;
                                        from = allCountry[i]
                                            .toString();
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        });
                      },
                          child: Container(
                              alignment: Alignment.center,
                              height: 80,
                              width: 190,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.amber,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 35,
                                    ),
                                    Text(
                                      from,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down_outlined,
                                      size: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        )
                        : dropDown(),
                    SizedBox(
                      width: 30,
                    ),
                    (isIos)
                        ? GestureDetector(
                      onTap: (){
                        showCupertinoModalPopup(context: context, builder: (context){
                          return  Column(
                            children: [
                              Expanded(
                                flex: 3,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    color: Colors.black26,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: CupertinoPicker(
                                    backgroundColor: Colors.white,
                                    useMagnifier: true,
                                    itemExtent: 30,
                                    children: allCountry.map((e) {
                                      return Text(
                                        e,
                                        style: TextStyle(
                                          color: Colors.black
                                              .withOpacity(0.5),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }).toList(),
                                    onSelectedItemChanged: (value) {
                                      setState(() {
                                        int i = value;
                                        to = allCountry[i]
                                            .toString();
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        });
                      },
                          child: Container(
                              alignment: Alignment.center,
                              height: 80,
                              width: 190,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.amber,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 35,
                                    ),
                                    Text(
                                      to,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down_outlined,
                                      size: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        )
                        : dropDown2(),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Builder(builder: (context) {
                    return (isIos)
                        ? Center(
                            child: CupertinoTextField(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              onChanged: (val) {
                                setState(() {
                                  amt = double.parse(val);
                                });
                              },
                              controller: controller,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              cursorColor: Colors.amber,
                            ),
                          )
                        : TextField(
                            onChanged: (val) {
                              setState(() {
                                amt = double.parse(val);
                              });
                            },
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
                          );
                  }),
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
                              data = apiHelper.api.fetchCurrencyData(
                                  From: from, To: to, amount: amt);
                            });
                          },
                          child: const Text(
                            'Calculate',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
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
  }
}
