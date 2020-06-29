import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
void main(){
  runApp(MaterialApp(
    title: 'Calculadora IMC',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController WeightController = new TextEditingController();//Pegar dados dos botoes
  TextEditingController HeightController = new TextEditingController();
  String _infoText="Informe os seus dados";
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();//formulario
  void _resetFields(){
    WeightController.text = "";
    HeightController.text = "";
    setState(() {
      _infoText="Informe os seus dados";
      _formkey = GlobalKey<FormState>();
    });

  }
  void calculate(){
    setState(() {
      double weight = double.parse(WeightController.text);//converter para float
      double height = double.parse(HeightController.text);
      double imc = weight/(height*height);

      if(imc<18.6)
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(4)})";//pegar casas decimais
      else if(imc>=18.6 && imc<24.9)
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      else if(imc>=24.9 && imc<29.9)
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      else if(imc>=29.9 && imc<34.9)
        _infoText = "Obesidade de Grau 1 (${imc.toStringAsPrecision(4)})";
      else if(imc>=34.9 && imc<39.9)
        _infoText = "Obesidade de Grau 2 (${imc.toStringAsPrecision(4)})";
      else
        _infoText = "Obesidade de Grau 3 (${imc.toStringAsPrecision(4)})";

    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculadora IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            onPressed: _resetFields,
            icon: Icon(Icons.refresh),

          ),
        ],

      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,//tenta ocupar toda a largura
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.green,
              ),
              TextFormField(
                validator: (value){
                  if(value.isEmpty){
                    return "Ensira seu peso!";
                  }
                },
                controller: WeightController,
                keyboardType: TextInputType.number,//serve para determinar qual tipo de teclado aparece primeiro
                decoration: InputDecoration(
                  labelText: 'Peso(KG)',
                  labelStyle: TextStyle(
                    color: Colors.green,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green,fontSize: 25),
              ),
              TextFormField(
                validator: (value){
                  if(value.isEmpty) {
                    return "Ensira sua Altura!";
                  }
                },
                keyboardType: TextInputType.number,//serve para determinar qual tipo de teclado aparece primeiro
                controller: HeightController,
                decoration: InputDecoration(
                  labelText: 'Altura(M)',
                  labelStyle: TextStyle(
                    color: Colors.green,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green,fontSize: 25),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10,top: 10),
                child:  Container(
                  height: 50,
                  child: RaisedButton(
                    onPressed: (){
                      try{
                        if(_formkey.currentState.validate()){
                          calculate();
                        }
                      } on Exception catch(_){
                        setState(() {
                          _infoText = "Dados inválidos!";
                        });

                      }



                    },
                    color: Colors.green,


                    child: Text('Calcular IMC',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),

              Text(
                _infoText,textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
