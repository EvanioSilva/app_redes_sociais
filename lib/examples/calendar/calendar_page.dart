import 'package:app_redes_sociais/controllers/calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarPage extends GetView<CalendarController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Agenda'), centerTitle: true,),
        // Cabeçalho
        body: _buildCalendar());
  }

  Widget _buildCalendar() {
    return Container(
      padding: EdgeInsets.all(16),
        child: GetBuilder<CalendarController>(
            id: 'calendario',
            builder: (context) {
              return Column(
                children: [
                  TableCalendar(
                      locale: controller.locale,
                      firstDay: controller.primeiroDia,
                      lastDay: controller.ultimoDia,
                      focusedDay: controller.diaAtual,
                      calendarFormat: controller.calendarFormat,

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
                          fontWeight:
                              isSameDay(DateTime.now(), controller.diaAtual)
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                          fontSize:
                              isSameDay(DateTime.now(), controller.diaAtual)
                                  ? 16
                                  : 14,
                        ),
                        selectedDecoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.green),
                      ),
                      selectedDayPredicate: (day) =>
                          isSameDay(day, controller.diaAtual),
                      availableCalendarFormats:
                          controller.availableCalendarFormats,
                      onFormatChanged: (day) => controller.onFormatChanged(day),
                      onDaySelected: (dayInicio, dayFim) async {
                        controller.getProgramacaoDia(dayInicio);
                      },
                      // mudança mês
                      onPageChanged: (day) =>
                          controller.getProgramacaoDia(day)),
                  const SizedBox(
                    height: 20,
                  ),
                  Flexible(child: _buildAgenda(controller.diaAtual))
                ],
              );
            }));
  }

  Widget _buildAgenda(DateTime data) {
    return GetBuilder<CalendarController>(
      id: 'agenda',
      builder: (context) {
        return controller.agenda.isEmpty
            ? Container(
                margin: EdgeInsets.only(top: 100),
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
}
