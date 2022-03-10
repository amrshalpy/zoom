import 'package:flutter/material.dart';
import 'package:zoom/cubit/cubit.dart';

class CreateMeeting extends StatelessWidget {
  const CreateMeeting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 60, right: 10),
      child: Column(
        children: [
          Text(
            'enter code with your friend',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'code :',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
              Text(
                HomeCubit.get(context).code,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: ElevatedButton(
              onPressed: () {
                HomeCubit.get(context).createCode();
              },
              child: Text(
                'create code',
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
}
