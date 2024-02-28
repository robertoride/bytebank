import 'package:flutter/material.dart';

void main() {
  runApp(BytebankApp());
}

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencias(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  FormularioTransferencia({super.key});

  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double valor;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Criando transferência",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: <Widget>[
            Editor(controlador: _controladorCampoNumeroConta,
              rotulo: "Número da conta",
              dica: "0000",
              icone: null,),
            Editor(
              controlador: _controladorCampoValor,
              rotulo: "valor",
              dica: "0.00",
              icone: Icons.monetization_on,
            ),
            ElevatedButton(
              child: Text(
                "Confirmar",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                debugPrint("Clicou em confirmar");
                _criaTransferencia(context);
              },
            ),
          ],
        ));
  }

  void _criaTransferencia(BuildContext context) {
    final int? numeroConta =
        int.tryParse(_controladorCampoNumeroConta.text);
    final double? valor =
        double.tryParse(_controladorCampoValor.text);
    if (numeroConta != null && valor != null) {
      Transferencia(numeroConta, valor);
      final transferenciaCriada = Transferencia(numeroConta, valor);
      debugPrint("Criando transferência");
      debugPrint("$transferenciaCriada");
      Navigator.pop(context, transferenciaCriada);
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData? icone;

  Editor({required this.controlador, required this.rotulo,  required this.dica,  required this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone): null,
          labelText: rotulo,
          hintText: dica,
        ),
        style: TextStyle(fontSize: 24.0),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class ListaTransferencias extends StatefulWidget {
   ListaTransferencias({super.key});
  final List _transferencias = [];


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State <ListaTransferencias> {


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Transferências"),
      ),
      body: ListView.builder(
          itemCount: widget._transferencias.length,
          itemBuilder: (context, indice) {
            final transferencia =widget._transferencias[indice];
            return ItemTransferencia(transferencia);
          }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future future = Navigator.push(context, MaterialPageRoute(builder: (context){
            return FormularioTransferencia();}));
          future.then((transferenciaRecebida) {
            debugPrint("chegou no then do future");
            debugPrint("$transferenciaRecebida");
            widget._transferencias.add(transferenciaRecebida);
          });
        },

      ),
    );
  }




}



class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}

class Transferencia {
  final  valor;
  final  numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}
