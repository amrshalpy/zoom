import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:uuid/uuid.dart';
import 'package:zoom/compnement/const.dart';
import 'package:zoom/cubit/cubit.dart';
import 'package:zoom/cubit/state.dart';
import 'package:zoom/model/users.dart';
import 'package:zoom/moduels/home/widgets/create_meeting.dart';
import 'package:zoom/moduels/home/widgets/join_meeting.dart';
import 'package:zoom/share/cache_elper.dart';

class Home extends StatelessWidget {
  Users? users;

  Home({Key? key, this.users}) : super(key: key);
  var nameController = TextEditingController();
  var roomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(
                'Zoom',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              centerTitle: true,
              bottom: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                tabs: [
                  Container(
                    height: 40,
                    width: 170,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'create meeting',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'join meeting',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                CreateMeeting(),
                JoinMeeting(),
              ],
            ),
          ),
        );
      },
    );
  }
}
