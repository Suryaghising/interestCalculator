import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Interest calculator",
    home: MainWork(),
    theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent),
  ));
}

class MainWork extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CalculatorElements();
  }
}

class _CalculatorElements extends State<MainWork> {
  var _currencies = ['Rupees', 'Dollar', 'Pound'];
  var currentItemSelected = '';
  final _paddingSize = 8.0;

  var output = " ";

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentItemSelected = _currencies[0];
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
        appBar: AppBar(
          title: Text("Simple Interest Calculator"),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(_paddingSize),
            child: ListView(
              children: <Widget>[
                _ImageLoaderWidget(context),
                TextFormField(
                  validator: (String value){
                    if(value.isEmpty){
                      return "Please enter the principal.";
                    }
                  },
                  controller: principalController,
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    labelText: "Principal",
                    labelStyle: textStyle,
                    errorStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.limeAccent
                    ),
                    hintText: "Enter the principal amount",
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: _paddingSize, bottom: _paddingSize),
                  child: TextFormField(
                    controller: roiController,
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    validator: (String value){
                      if(value.isEmpty){
                        return "Please enter the Rate of interest.";
                      }
                    },

                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelText: "Rate of interest.",
                      errorStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.limeAccent
                      ),
                      labelStyle: textStyle,
                      hintText: "Enter the rate of simple interest.",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: _paddingSize),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          validator: (String value){
                            if(value.isEmpty){
                              return "Please enter time.";
                            }
                          },
                          controller: timeController,
                          keyboardType: TextInputType.number,
                          style: textStyle,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              labelText: "Time",
                              hintText: "Enter time",
                              errorStyle: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.limeAccent
                              ),
                              labelStyle: textStyle),
                        ),
                      ),
                      Container(
                        width: _paddingSize * 4,
                      ),
                      Expanded(
                        child: DropdownButton(
                          style: textStyle,
                          items: _currencies.map((String dropDownStringItems) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItems,
                              child: Text(dropDownStringItems),
                            );
                          }).toList(),
                          onChanged: (String newValueSelected) {
                            setState(() {
                              this.currentItemSelected = newValueSelected;
                            });
                          },
                          value: currentItemSelected,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: _paddingSize, bottom: _paddingSize),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          textColor: Theme.of(context).primaryColorDark,
                          padding: EdgeInsets.all(8.0),
                          elevation: 6.0,
                          child: Text(
                            "Calculate",
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_formKey.currentState.validate()){
                                output = result();
                              }
                            });
                          },
                        ),
                      ),
                      Expanded(
                          child: RaisedButton(
                              elevation: 6.0,
                              color: Theme.of(context).primaryColorDark,
                              textColor: Theme.of(context).primaryColorLight,
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Reset",
                                textScaleFactor: 1.5,
                              ),
                              onPressed: () {
                                setState(() {
                                  _reset();
                                });
                              })),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(_paddingSize),
                    child: Text(
                      output,
                      style: TextStyle(
                        fontSize: 24.0
                      ),
                    ))
              ],
            ),
          ),
        ));
  }

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    timeController.text = '';
    output = '';
    currentItemSelected = _currencies[0];
  }

  String result() {
    double principalAmount = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double time = double.parse(timeController.text);

    var interest = (principalAmount * roi * time) / 100;
    String finalResult = "Your interest after $roi time is $interest";
    return finalResult;
  }

  // ignore: non_constant_identifier_names
  Widget _ImageLoaderWidget(BuildContext context) {
    AssetImage assetImage = AssetImage('images/bitcoin.png');
    Image image = Image(
      image: assetImage,
      height: 125.0,
      width: 125.0,
    );
    return Container(
      child: image,
      padding: EdgeInsets.all(_paddingSize),
      margin: EdgeInsets.all(_paddingSize),
    );
  }
}
