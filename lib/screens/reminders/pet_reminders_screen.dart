import 'package:flutter/material.dart';
import '../../core/app_background.dart';
import '../home/home_screen.dart';

class PetCarePlanScreen extends StatelessWidget {
  final String petName;
  final String petType;

  const PetCarePlanScreen({
    super.key,
    required this.petName,
    required this.petType,
  });

  List<_CareItem> get carePlan {
    switch (petType) {
      case 'Perro':
        return [
          _CareItem(
            'Paseo diario',
            '2 veces al día',
            Icons.directions_walk_rounded,
          ),
          _CareItem(
            'Alimentación',
            '08:00 AM • 06:00 PM',
            Icons.restaurant_rounded,
          ),
          _CareItem(
            'Hidratación',
            'Disponible todo el día',
            Icons.water_drop_rounded,
          ),
          _CareItem(
            'Vacunas',
            'Recordatorios automáticos',
            Icons.vaccines_rounded,
          ),
          _CareItem(
            'Baño',
            'Cada 30 días',
            Icons.cleaning_services_rounded,
          ),
        ];

      case 'Gato':
        return [
          _CareItem(
            'Alimentación',
            '2 veces al día',
            Icons.restaurant_rounded,
          ),
          _CareItem(
            'Agua fresca',
            'Renovar diariamente',
            Icons.water_drop_rounded,
          ),
          _CareItem(
            'Arenero',
            'Limpieza diaria',
            Icons.cleaning_services_rounded,
          ),
          _CareItem(
            'Vacunas',
            'Control veterinario',
            Icons.vaccines_rounded,
          ),
        ];

      case 'Pez':
        return [
          _CareItem(
            'Alimentación',
            '1-2 veces al día',
            Icons.restaurant_rounded,
          ),
          _CareItem(
            'Cambio de agua',
            'Cada 7 días',
            Icons.water_rounded,
          ),
          _CareItem(
            'Limpieza de pecera',
            'Cada 15 días',
            Icons.cleaning_services_rounded,
          ),
        ];

      case 'Ave':
        return [
          _CareItem(
            'Alimentación',
            'Diariamente',
            Icons.restaurant_rounded,
          ),
          _CareItem(
            'Agua limpia',
            'Renovar diariamente',
            Icons.water_drop_rounded,
          ),
          _CareItem(
            'Limpieza de jaula',
            'Cada semana',
            Icons.cleaning_services_rounded,
          ),
        ];

      case 'Reptil':
        return [
          _CareItem(
            'Alimentación',
            'Según especie',
            Icons.restaurant_rounded,
          ),
          _CareItem(
            'Temperatura',
            'Monitoreo diario',
            Icons.thermostat_rounded,
          ),
          _CareItem(
            'Limpieza del terrario',
            'Semanal',
            Icons.cleaning_services_rounded,
          ),
        ];

      default:
        return [
          _CareItem(
            'Alimentación',
            'Diaria',
            Icons.restaurant_rounded,
          ),
          _CareItem(
            'Hidratación',
            'Diaria',
            Icons.water_drop_rounded,
          ),
        ];
    }
  }

  IconData get petIcon {
    switch (petType) {
      case 'Perro':
        return Icons.pets_rounded;
      case 'Gato':
        return Icons.pets;
      case 'Ave':
        return Icons.flutter_dash_rounded;
      case 'Pez':
        return Icons.phishing_rounded;
      case 'Reptil':
        return Icons.eco_rounded;
      default:
        return Icons.favorite_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF08111F),
      body: AppBackgroundBlobs(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 8),

              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    InkWell(
                      borderRadius:
                      BorderRadius.circular(18),
                      onTap: () =>
                          Navigator.pop(context),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(18),
                          color:
                          Colors.white.withOpacity(.05),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF58D36E)
                      .withOpacity(.15),
                  border: Border.all(
                    color: const Color(0xFF58D36E),
                  ),
                ),
                child: Icon(
                  petIcon,
                  size: 42,
                  color: const Color(0xFF58D36E),
                ),
              ),

              const SizedBox(height: 10),

              Text(
                petName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                petType,
                style: TextStyle(
                  color:
                  Colors.white.withOpacity(.65),
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Container(
                  width: double.infinity,
                  padding:
                  const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(24),
                    color:
                    Colors.white.withOpacity(.05),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Plan recomendado para tu mascota',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight:
                          FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Mascotia preparó automáticamente los cuidados esenciales.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white
                              .withOpacity(.65),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Expanded(
                child: ListView.builder(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  itemCount: carePlan.length,
                  itemBuilder: (_, index) {
                    final item = carePlan[index];

                    return Container(
                      margin:
                      const EdgeInsets.only(
                        bottom: 12,
                      ),
                      padding:
                      const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(
                            22),
                        color: Colors.white
                            .withOpacity(.05),
                        border: Border.all(
                          color: Colors.white
                              .withOpacity(.05),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 54,
                            height: 54,
                            decoration:
                            BoxDecoration(
                              shape:
                              BoxShape.circle,
                              color: const Color(
                                  0xFF58D36E)
                                  .withOpacity(
                                  .15),
                            ),
                            child: Icon(
                              item.icon,
                              color: const Color(
                                  0xFF58D36E),
                            ),
                          ),

                          const SizedBox(width: 14),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                              children: [
                                Text(
                                  item.title,
                                  style:
                                  const TextStyle(
                                    color:
                                    Colors.white,
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                    height: 3),
                                Text(
                                  item.subtitle,
                                  style:
                                  TextStyle(
                                    color: Colors
                                        .white
                                        .withOpacity(
                                        .60),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(
                  24,
                  12,
                  24,
                  20,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HomeScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF58D36E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      'Ir al inicio',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                      ),
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

class _CareItem {
  final String title;
  final String subtitle;
  final IconData icon;

  _CareItem(
      this.title,
      this.subtitle,
      this.icon,
      );
}