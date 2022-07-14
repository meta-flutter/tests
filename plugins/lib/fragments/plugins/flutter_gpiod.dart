import 'package:flutter/material.dart';
import 'package:flutter_gpiod/flutter_gpiod.dart';

class FlutterGpiodPage extends StatefulWidget {
  const FlutterGpiodPage({Key? key}) : super(key: key);

  @override
  _FlutterGpiodState createState() => _FlutterGpiodState();
}

class _FlutterGpiodState extends State<FlutterGpiodPage> {

  final chips_ = FlutterGpiod.instance.chips;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scrollbar(
          child: ListView(
            children: [
              for (final chip in chips_)
                Builder(builder: (context) {
                  return ExpansionTile(
                    title: Text(chip.name),
                    children: [
                      CardListTile('Label', chip.label),
                      for (final line in chip.lines)
                        CardListTile('Name', line.info.name),
                    ],
                  );
                }),
            ],
          ),
        ),
    );
  }
}

class CardListTile extends StatelessWidget {
  final String name;
  final String? value;

  const CardListTile(this.name, this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(value ?? 'N/A'),
        subtitle: Text(name),
      ),
    );
  }
}
