import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom/compnement/const.dart';
import 'package:zoom/cubit/cubit.dart';
import 'package:zoom/cubit/state.dart';
import 'package:zoom/moduels/home/home.dart';
import 'package:zoom/moduels/otp_screen/otp_screen.dart';
import 'package:zoom/moduels/register/register.dart';
import 'package:zoom/share/cache_elper.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      if (state is LoginWithEmailSucsses) {
        CacheHelper.setData(key: kUid, value: state.id).then((value) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()),
              (route) => false);
        });
      }
    }, builder: (context, state) {
      return Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 100, 10, 0),
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return 'email must be not empty';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'email',
                        labelText: 'email',
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return 'password must be not empty';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'password',
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.vpn_key),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        HomeCubit.get(context).loginWithEmail(
                            email: emailController.text,
                            password: passwordController.text);
                      }
                    },
                    child: Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'if you haven\t an account',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                  child: Text(
                    'register',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ),
      ));
    });
  }
}
