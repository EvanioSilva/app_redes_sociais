import 'package:app_redes_sociais/controllers/calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarPage extends GetView<CalendarController> {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCalendar(),
    );
  }

  Widget _buildCalendar() {
    return GetBuilder<CalendarController>(
        id: 'calendario',
        builder: (context) {
          return Column(
            children: [
              Container(
                child: TableCalendar(
                  firstDay: controller.primeiroDia,
                  lastDay: controller.ultimoDia,
                  focusedDay: controller.diaAtual,

                  selectedDayPredicate: (day) =>
                      isSameDay(day, controller.diaAtual),

                  onDaySelected: (dayInicio, dayFim) async {
                    controller.getProgramacaoDia(dayInicio);
                  },

                  locale: controller.locale,

                  calendarFormat: controller.calendarFormat,
                  onFormatChanged: (day) => controller.onFormatChanged(day),

                  calendarBuilders: CalendarBuilders(
                      markerBuilder: (context, day, int) {
                        return getWidgetCellMarker(day);
                      }
                  ),


                  // Formatação Mês/Ano
                  headerStyle: HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                      titleTextStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                      titleTextFormatter: (day, locale) =>
                          DateFormat('MMMM yyyy', locale)
                              .format(day)
                              .capitalize!),

                  // Formatação dia semana
                  daysOfWeekStyle: DaysOfWeekStyle(
                      dowTextFormatter: (day, locale) =>
                          DateFormat.E(controller.locale)
                              .format(day)[0]
                              .toUpperCase()),

                  // Formatação dia mês
                  calendarStyle: CalendarStyle(
                    defaultTextStyle: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    weekendTextStyle: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    todayDecoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    selectedTextStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: isSameDay(DateTime.now(), controller.diaAtual)
                          ? FontWeight.normal
                          : FontWeight.bold,
                      fontSize: isSameDay(DateTime.now(), controller.diaAtual)
                          ? 16
                          : 14,
                    ),
                    selectedDecoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.green),
                  ),
                ),
              ),
              Flexible(child: _buildAgenda(controller.diaAtual))
            ],
          );
        });
  }

  Widget _buildAgenda(DateTime data) {
    return GetBuilder<CalendarController>(
      id: 'agenda',
      builder: (context) {
        return controller.agenda.isEmpty
            ? Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    const Text(
                      'Oba tudo livre!',
                      style: const TextStyle(fontSize: 30),
                    ),
                    SvgPicture.asset(
                      'assets/images/feliz.svg',
                      width: 150,
                    ),
                  ],
                ),
              )
            : Container(
                padding: const EdgeInsets.all(6),
                child: Column(
                  children: [
                    Flexible(
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: CircleAvatar(
                          backgroundColor: Colors.orange,
                          child: Text(
                            data.day.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: ListView.builder(
                        itemCount: controller.agenda.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              title: Text(
                                controller.agenda[index],
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }

  // Marcar os dias
  Widget getWidgetCellMarker(DateTime day) {
    var qtde = day.day % 2 == 0 ? 2 : 1;

    return Container(
        padding: EdgeInsets.all(2),
        margin: EdgeInsets.only(bottom: 4, left: 4),
        height: 18,
        width: 14,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (qtde == 1) ? Colors.deepOrangeAccent : Colors.green
        ),
        child: Text(qtde.toString(),
          style: TextStyle(color: Colors.white, fontSize: 8),
        )
    );
  }

}
