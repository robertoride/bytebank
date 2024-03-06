import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

import '../../components/editor.dart';

const _tituloAppBar = "Criando Transferência";
const _rotuloCampoValor = "valor";
const _dicaCampoValor = "0.00";
const _rotuloCampoNumeroConta = "Número da conta";
const _dicaCampoNumeroConta = "0000";
const _textoBotaoConfirmar = "Confirmar";



class FormularioTransferencia extends StatefulWidget {
  FormularioTransferencia({super.key});

  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}
class FormularioTransferenciaState extends State<FormularioTransferencia> {

  final TextEditingController _controladorCampoNumeroConta =
  TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(
          title: Text((_tituloAppBar),
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        body:  SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Editor(controlador: _controladorCampoNumeroConta,
                  rotulo: _rotuloCampoNumeroConta,
                  dica: _dicaCampoNumeroConta,
                  icone: null,),
                Editor(
                  controlador: _controladorCampoValor,
                  rotulo: _rotuloCampoValor,
                  dica: _dicaCampoValor,
                  icone: Icons.monetization_on,
                ),
                ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith<Color?>((states){
                  return Colors.white;})),
                  child:
                  Text(
                      (_textoBotaoConfirmar),
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    debugPrint("Clicou em confirmar");
                    _criaTransferencia(context);
                  },
                ),
              ],
            )));
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
