//import 'package:client/app_style.dart';
//import 'package:client/components/shared/app_divider.dart';
//import 'package:client/components/shared/rounded_button.dart';
//import 'package:flutter/material.dart';
//
//class TimedDetail extends StatefulWidget {
//  @override
//  _TimedDetailState createState() => _TimedDetailState();
//}
//
//class _TimedDetailState extends State<TimedDetail> {
//  TextEditingController _notesController;
//
//  @override
//  void initState() {
//    super.initState();
//    _notesController = TextEditingController();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Column(
//      crossAxisAlignment: CrossAxisAlignment.start,
//      children: <Widget>[
//        Text(
//          model.liftData.exercise.name,
//          style: TextStyle(
//            fontSize: 24.0,
//          ),
//        ),
//        SizedBox(height: 14.0),
//        InputField(
//          controller: _notesController,
//          hintText: 'Notes...',
//          keyboardType: TextInputType.multiline,
//          textInputAction: TextInputAction.newline,
//          maxLines: null,
//        ),
//        SizedBox(height: 20.0),
//        Row(
//          children: <Widget>[
//            Text(
//              'Warm-up Exercise',
//              style: TextStyle(
//                color: AppStyle.medEmphasisText,
//                fontSize: 14.0,
//              ),
//            ),
//            SizedBox(width: 10.0),
//            SizedBox(
//              height: 15.0,
//              width: 15.0,
//              child: StreamBuilder<bool>(
//                stream: model.warmUpStream,
//                builder: (context, snapshot) {
//                  if (snapshot.hasData) {
//                    bool isWarmUp = snapshot.data;
//
//                    return Checkbox(
//                      activeColor: AppStyle.primaryColor,
//                      checkColor: AppStyle.backgroundColor,
//                      value: isWarmUp,
//                      onChanged: (_) => model.toggleWarmUp(),
//                    );
//                  }
//
//                  return Container();
//                },
//              ),
//            ),
//          ],
//        ),
//        SizedBox(height: 14.0),
//        Column(
//          children: <Widget>[
//            AppDivider(),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceAround,
//              children: <Widget>[
//                RoundedButton(
//                  buttonText: Text(
//                    'Cancel',
//                    style: TextStyle(color: AppStyle.highEmphasisText),
//                  ),
//                  height: 30.0,
//                  color: AppStyle.dp4,
//                  borderColor: AppStyle.dp4,
//                  onPressed: () => Navigator.pop(context),
//                ),
//                RoundedButton(
//                  buttonText: Text(
//                    'Save Changes',
//                    style: TextStyle(color: AppStyle.highEmphasisText),
//                  ),
//                  height: 30.0,
//                  color: AppStyle.dp4,
//                  borderColor: AppStyle.dp4,
//                  onPressed: () {
//                    Navigator.pop(context);
//                  },
//                ),
//              ],
//            ),
//          ],
//        ),
//      ],
//    );
//  }
//}
