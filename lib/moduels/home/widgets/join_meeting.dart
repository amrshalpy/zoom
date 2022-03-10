import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:zoom/compnement/const.dart';
import 'package:zoom/cubit/cubit.dart';
import 'package:zoom/share/cache_elper.dart';

class JoinMeeting extends StatelessWidget {
  JoinMeeting({Key? key}) : super(key: key);
  var roomController = TextEditingController();
  var nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 60, 10, 0),
      child: Column(
        children: [
          Text(
            'enter code to include with your friends',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          PinCodeTextField(
            controller: roomController,
            appContext: context,
            length: 6,
            onChanged: (value) {},
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.underline,
            ),
            onCompleted: (value) {
              HomeCubit.get(context).code = value;
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: 'enter your name if you want',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CheckboxListTile(
            value: HomeCubit.get(context).isMuted,
            onChanged: (value) {
              HomeCubit.get(context).isMutedButton(value);
            },
            title: Text(
              'is Audio Muted',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CheckboxListTile(
            value: HomeCubit.get(context).isVideo,
            onChanged: (value) {
              HomeCubit.get(context).isVideoButton(value);
            },
            title: Text(
              'is Video Muted',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: ElevatedButton(
              onPressed: () {
                getJoinMeeting(context);
                roomController.clear();
              },
              child: Text(
                'join meeting',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getJoinMeeting(context) async {
    try {
      Map<FeatureFlagEnum, bool> featureFlags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
      };
      if (Platform.isAndroid) {
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }
      var options = JitsiMeetingOptions(room: roomController.text)
        ..audioMuted = HomeCubit.get(context).isMuted
        ..videoMuted = HomeCubit.get(context).isVideo
        ..userDisplayName = nameController.text == ''
            ? HomeCubit.get(context).users!.name
            : nameController.text
        ..featureFlags = featureFlags;

      await JitsiMeet.joinMeeting(options);
    } catch (er) {
      print(er.toString());
    }
  }

 
}
