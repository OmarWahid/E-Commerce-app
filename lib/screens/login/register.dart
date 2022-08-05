import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit_shop/cubit_shop.dart';

import '../../cubit_shop/states_shop.dart';
import '../../layout/shopLayout.dart';
import '../../network/cache_helper.dart';
import '../../shared/component.dart';

var controllerEmail = TextEditingController();
var controllerPhone = TextEditingController();
var controllerName = TextEditingController();
var controllerPassword = TextEditingController();
var keyForm = GlobalKey<FormState>();

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {
          if (state is SuccessRegisterData) {
            if (state.registerModel.status!) {
              CacheHelper.saveData(
                      key: 'token', value: state.registerModel.data!.token)
                  .then((value) {
                token = state.registerModel.data!.token;
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ShopLayout(),
                    ),
                    (route) => false);
              });
            } else {
              showToast(
                  message: state.registerModel.message!,
                  state: ToastState.ERROR);
            }
          }
          if (state is ErrorRegisterData) {
            showToast(
                message: 'Please Verify The Information Entered',
                state: ToastState.ERROR);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                  child: Form(
                    key: keyForm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Sign Up Now In Our Shop',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: controllerName,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person_outlined),
                            labelText: 'Name',
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: controllerEmail,
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
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: controllerPhone,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.phone_outlined),
                            labelText: 'Phone',
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: controllerPassword,
                          obscureText: ShopCubit.get(context).isPass,
                          onFieldSubmitted: (value) {
                            if (keyForm.currentState!.validate()) {
                              ShopCubit.get(context).getRegisterData(
                                name: controllerName.text,
                                email: controllerEmail.text,
                                password: controllerPassword.text,
                                phone: controllerPhone.text,
                              );
                            }
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              onPressed: () {
                                ShopCubit.get(context).changeVisibilityPass();
                              },
                              icon: Icon(ShopCubit.get(context).icon),
                            ),
                            labelText: 'Password',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoadingRegisterData,
                          builder: (context) => Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                if (keyForm.currentState!.validate()) {
                                  ShopCubit.get(context).getRegisterData(
                                    name: controllerName.text,
                                    email: controllerEmail.text,
                                    password: controllerPassword.text,
                                    phone: controllerPhone.text,
                                  );
                                }
                              },
                              child: const Text(
                                'REGISTER',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
