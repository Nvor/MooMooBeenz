import 'package:MooMooBeenz_App/models/user.dart';
import 'package:MooMooBeenz_App/services/user-service.dart';
import 'package:flutter/material.dart';

class UserSummaryCard extends StatefulWidget {
  @override
  _UserSummaryCard createState() => _UserSummaryCard();
}

class _UserSummaryCard extends State<UserSummaryCard> {
  UserService userService = new UserService();
  bool canEdit = true;
  bool inEditMode = false;
  final _formKey = GlobalKey<FormState>();
  String _summary = "";

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                  'Summary',
                  textScaleFactor: 1.5,
                  style: TextStyle(
                    fontWeight: FontWeight.w500
                  ))
                ),
                Expanded(
                  flex: 0,
                  child: Ink(
                    child: canEdit ? (inEditMode ?
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: () => exitEditMode()
                          ),
                          IconButton(
                            icon: Icon(Icons.save),
                            onPressed: () => saveSummary()
                          )
                        ]
                      ) : IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => enterEditMode()
                    )) : Container(height:0)
                  )
                )
              ]
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Form(
                  key: _formKey,
                  child: Flexible(child:
                    inEditMode ?
                    TextFormField(
                      initialValue: _summary,
                      onSaved: (value) => _summary = value,
                      decoration: InputDecoration(labelText: 'Enter a summary'),
                    )
                    : Text(
                    _summary,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0
                      )
                    ),
                  )
                ),
              ]
            ),
            inEditMode ? SizedBox(
              child: ElevatedButton(
                  child: Text('SAVE'),
                  onPressed: () => saveSummary()
              ),
              width: 200,
            )
            : Container(height:0)
          ]
        )
      )
    );
  }

  void saveSummary() async {
    final form = _formKey.currentState;
    try {
      form.save();
      User user = await userService.getUser();
      user.summary = _summary;
      userService.saveUserData(user);
    } on Exception catch (error) {
      throw new Exception('Error saving summary');
    }

    exitEditMode();
  }

  Future<void> enterEditMode() async {
    setState(() => inEditMode = true);
  }

  void exitEditMode() {
    setState(() => inEditMode = false);
  }
}