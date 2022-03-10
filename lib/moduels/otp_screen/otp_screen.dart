import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:zoom/cubit/cubit.dart';
import 'package:zoom/cubit/state.dart';
import 'package:zoom/moduels/home/home.dart';

class OtpScreen extends StatelessWidget {
  String phone;
  OtpScreen({Key? key, required this.phone}) : super(key: key);
  String? smsCode;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(10, 140, 10, 0),
            child: Column(
              children: [
                RichText(
                  text: TextSpan(text: 'enter code here ', children: [
                    TextSpan(
                      text: phone,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 20,
                ),
                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  onChanged: (String val) {
                    print(val);
                  },
                  animationType: AnimationType.fade,
                  backgroundColor: Colors.white,
                  keyboardType: TextInputType.number,
                  onCompleted: (String sms) {
                    smsCode = sms;
                  },
                  pinTheme: PinTheme(
                    activeColor: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    borderWidth: 1,
                    shape: PinCodeFieldShape.box,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      HomeCubit.get(context).submittedOtpCode(smsCode!);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                    child: Text('verify'))
              ],
            ),
          ),
        );
      },
    );
  }
}
