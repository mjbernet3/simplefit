import 'package:client/components/shared/dropdown_popup.dart';
import 'package:client/components/shared/input_field.dart';
import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class NotesDropdown extends StatefulWidget {
  final String notes;
  final Function onComplete;

  NotesDropdown({
    @required this.notes,
    this.onComplete,
  });

  @override
  _NotesDropdownState createState() => _NotesDropdownState();
}

class _NotesDropdownState extends State<NotesDropdown> {
  TextEditingController _notesController;
  bool _hidden = true;

  @override
  void initState() {
    _notesController = TextEditingController();
    _notesController.text = widget.notes;
    super.initState();
  }

  @override
  void didUpdateWidget(NotesDropdown oldWidget) {
    if (widget.notes != oldWidget.notes) {
      setState(() => _notesController.text = widget.notes);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Constants.thirdElevation,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Notes',
            style: TextStyle(
              fontSize: 16.0,
              color: Constants.medEmphasis,
            ),
          ),
          GestureDetector(
            onTap: () => _toggleNotes(context),
            child: Icon(
              _hidden ? Icons.expand_more : Icons.expand_less,
              color: Constants.medEmphasis,
            ),
          )
        ],
      ),
    );
  }

  void _toggleNotes(BuildContext context) async {
    setState(() => _hidden = false);

    RenderBox renderBox = context.findRenderObject();

    await Navigator.push(
      context,
      DropdownPopup(
        renderBox: renderBox,
        builder: (context) => InputField(
          controller: _notesController,
          focusBorderColor: Constants.firstElevation,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          numLines: 5,
        ),
      ),
    );

    setState(() => _hidden = true);

    widget.onComplete(_notesController.text);
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }
}
