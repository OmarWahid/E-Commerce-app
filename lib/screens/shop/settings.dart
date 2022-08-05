import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/cubit_profile/states_profile.dart';
import 'package:shop_app/screens/shop/update_screen.dart';

import '../../cubit_profile/cubit_profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {
        if (state is SuccessProfileData) {
          print(ProfileCubit.get(context).UserDatas!.data!.email);
        }
      },
      builder: (context, state) {
        if (state is LoadingProfileData) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          AssetImage('assets/images/profile_1.jpg'),
                    ),
                    CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.teal,
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                            ))),
                  ],
                ),
                SizedBox(height: 10),
                // ProfileCubit.get(context).UserDatas!.data!.name
                Text(
                  ProfileCubit.get(context).UserDatas!.data!.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // ProfileCubit.get(context).UserDatas!.data!.email
                Text(ProfileCubit.get(context).UserDatas!.data!.email,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    )),
                SizedBox(height: 40),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateScreen(),
                              ));
                        },
                        elevation: 0,
                        child: Row(
                          children: [
                            Icon(
                              Icons.person_outline,
                              color: Colors.teal,
                              size: 30,
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                'My Account',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, color: Colors.teal),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: MaterialButton(
                        onPressed: ()  {


                        },
                        elevation: 0,
                        child: Row(
                          children: [
                            Icon(
                              Icons.person_add_alt,
                              color: Colors.teal,
                              size: 30,
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                'Invite a Friend',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, color: Colors.teal),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          Fluttertoast.showToast(
                              msg: "Notifications !!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.teal,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        },
                        elevation: 0,
                        child: Row(
                          children: [
                            Icon(
                              Icons.notifications_none_sharp,
                              color: Colors.teal,
                              size: 30,
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                'Notifications',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, color: Colors.teal),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Help & Support',
                                      style: TextStyle(
                                       color: Colors.teal,

                                      )),
                                  content: Text(
                                      'To contact us, please send us a message on www.Obama.com'),
                                  actions: [
                                    Center(
                                      child: Container(
                                        width: 100,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.teal,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: MaterialButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'OK',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // FlatButton(
                                    //   onPressed: () {
                                    //     Navigator.pop(context);
                                    //   },
                                    //   child: Text('No'),
                                    // ),
                                    // FlatButton(
                                    //   onPressed: () {
                                    //     Navigator.pop(context);
                                    //     BlocProvider.of<ProfileCubit>(context)
                                    //         .logout();
                                    //   },
                                    //   child: Text('Yes'),
                                    // ),
                                  ],
                                );
                              });
                        },
                        elevation: 0,
                        child: Row(
                          children: [
                            Icon(
                              Icons.question_answer_outlined,
                              color: Colors.teal,
                              size: 30,
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                'Help & Support',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, color: Colors.teal),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          ProfileCubit.get(context).signOut_(context);
                        },
                        elevation: 0,
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.teal,
                              size: 30,
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                'Log Out',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, color: Colors.teal),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
