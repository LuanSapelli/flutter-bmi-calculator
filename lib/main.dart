import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields(){
    setState(() {
      weightController.text = "";
      heightController.text = "";
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calc(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9){
        _infoText = "Peso ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9){
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9){
        _infoText = "Obesidade grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9){
        _infoText = "Obesidade grau II (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40){
        _infoText = "Obesidade grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Calculadora de IMC",
            style: TextStyle(color: Color.fromRGBO(243, 239, 245, 1)),
          ),
          centerTitle: true,
          backgroundColor: CupertinoColors.activeBlue,
          actions: [
            IconButton(
                icon: Icon(CupertinoIcons.arrow_2_circlepath),
                color: Color.fromRGBO(243, 239, 245, 1),
                onPressed: _resetFields)
          ],
        ),
        backgroundColor: Color.fromRGBO(243, 239, 245, 1),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(CupertinoIcons.person, size: 120),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: Colors.black)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                  controller: weightController,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira seu peso!";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.black)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                  controller: heightController,
                  // ignore: missing_return
                  validator: (value) {
                    if(value.isEmpty){
                      return "Insira sua altura!";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
                  child: Container(
                    height: 50.0,
                    child: CupertinoButton(
                      onPressed: () {
                        if(_formKey.currentState.validate()){
                          _calc();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(
                            color: CupertinoColors.white, fontSize: 20.0),
                      ),
                      color: CupertinoColors.activeBlue,
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                )
              ],
            ),
          ),
        ));
  }
}
