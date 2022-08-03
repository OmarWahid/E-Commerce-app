import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit_shop/cubit_shop.dart';
import 'package:shop_app/model/login_model.dart';
import 'package:shop_app/shared/component.dart';

import '../../cubit_shop/states_shop.dart';
import '../../shared/component.dart';
import '../../shared/component.dart';

var controllerEmail = TextEditingController();
var controllerPhone = TextEditingController();
var controllerName = TextEditingController();

var keyForm = GlobalKey<FormState>();

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        if(state is SuccessUpdateData){
          ShopCubit.get(context).getProfileData();
        }
      },
      builder: (context, state) {
        var model = ShopCubit.get(context).UserDatas;

        controllerEmail.text = '${model!.data!.email}';
        controllerPhone.text = '${model.data!.phone}';
        controllerName.text = '${model.data!.name}';

        return (ShopCubit.get(context).UserDatas == null)
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 40, 20, 20),
                  child: Form(
                    key: keyForm,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: controllerName,
                          onFieldSubmitted: (value) {},
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                            labelText: 'Name',
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: controllerEmail,
                          onFieldSubmitted: (value) {},
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email_outlined),
                            labelText: 'Email',
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: controllerPhone,
                          onFieldSubmitted: (value) {},
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.phone_android_rounded),
                            labelText: 'Phone',
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (state is LoadingUpdateData)
                          LinearProgressIndicator(),
                        const SizedBox(height: 25),
                        Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              ShopCubit.get(context).getUpdateData(
                                name: controllerName.text,
                                email: controllerEmail.text,
                                phone: controllerPhone.text,
                              );
                            },
                            child: const Text(
                              'UPDATE',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              ShopCubit.get(context).signOut_(context);
                            },
                            child: const Text(
                              'LOGOUT',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
