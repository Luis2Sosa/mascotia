import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/app_background.dart';

class AddReminderScreen extends StatefulWidget {
  final String petName;

  const AddReminderScreen({
    super.key,
    required this.petName,
  });

  @override
  State<AddReminderScreen> createState() =>
      _AddReminderScreenState();
}

class _AddReminderScreenState
    extends State<AddReminderScreen> {
  final TextEditingController notesController =
  TextEditingController();

  final List<_ReminderType> reminderTypes = const [
    _ReminderType(
      title: 'Vacuna',
      icon: Icons.vaccines_rounded,
    ),
    _ReminderType(
      title: 'Paseo',
      icon: Icons.directions_walk_rounded,
    ),
    _ReminderType(
      title: 'Baño',
      icon: Icons.bathtub_rounded,
    ),
    _ReminderType(
      title: 'Medicina',
      icon: Icons.medication_rounded,
    ),
    _ReminderType(
      title: 'Comida',
      icon: Icons.restaurant_rounded,
    ),
    _ReminderType(
      title: 'Veterinario',
      icon: Icons.local_hospital_rounded,
    ),
  ];

  String selectedType = 'Vacuna';

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child!,
        );
      },
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  Future<void> pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child!,
        );
      },
    );

    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  void saveReminder() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Recordatorio guardado para ${widget.petName} 🐾',
        ),
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dateText =
        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';

    final hour =
    selectedTime.hourOfPeriod == 0
        ? 12
        : selectedTime.hourOfPeriod;

    final minute =
    selectedTime.minute
        .toString()
        .padLeft(2, '0');

    final period =
    selectedTime.period == DayPeriod.am
        ? 'AM'
        : 'PM';

    final timeText =
        '$hour:$minute $period';

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackgroundBlobs(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
            ),
            child: SingleChildScrollView(
              physics:
              const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  /// BACK
                  GestureDetector(
                    onTap: () =>
                        Navigator.pop(context),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(
                          18,
                        ),
                        color: Colors.white
                            .withOpacity(.08),
                        border: Border.all(
                          color: Colors.white
                              .withOpacity(.08),
                        ),
                      ),
                      child: const Icon(
                        Icons
                            .arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  /// TITLE
                  const Text(
                    'Nuevo recordatorio',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -2,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Crea recordatorios personalizados para tus mascotas.',
                    style: TextStyle(
                      color: Colors.white
                          .withOpacity(.72),
                      fontSize: 16,
                      fontWeight:
                      FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 34),

                  /// PET
                  Text(
                    'Mascota',
                    style: TextStyle(
                      color: Colors.white
                          .withOpacity(.90),
                      fontSize: 18,
                      fontWeight:
                      FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 14),

                  _GlassContainer(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.pets_rounded,
                          color: Colors.white,
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Text(
                            widget.petName,
                            style:
                            const TextStyle(
                              color:
                              Colors.white,
                              fontSize: 16,
                              fontWeight:
                              FontWeight
                                  .w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  /// TYPE
                  Text(
                    'Tipo de recordatorio',
                    style: TextStyle(
                      color: Colors.white
                          .withOpacity(.90),
                      fontSize: 18,
                      fontWeight:
                      FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 18),

                  GridView.builder(
                    shrinkWrap: true,
                    physics:
                    const NeverScrollableScrollPhysics(),
                    itemCount:
                    reminderTypes.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.15,
                    ),
                    itemBuilder:
                        (context, index) {
                      final item =
                      reminderTypes[index];

                      final selected =
                          selectedType ==
                              item.title;

                      return _ReminderTypeCard(
                        item: item,
                        selected: selected,
                        onTap: () {
                          setState(() {
                            selectedType =
                                item.title;
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 30),

                  /// DATE
                  Text(
                    'Fecha y hora',
                    style: TextStyle(
                      color: Colors.white
                          .withOpacity(.90),
                      fontSize: 18,
                      fontWeight:
                      FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: _ActionButton(
                          icon: Icons
                              .calendar_month_rounded,
                          label: dateText,
                          onTap: pickDate,
                        ),
                      ),

                      const SizedBox(
                        width: 16,
                      ),

                      Expanded(
                        child: _ActionButton(
                          icon:
                          Icons.access_time_rounded,
                          label: timeText,
                          onTap: pickTime,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  /// NOTES
                  Text(
                    'Notas',
                    style: TextStyle(
                      color: Colors.white
                          .withOpacity(.90),
                      fontSize: 18,
                      fontWeight:
                      FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 14),

                  _GlassContainer(
                    height: 140,
                    child: TextField(
                      controller:
                      notesController,
                      maxLines: 6,
                      style:
                      const TextStyle(
                        color: Colors.white,
                        fontWeight:
                        FontWeight.w600,
                      ),
                      decoration:
                      InputDecoration(
                        border:
                        InputBorder.none,
                        hintText:
                        'Escribe una nota...',
                        hintStyle:
                        TextStyle(
                          color: Colors.white
                              .withOpacity(
                            .45,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 38),

                  /// SAVE
                  SizedBox(
                    width: double.infinity,
                    height: 64,
                    child: ElevatedButton(
                      style:
                      ElevatedButton.styleFrom(
                        backgroundColor:
                        const Color(
                          0xFF67C26F,
                        ),
                        elevation: 0,
                        shadowColor:
                        Colors.transparent,
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                            24,
                          ),
                        ),
                      ),
                      onPressed:
                      saveReminder,
                      child: const Text(
                        'Guardar recordatorio',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                          FontWeight.w800,
                          color:
                          Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassContainer extends StatelessWidget {
  final Widget child;
  final double? height;

  const _GlassContainer({
    required this.child,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
      BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 18,
          sigmaY: 18,
        ),
        child: Container(
          height: height,
          padding:
          const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white
                    .withOpacity(.10),
                Colors.white
                    .withOpacity(.04),
              ],
            ),
            border: Border.all(
              color: Colors.white
                  .withOpacity(.08),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _ReminderTypeCard
    extends StatelessWidget {
  final _ReminderType item;
  final bool selected;
  final VoidCallback onTap;

  const _ReminderTypeCard({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color:
      selected
          ? const Color(
        0xFF67C26F,
      ).withOpacity(.18)
          : Colors.white
          .withOpacity(.06),
      borderRadius:
      BorderRadius.circular(24),
      child: InkWell(
        borderRadius:
        BorderRadius.circular(24),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(
              24,
            ),
            border: Border.all(
              color:
              selected
                  ? const Color(
                0xFF67C26F,
              )
                  : Colors.white
                  .withOpacity(
                .08,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              Icon(
                item.icon,
                size: 38,
                color: Colors.white,
              ),

              const SizedBox(height: 14),

              Text(
                item.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight:
                  FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white
          .withOpacity(.08),
      borderRadius:
      BorderRadius.circular(22),
      child: InkWell(
        borderRadius:
        BorderRadius.circular(22),
        onTap: onTap,
        child: Container(
          height: 62,
          padding:
          const EdgeInsets.symmetric(
            horizontal: 18,
          ),
          decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(22),
            border: Border.all(
              color: Colors.white
                  .withOpacity(.08),
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white
                    .withOpacity(.85),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  label,
                  style:
                  const TextStyle(
                    color: Colors.white,
                    fontWeight:
                    FontWeight.w700,
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

class _ReminderType {
  final String title;
  final IconData icon;

  const _ReminderType({
    required this.title,
    required this.icon,
  });
}