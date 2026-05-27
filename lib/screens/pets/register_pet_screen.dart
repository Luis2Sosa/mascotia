import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/app_background.dart';

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

    if (name.isEmpty ||
        age.isEmpty ||
        weight.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          backgroundColor:
          const Color(0xFF151B28),
          behavior:
          SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(18),
          ),
          content: const Text(
            'Completa todos los campos',
          ),
        ),
      );

      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        backgroundColor:
        const Color(0xFF151B28),
        behavior:
        SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(18),
        ),
        content: Text(
          '$name registrado correctamente 🐾',
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
              horizontal: 22,
            ),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                const SizedBox(height: 12),

                /// HEADER
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,

                  children: [
                    _glassButton(
                      icon: Icons
                          .arrow_back_ios_new_rounded,
                      onTap: () =>
                          Navigator.pop(
                            context,
                          ),
                    ),

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
                          18,
                        ),

                        color: Colors.white
                            .withOpacity(
                          .05,
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
                  'Registrar\nmascota',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    height: .95,
                    fontWeight:
                    FontWeight.w900,
                    letterSpacing: -2.5,
                  ),
                ),

                const SizedBox(height: 14),

                Text(
                  'Añade la información básica de tu mascota para comenzar el seguimiento.',
                  style: TextStyle(
                    color: Colors.white
                        .withOpacity(.68),
                    fontSize: 15,
                    height: 1.6,
                    fontWeight:
                    FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 36),

                /// AVATAR
                Center(
                  child: GestureDetector(
                    onTap: pickImage,

                    child: Stack(
                      clipBehavior:
                      Clip.none,

                      children: [
                        Container(
                          width: 132,
                          height: 132,

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
                                  .09,
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
                                .06,
                              ),
                            ),
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
                            size: 54,
                            color: Colors
                                .white
                                .withOpacity(
                              .75,
                            ),
                          ),
                        ),

                        Positioned(
                          bottom: 2,
                          right: -2,

                          child: Container(
                            width: 44,
                            height: 44,

                            decoration:
                            BoxDecoration(
                              shape: BoxShape
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
                                width: 3,
                              ),
                            ),

                            child: const Icon(
                              Icons
                                  .camera_alt_rounded,
                              color:
                              Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                Center(
                  child: Text(
                    'Subir foto',
                    style: TextStyle(
                      color: Colors.white
                          .withOpacity(.38),
                      fontSize: 13,
                    ),
                  ),
                ),

                const SizedBox(height: 34),

                /// INPUTS
                _InputField(
                  controller:
                  nameController,
                  hint:
                  'Nombre de la mascota',
                  icon:
                  Icons.pets_rounded,
                ),

                const SizedBox(height: 14),

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

                    const SizedBox(width: 14),

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

                const SizedBox(height: 30),

                Text(
                  'TIPO DE MASCOTA',
                  style: TextStyle(
                    color: Colors.white
                        .withOpacity(.45),
                    fontWeight:
                    FontWeight.w700,
                    letterSpacing: 1.6,
                    fontSize: 11,
                  ),
                ),

                const SizedBox(height: 14),

                GridView.builder(
                  shrinkWrap: true,
                  itemCount:
                  petTypes.length,
                  physics:
                  const NeverScrollableScrollPhysics(),

                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: .9,
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

                const SizedBox(height: 28),

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

                    onPressed: savePet,

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

                const SizedBox(height: 34),
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
    return GestureDetector(
      onTap: onTap,

      child: Container(
        width: 52,
        height: 52,

        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(18),

          color:
          Colors.white.withOpacity(.05),

          border: Border.all(
            color:
            Colors.white.withOpacity(.06),
          ),
        ),

        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  Widget _step(bool active) {
    return Container(
      width: active ? 24 : 16,
      height: 4,

      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.circular(99),

        color: active
            ? const Color(0xFF58D36E)
            : Colors.white.withOpacity(.12),
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
      height: 62,

      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.circular(22),

        color:
        Colors.white.withOpacity(.05),

        border: Border.all(
          color:
          Colors.white.withOpacity(.05),
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
            Colors.white.withOpacity(.38),
          ),

          prefixIcon: Icon(
            icon,
            color:
            Colors.white.withOpacity(.72),
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
        const Duration(milliseconds: 180),

        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(24),

          color: selected
              ? color.withOpacity(.14)
              : Colors.white.withOpacity(.04),

          border: Border.all(
            color: selected
                ? color.withOpacity(.7)
                : Colors.white
                .withOpacity(.05),
          ),
        ),

        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [
            Container(
              width: 54,
              height: 54,

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

            const SizedBox(height: 12),

            Text(
              label,
              style: TextStyle(
                color: Colors.white
                    .withOpacity(.92),
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