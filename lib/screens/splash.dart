import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset('assets/images/splash-image.png'),
                  ),
                  Row(children: [
                    Expanded(
                      child: TextButton(
                        style: ButtonStyle(
                          padding: const WidgetStatePropertyAll(
                            EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 8,
                            ),
                          ),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          backgroundColor: const WidgetStatePropertyAll(
                            Colors.black,
                          ),
                        ),
                        onPressed: () => context.go('/legacy'),
                        child: const Text(
                          'Find my dream trip.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox.square(
                    dimension: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: TextButton(
                        style: ButtonStyle(
                          padding: const WidgetStatePropertyAll(
                            EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 8,
                            ),
                          ),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          backgroundBuilder: (context, states, child) {
                            return Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xff59B7EC),
                                    Color(0xff9A62E1),
                                    Color(0xffE66CF9),
                                  ],
                                  stops: [
                                    0.0,
                                    0.20,
                                    0.9,
                                  ],
                                ),
                              ),
                              child: child,
                            );
                          },
                        ),
                        onPressed: () => context.go('/ai'),
                        child: const Text(
                          'Plan my dream trip with AI',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      )),
                    ],
                  ),
                ])));
  }
}
