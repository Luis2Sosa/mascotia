import 'dart:io';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/app_background.dart';
import '../reminders/pet_reminders_screen.dart';

class RegisterPetScreen extends StatefulWidget {
  const RegisterPetScreen({super.key});

  @override
  State<RegisterPetScreen> createState() =>
      _RegisterPetScreenState();
}

class _RegisterPetScreenState
    extends State<RegisterPetScreen> {
  final nameController =
  TextEditingController();

  final ageController =
  TextEditingController();

  final weightController =
  TextEditingController();

  final picker = ImagePicker();

  File? imageFile;

  String selectedType = 'Perro';

  final List<_PetType> petTypes = const [
    _PetType(
      label: 'Perro',
      icon: Icons.pets_rounded,
      color: Color(0xFF58D36E),
    ),
    _PetType(
      label: 'Gato',
      icon: Icons.catching_pokemon_rounded,
      color: Color(0xFF8B7CFF),
    ),
    _PetType(
      label: 'Ave',
      icon: Icons.flutter_dash_rounded,
      color: Color(0xFF3DB9FF),
    ),
    _PetType(
      label: 'Pez',
      icon: Icons.phishing_rounded,
      color: Color(0xFF1D9BF0),
    ),
    _PetType(
      label: 'Reptil',
      icon: Icons.eco_rounded,
      color: Color(0xFF2AD17F),
    ),
    _PetType(
      label: 'Otro',
      icon: Icons.favorite_rounded,
      color: Color(0xFFFF5CA8),
    ),
  ];

  Future<void> pickImage() async {
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
    }
  }

  void savePet() {
    final name =
    nameController.text.trim();

    final age =
    ageController.text.trim();

    final weight =
    weightController.text.trim();

    final messenger =
    ScaffoldMessenger.of(context);

    messenger.clearSnackBars();

    if (name.isEmpty ||
        age.isEmpty ||
        weight.isEmpty) {
      messenger.showSnackBar(
        SnackBar(
          elevation: 0,
          backgroundColor:
          Colors.transparent,

          behavior:
          SnackBarBehavior.floating,

          margin:
          const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),

          duration:
          const Duration(seconds: 3),

          content: Container(
            padding:
            const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 18,
            ),

            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(26),

              color:
              const Color(0xFF1B2333),

              border: Border.all(
                color: const Color(
                  0xFFFF6B6B,
                ).withOpacity(.35),
              ),

              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(.28),
                  blurRadius: 24,
                  offset:
                  const Offset(0, 10),
                ),
              ],
            ),

            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    color: const Color(
                      0xFFFF6B6B,
                    ).withOpacity(.12),
                  ),

                  child: const Icon(
                    Icons.warning_amber_rounded,
                    color:
                    Color(0xFFFF6B6B),
                    size: 24,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                    mainAxisSize:
                    MainAxisSize.min,

                    children: [
                      const Text(
                        'Campos incompletos',
                        style: TextStyle(
                          color:
                          Colors.white,
                          fontWeight:
                          FontWeight
                              .w800,
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(
                        height: 3,
                      ),

                      Text(
                        'Debes completar toda la información de la mascota.',
                        style: TextStyle(
                          color: Colors
                              .white
                              .withOpacity(
                            .72,
                          ),
                          fontSize: 13,
                          height: 1.4,
                          fontWeight:
                          FontWeight
                              .w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      return;
    }

    messenger.showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor:
        Colors.transparent,

        behavior:
        SnackBarBehavior.floating,

        margin:
        const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),

        duration:
        const Duration(seconds: 3),

        content: Container(
          padding:
          const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),

          decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(26),

            gradient:
            const LinearGradient(
              begin: Alignment.topLeft,
              end:
              Alignment.bottomRight,
              colors: [
                Color(0xFF1F8A70),
                Color(0xFF146356),
              ],
            ),

            border: Border.all(
              color: Colors.white
                  .withOpacity(.06),
            ),

            boxShadow: [
              BoxShadow(
                color: const Color(
                  0xFF146356,
                ).withOpacity(.45),
                blurRadius: 24,
                offset:
                const Offset(0, 10),
              ),
            ],
          ),

          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  color: Colors.white
                      .withOpacity(.10),
                ),

                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

                  mainAxisSize:
                  MainAxisSize.min,

                  children: [
                    const Text(
                      'Mascota registrada',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight:
                        FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(
                      height: 3,
                    ),

                    Text(
                      '$name fue agregado correctamente',
                      style: TextStyle(
                        color: Colors.white
                            .withOpacity(.82),
                        fontSize: 13,
                        height: 1.4,
                        fontWeight:
                        FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFF08111F),

      body: AppBackgroundBlobs(
        child: SafeArea(
          child: SingleChildScrollView(
            padding:
            const EdgeInsets.symmetric(
              horizontal: 24,
            ),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.center,

              children: [
                const SizedBox(height: 12),

                /// HEADER
                Row(
                  children: [
                    _glassButton(
                      icon: Icons
                          .arrow_back_ios_new_rounded,
                      onTap: () =>
                          Navigator.pop(
                            context,
                          ),
                    ),

                    const Spacer(),

                    Container(
                      padding:
                      const EdgeInsets
                          .symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),

                      decoration:
                      BoxDecoration(
                        borderRadius:
                        BorderRadius
                            .circular(
                          20,
                        ),

                        color: Colors.white
                            .withOpacity(
                          .06,
                        ),

                        border: Border.all(
                          color: Colors
                              .white
                              .withOpacity(
                            .05,
                          ),
                        ),
                      ),

                      child: Row(
                        children: [
                          _step(true),
                          const SizedBox(
                            width: 6,
                          ),
                          _step(false),
                          const SizedBox(
                            width: 6,
                          ),
                          _step(false),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 34),

                /// TITLE
                const Text(
                  'Registrar mascota',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                    height: 1,
                    fontWeight:
                    FontWeight.w900,
                    letterSpacing: -2,
                  ),
                ),

                const SizedBox(height: 18),

                SizedBox(
                  width: 320,
                  child: Text(
                    'Añade la información básica de tu mascota para comenzar el seguimiento.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white
                          .withOpacity(.68),
                      fontSize: 15,
                      height: 1.6,
                      fontWeight:
                      FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                /// AVATAR
                GestureDetector(
                  onTap: pickImage,

                  child: Stack(
                    clipBehavior:
                    Clip.none,

                    children: [
                      Container(
                        width: 140,
                        height: 140,

                        decoration:
                        BoxDecoration(
                          shape:
                          BoxShape.circle,

                          gradient:
                          LinearGradient(
                            begin:
                            Alignment
                                .topLeft,
                            end: Alignment
                                .bottomRight,

                            colors: [
                              Colors.white
                                  .withOpacity(
                                .10,
                              ),
                              Colors.white
                                  .withOpacity(
                                .03,
                              ),
                            ],
                          ),

                          border:
                          Border.all(
                            color: Colors
                                .white
                                .withOpacity(
                              .08,
                            ),
                          ),

                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF58D36E,
                              ).withOpacity(
                                .10,
                              ),
                              blurRadius: 30,
                              spreadRadius: 2,
                            ),
                          ],
                        ),

                        child: imageFile !=
                            null
                            ? ClipOval(
                          child:
                          Image.file(
                            imageFile!,
                            fit: BoxFit
                                .cover,
                          ),
                        )
                            : Icon(
                          Icons
                              .pets_rounded,
                          size: 58,
                          color: Colors
                              .white
                              .withOpacity(
                            .75,
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 6,
                        right: 0,

                        child: Container(
                          width: 48,
                          height: 48,

                          decoration:
                          BoxDecoration(
                            shape:
                            BoxShape
                                .circle,

                            color:
                            const Color(
                              0xFF58D36E,
                            ),

                            border:
                            Border.all(
                              color:
                              const Color(
                                0xFF08111F,
                              ),
                              width: 4,
                            ),
                          ),

                          child: const Icon(
                            Icons
                                .camera_alt_rounded,
                            color:
                            Colors.black,
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  'Subir foto',
                  style: TextStyle(
                    color: Colors.white
                        .withOpacity(.42),
                    fontSize: 13,
                    fontWeight:
                    FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 38),

                /// INPUTS
                _InputField(
                  controller:
                  nameController,
                  hint:
                  'Nombre de la mascota',
                  icon:
                  Icons.pets_rounded,
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: _InputField(
                        controller:
                        ageController,
                        hint: 'Edad',
                        icon: Icons
                            .cake_rounded,
                        keyboard:
                        TextInputType
                            .number,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: _InputField(
                        controller:
                        weightController,
                        hint: 'Peso',
                        icon: Icons
                            .monitor_weight_rounded,
                        keyboard:
                        TextInputType
                            .number,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                Align(
                  alignment:
                  Alignment.centerLeft,
                  child: Text(
                    'TIPO DE MASCOTA',
                    style: TextStyle(
                      color: Colors.white
                          .withOpacity(.45),
                      fontWeight:
                      FontWeight.w700,
                      letterSpacing: 1.8,
                      fontSize: 11,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                GridView.builder(
                  shrinkWrap: true,
                  itemCount:
                  petTypes.length,
                  physics:
                  const NeverScrollableScrollPhysics(),

                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: .88,
                  ),

                  itemBuilder:
                      (context, index) {
                    final item =
                    petTypes[index];

                    return _TypeCard(
                      label: item.label,
                      icon: item.icon,
                      color: item.color,
                      selected:
                      selectedType ==
                          item.label,
                      onTap: () {
                        setState(() {
                          selectedType =
                              item.label;
                        });
                      },
                    );
                  },
                ),

                const SizedBox(height: 34),

                /// BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 62,

                  child: ElevatedButton(
                    style: ElevatedButton
                        .styleFrom(
                      elevation: 0,
                      backgroundColor:
                      const Color(
                        0xFF58D36E,
                      ),

                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius
                            .circular(
                          24,
                        ),
                      ),
                    ),

                    onPressed: () {
                      savePet();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PetCarePlanScreen(
                            petName: nameController.text.trim(),
                            petType: selectedType,
                          ),
                        ),
                      );
                    },

                    child: const Text(
                      'Guardar mascota',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight:
                        FontWeight.w800,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 36),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _glassButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        borderRadius:
        BorderRadius.circular(20),
        onTap: onTap,

        child: Ink(
          width: 54,
          height: 54,

          decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(
              20,
            ),

            color:
            Colors.white.withOpacity(
              .06,
            ),

            border: Border.all(
              color:
              Colors.white.withOpacity(
                .05,
              ),
            ),
          ),

          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _step(bool active) {
    return AnimatedContainer(
      duration:
      const Duration(milliseconds: 250),

      width: active ? 24 : 16,
      height: 5,

      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.circular(99),

        color: active
            ? const Color(0xFF58D36E)
            : Colors.white.withOpacity(
          .12,
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;

  final String hint;

  final IconData icon;

  final TextInputType? keyboard;

  const _InputField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.keyboard,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,

      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.circular(22),

        color:
        Colors.white.withOpacity(.05),

        border: Border.all(
          color:
          Colors.white.withOpacity(
            .05,
          ),
        ),
      ),

      child: TextField(
        controller: controller,
        keyboardType: keyboard,

        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),

        decoration: InputDecoration(
          border: InputBorder.none,

          contentPadding:
          const EdgeInsets.symmetric(
            vertical: 20,
          ),

          hintText: hint,

          hintStyle: TextStyle(
            color:
            Colors.white.withOpacity(
              .38,
            ),
          ),

          prefixIcon: Icon(
            icon,
            color:
            Colors.white.withOpacity(
              .72,
            ),
            size: 21,
          ),
        ),
      ),
    );
  }
}

class _TypeCard extends StatelessWidget {
  final String label;

  final IconData icon;

  final Color color;

  final bool selected;

  final VoidCallback onTap;

  const _TypeCard({
    required this.label,
    required this.icon,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration:
        const Duration(
          milliseconds: 180,
        ),

        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(24),

          color: selected
              ? color.withOpacity(.14)
              : Colors.white
              .withOpacity(.04),

          border: Border.all(
            width: selected ? 1.4 : 1,
            color: selected
                ? color.withOpacity(.8)
                : Colors.white
                .withOpacity(.05),
          ),
        ),

        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [
            Container(
              width: 56,
              height: 56,

              decoration: BoxDecoration(
                shape: BoxShape.circle,

                color: selected
                    ? color.withOpacity(.16)
                    : Colors.white
                    .withOpacity(.05),
              ),

              child: Icon(
                icon,
                size: 26,
                color: selected
                    ? color
                    : Colors.white
                    .withOpacity(.75),
              ),
            ),

            const SizedBox(height: 14),

            Text(
              label,
              style: TextStyle(
                color: Colors.white
                    .withOpacity(.95),
                fontWeight:
                FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PetType {
  final String label;

  final IconData icon;

  final Color color;

  const _PetType({
    required this.label,
    required this.icon,
    required this.color,
  });
}