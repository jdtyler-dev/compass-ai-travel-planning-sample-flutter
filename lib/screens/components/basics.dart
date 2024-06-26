import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

class CompassSwitch extends StatelessWidget {
  CompassSwitch({this.value = false, required this.onChanged, super.key});

  bool value;
  Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.child_friendly),
      title: const Text('Are the kids coming?'),
      trailing: Switch(
        activeTrackColor: Theme.of(context).colorScheme.primary,
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}

class CompassDateInput extends StatefulWidget {
  const CompassDateInput({required this.onChanged, super.key});

  final Function(String) onChanged;

  @override
  State<CompassDateInput> createState() => _CompassDateInputState();
}

class _CompassDateInputState extends State<CompassDateInput> {
  TextEditingController userInputtedDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        child: Icon(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          Icons.calendar_month,
        ),
      ),
      const SizedBox.square(dimension: 8),
      Expanded(
        child: TextField(
          controller: userInputtedDate,
          onChanged: widget.onChanged,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            label: const Text('When would you like to travel?'),
            hintText: formatter.format(DateTime.now()),
          ),
        ),
      ),
      const SizedBox.square(dimension: 16),
    ]);
  }
}

final DateFormat formatter = DateFormat('MM/dd/yyyy');

class CompassSlider extends StatelessWidget {
  const CompassSlider(
      {required this.value, required this.onChanged, super.key});

  final double value;
  final Function(double) onChanged;

  String getLabel(double value) {
    return "\$" * value.toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
              child: Icon(
                Icons.wallet,
              ),
            ),
            Text(
              'What\'s your budget?',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ]),
          Row(children: [
            const Text('\$'),
            Expanded(
              child: Slider(
                label: getLabel(value),
                value: value,
                min: 1,
                max: 5,
                onChanged: onChanged,
                divisions: 4,
              ),
            ),
            const Text('\$\$\$\$\$'),
          ]),
        ],
      ),
    );
  }
}

class MoreInfoSheet extends StatefulWidget {
  const MoreInfoSheet({required this.details, super.key});

  final Map<String, Object?> details;

  @override
  State<MoreInfoSheet> createState() => _MoreInfoSheetState();
}

class _MoreInfoSheetState extends State<MoreInfoSheet> {
  bool hasKids = false;
  double budget = 1;
  String date = formatter.format(DateTime.now());

  @override
  void initState() {
    if (widget.details['kids'] != null) {
      hasKids = widget.details['kids'] as bool;
    }
    if (widget.details['budget'] != null) {
      budget = widget.details['budget'] as double;
    }
    if (widget.details['date'] != null) {
      date = widget.details['date'] as String;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 24),
          child: Column(
            children: [
              Text(
                'Just a few more details, please!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox.square(
                dimension: 16,
              ),
              if (widget.details['kids'] == null)
                CompassSwitch(
                  value: hasKids,
                  onChanged: (val) {
                    setState(() {
                      hasKids = !hasKids;
                    });
                  },
                ).animate().fadeIn(),
              const Divider(),
              const SizedBox.square(
                dimension: 8,
              ),
              if (widget.details['date'] == null)
                CompassDateInput(onChanged: (userInputtedDate) {
                  setState(() {
                    date = userInputtedDate;
                  });
                }).animate().fadeIn(),
              const SizedBox.square(
                dimension: 16,
              ),
              const Divider(),
              if (widget.details['budget'] == null)
                CompassSlider(
                  value: budget,
                  onChanged: (val) {
                    setState(() {
                      budget = val;
                    });
                  },
                ).animate().fadeIn(),
              const SizedBox.square(
                dimension: 8,
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
                      backgroundColor: WidgetStatePropertyAll(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context, {
                        'hasKids': hasKids,
                        'date': date,
                        'budget': budget,
                      });
                    },
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        );
      },
    );
  }
}
