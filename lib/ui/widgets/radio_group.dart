import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mig_ui/mig_ui.dart';

class RadioGroup extends StatefulWidget {
  final List<RadioList> list;
  final Function onSelect;
  final String? label;

  const RadioGroup(
      {Key? key, required this.list, required this.onSelect, this.label})
      : super(key: key);

  @override
  RadioGroupWidget createState() => RadioGroupWidget();
}

class RadioGroupWidget extends State<RadioGroup> {
  // Default Radio Button Item

  // Group Value for Radio Button.
  int id = 1;

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.label!,
              style: GoogleFonts.openSans(
                  color: migBlackColor,
                  fontWeight: FontWeight.w100,
                  fontSize: 16),
            ),
          ),
        ...widget.list
            .map((data) => SizedBox(
                  child: RadioListTile(
                    activeColor: migBlackColor,
                    title: Text("${data.name}"),
                    groupValue: id,
                    value: data.index,
                    onChanged: (val) {
                      setState(() {
                        id = data.index;
                        widget.onSelect(data);
                      });
                    },
                  ),
                ))
            .toList()
      ],
    );
  }
}

class RadioList {
  String name;
  String value;
  int index;

  RadioList({required this.name, required this.index, required this.value});
}
