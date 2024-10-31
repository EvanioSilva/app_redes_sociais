import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:flutter/material.dart' as mat;
class RelatorioPdf {
  Map? _visita;
  List<dynamic>? _perguntas;
  Document? pdf;
  ImageProvider? image;
  RelatorioPdf();

  geraRelatorio(String destino) async {

    String filename = 'relatorio-flutter';
    image = await flutterImageProvider(getLogomarca(),
      configuration: mat.ImageConfiguration(
        size: mat.Size(
          10.0,
          10.0,
        ),
      ),
    );



    DateTime dtVisita = DateTime.now();
    pdf = Document();
    pdf!.addPage(
      MultiPage(
        header: geraCabecalhoRelatorio,
        footer: geraRodape,
        build: (Context context) => [Container(child: Text('Corpo do Relatório'))],
      ),
    );
    if (destino == 'view') {
      await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => pdf!.save());
    } else if (destino == 'share') {
      await Printing.sharePdf(
          bytes: await pdf!.save(), filename: filename);
    } else {
      if (await Permission.storage
          .request()
          .isGranted) {
        final directory = await getDownloadsDirectory();
        final file = File("${directory!.path}/$filename.pdf");
        print('path-pdf'); print("${directory!.path}/$filename.pdf");

        await file.writeAsBytes(await pdf!.save());
      }
    }

  }

  Widget geraCabecalhoRelatorio(Context context) {
    DateTime dtVisita = DateTime.now();
    int total = 0;
    double percConformes = 0,
        percInconformes = 0;

    return Container(
      alignment: Alignment.centerLeft,
      height: 85.0,
      margin: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: PdfColors.black,
          ),
          left: BorderSide(
            width: 0.5,
            color: PdfColors.black,
          ),
          right: BorderSide(
            width: 0.5,
            color: PdfColors.black,
          ),
          top: BorderSide(
            width: 0.5,
            color: PdfColors.black,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(width: 15.0),
          Column(
            children: [
              SizedBox(
                height: 2.0,
              ),
              SizedBox(width: 45.0),
              Text(
                'TEMPORÁRIO',
                style: TextStyle(
                  color: PdfColors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 45.0, child:Image(image!)),
            ],
          ),
          SizedBox(width: 15.0),
          Container(color: PdfColors.black, width: 1.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.0),
                Row(children: [
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    'Relatório RPT',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                  //Expanded(),
                  Text(
                    DateFormat('dd/MM/yyyy HH:mm').format(dtVisita),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                ]),
                SizedBox(height: 2.0),
                Container(
                  height: 1.0,
                  color: PdfColors.black,
                ),
                SizedBox(height: 2.0),
                Row(children: [
                  SizedBox(
                    width: 5.0,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                ]),
                SizedBox(
                  height: 2.0,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 5.0,
                    ),

                    //Expanded(),
                    Text(
                      'Textos',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11.0,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),

                    SizedBox(
                      width: 5.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.0,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Usuário:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11.0,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    //Expanded(),
                    Text(
                      '% Ganho',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11.0,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.0,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Tipo de usuário:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11.0,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    //Expanded(),
                    SizedBox(
                      width: 5.0,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget geraCabecalhoRecomendacao(Context context) {
    DateTime dtVisita = DateTime.parse(_visita!['dt_visita']);
    int total = 0;
    double percConformes = 0,
        percInconformes = 0;

    if (_visita!['num_conformidade'] != null &&
        _visita!['num_inconformidade'] != null) {
      total = (_visita!['num_conformidade'] + _visita!['num_inconformidade']);
    } else {
      _visita!['num_conformidade'] = 0;
      _visita!['num_inconformidade'] = 0;
    }

    if (total > 0) {
      percConformes = (_visita!['num_conformidade'] * 100) / total;
      percInconformes = (_visita!['num_inconformidade'] * 100) / total;
    }

    return Container(
      alignment: Alignment.centerLeft,
      height: 85.0,
      margin: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: PdfColors.black,
          ),
          left: BorderSide(
            width: 0.5,
            color: PdfColors.black,
          ),
          right: BorderSide(
            width: 0.5,
            color: PdfColors.black,
          ),
          top: BorderSide(
            width: 0.5,
            color: PdfColors.black,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(width: 15.0),
          Column(
            children: [
              SizedBox(
                height: 2.0,
              ),
              //SizedBox(width: 45.0, child: Image(_image)),
              Text(
                'TEMPORÁRIO',
                style: TextStyle(
                  color: PdfColors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(width: 15.0),
          Container(color: PdfColors.black, width: 1.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.0),
                Row(children: [
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    'Recomendações da visita',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                  //Expanded(),
                  Text(
                    DateFormat('dd/MM/yyyy HH:mm').format(dtVisita),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                ]),
                SizedBox(height: 2.0),
                Container(
                  height: 1.0,
                  color: PdfColors.black,
                ),
                SizedBox(height: 2.0),
                Row(children: [
                  SizedBox(
                    width: 5.0,
                  ),
                  Text('${_visita!['produtor_codigo']} - ${_visita!['produtor']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11.0,
                      )),
                  //Expanded(),
                  Text(
                    'Conformidades',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11.0,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                      '${_visita!['num_conformidade'] != null
                          ? _visita!['num_conformidade']
                          : "-"}'),
                  SizedBox(
                    width: 5.0,
                  ),
                ]),
                SizedBox(
                  height: 2.0,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      '${_visita!['fazenda_codigo']} - ${_visita!['fazenda']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11.0,
                      ),
                    ),
                    //Expanded(),
                    Text(
                      'Inconformidades',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11.0,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                        '${_visita!['num_inconformidade'] != 'null'
                            ? _visita!['num_inconformidade']
                            : "-"}'),
                    SizedBox(
                      width: 5.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.0,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Técnico:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11.0,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    //7Expanded(),
                    Text(
                      '% Conforme',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11.0,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      '${percConformes.toStringAsFixed(2)} %',
                      style: TextStyle(
                        fontSize: 11.0,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.0,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Tipo de visita:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11.0,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      '${_visita!['tipo_visita']}',
                      style: TextStyle(
                        fontSize: 11.0,
                      ),
                    ),
                    //Expanded(),
                    Text(
                      '% Não conforme',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11.0,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      '${percInconformes.toStringAsFixed(2)} %',
                      style: TextStyle(
                        fontSize: 11.0,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget geraRodape(Context context) {
    Widget assProdutor, assTecnico;

    return Container(
      alignment: Alignment.centerLeft,
      height: 60.0,
      margin: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: PdfColors.black,
          ),
          left: BorderSide(
            width: 0.5,
            color: PdfColors.black,
          ),
          right: BorderSide(
            width: 0.5,
            color: PdfColors.black,
          ),
          top: BorderSide(
            width: 0.5,
            color: PdfColors.black,
          ),
        ),
      ),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 215,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '  Assinatura do Rresponsável:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ]),
            ),
            SizedBox(
                width: 1.0,
                child: Container(color: PdfColors.black, width: 1.0)),
            SizedBox(
              width: 215,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '  Assinatura do Usuário:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),

                  ]),
            ),
            SizedBox(
                width: 1.0,
                child: Container(color: PdfColors.black, width: 1.0)),
            SizedBox(
              width: 50,
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Center(

                ),
              ),
            ),
          ]),
    );
  }

  void calculaConformidade() {
    int totalConformes = 0;
    int totalInconformes = 0;

    _perguntas!.forEach((pergunta) {
      if (pergunta['conforme'] == 1) {
        totalConformes++;
      } else if (pergunta['conforme'] == 0) {
        totalInconformes++;
      }
    });

    _visita!['num_conformidade'] = totalConformes;
    _visita!['num_inconformidade'] = totalInconformes;
  }

  ImageProvider? getAssinaturaImage(strSign) {
    if (strSign != null) {
      String base64 = strSign
          .replaceAll('data:image/png;base64,', '')
          .replaceAll('data:image/jpeg;base64,', '');
      try {
        Uint8List bytes = base64Decode(base64);
        return MemoryImage(
          bytes,
        );
      } catch (e) {}
    }
  }

  mat.ImageProvider getLogomarca() {
    return mat.AssetImage(
      'assets/icons/icon.jpg',
    );
  }

}
