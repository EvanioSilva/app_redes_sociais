import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarController extends GetxController{

  /// Datas Aux. Calendário
  late DateTime primeiroDia;
  late DateTime ultimoDia;
  late DateTime diaAtual;

  /// Formatação inicial calendário - Visão semana
  CalendarFormat calendarFormat = CalendarFormat.month;

  /// Outros Formatos
  Map<CalendarFormat, String> availableCalendarFormats = {
    CalendarFormat.month: 'Mês',
    CalendarFormat.week: 'Semana',
    CalendarFormat.twoWeeks: 'Quinzena'
  };

  /// Tradução Textos Calendário
  String locale = 'pt-BR';

  // Conteúdo da agenda no dia selecionado
  List<String> agenda = [];

  @override
  void onInit() async {
    // Parâmetros Iniciais
    primeiroDia = DateTime.now().add(Duration(days: -365));
    ultimoDia = DateTime.now().add(Duration(days: 365));
    diaAtual = DateTime.now();

    // Agenda do dia atual
    getProgramacaoDia(diaAtual);

    super.onInit();
  }

  // Modo view do calendário
  void onFormatChanged(format) {
    calendarFormat = format;
    // refresh ui
    update(['calendario']);
  }

  // Busca a agenda do dia
  Future getProgramacaoDia(data) async {
    // Seta dia atual
    diaAtual = data;

    // busca dados da agenda
    getAgenda(data);

    // refresh ui
    update(['calendario', 'agenda']);
  }

  // Dados Mock
  void getAgenda(DateTime data) {
    agenda = [];
    if (data.day == 22 ) {
      agenda = [
        '09:30 : Meeting com Buzz Lightyear & Woody',
        '12:30 : Almoço com Pica-Pau',
        '20:30 : Jantar com Penelope Charmosa',
      ];
    } else if (data.day == 21) {
      agenda = [
        '08:45 : Passeio no parque com Peppa Pig',
        '12:30 : Almoço com Shrek & Fiona',
        '22:00 : Palestra com os Jetsons',
      ];
    }
  }
}