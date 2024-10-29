import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _horaController = TextEditingController();
  TextEditingController _faltaController = TextEditingController();
  bool? _pode;
  String _resposta = "";

  _calculo() {

    FocusScope.of(context).unfocus();
    String horaText = _horaController.text;
    String faltaText = _faltaController.text;

    double? hora = double.tryParse(horaText);
    int? falta = int.tryParse(faltaText);

    if (hora != null && falta != null) {

      double quantidadeFaltaDou = hora * 0.25;
      int quantidadeFaltaInt = quantidadeFaltaDou.toInt();

      setState(() {
        if (falta+1 >= quantidadeFaltaInt) {
          _pode = false;
        } else if (falta+1 < quantidadeFaltaInt){
          _pode = true;
        }
        _horaController.clear();
        _faltaController.clear();
      });
    } else {
      setState(() {
        _resposta = "Por favor insira valores válidos!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
            "App Faltinha",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _horaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Carga-horária total",
                  hintStyle: TextStyle(fontSize: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _faltaController,
                  decoration: InputDecoration(
                    hintText: "Faltas que possui",
                    hintStyle: TextStyle(fontSize: 18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  _calculo();
                },
                child: Text(
                  "Posso faltar?",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),

              SizedBox(height: 15,),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.5,
                child: _pode == null
                    ? Container()
                    : _pode!
                  ? Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/jesus.jpeg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Text(
                    "Pode meu filho",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.green,
                      fontSize: 30,
                    ),
                  ),
                ) : Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/diabo.jpeg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Text(
                    "Pode não caralho!",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.red,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
