import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvvm_signin_out/res/color.dart';
import 'package:mvvm_signin_out/view_model/auth_view_model.dart';
import 'package:mvvm_signin_out/utils/utlis.dart';

import 'package:mvvm_signin_out/res/components/heading.dart';
import 'package:mvvm_signin_out/view_model/signup_radio.dart';

import '../../res/components/button.dart';

class SignUpView extends StatefulHookConsumerWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final showPassProvider = StateProvider<bool>((ref) => true);
  final showconfirmPassProvider = StateProvider<bool>((ref) => true);
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _confirmPassController;
  late final TextEditingController _passwordController;
  late final TextEditingController _phoneController;

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode firstnameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode confirmPassFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  @override
  void initState() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _confirmPassController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose;
    _passwordController.dispose;
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _confirmPassController.dispose();
    _phoneController.dispose();
    firstnameFocusNode.dispose();
    lastNameFocusNode.dispose();
    confirmPassFocusNode.dispose();
    phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authviewModel = ref.read(authViewModelProvider);
    final bool showPassState = ref.watch(showPassProvider);
    final bool showConfirmPassState = ref.watch(showconfirmPassProvider);
    return Scaffold(
        backgroundColor: AppColor.backgroundredColor,
        appBar: AppBar(
          title: const Text('Sign Up'),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(50, 10, 50, 20),
                  child: const CustomHeading(headingtitle: 'NeoSTORE'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                child: Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _firstNameController,
                        keyboardType: TextInputType.name,
                        focusNode: firstnameFocusNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email address';
                          } else {
                            return '';
                          }
                        },
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(color: Colors.white),
                            hintText: 'First Name',
                            hintStyle: const TextStyle(
                                fontFamily: 'Gotham',
                                fontSize: 18,
                                color: AppColor.whiteTextColor),
                            labelText: 'First Name',
                            labelStyle: const TextStyle(
                                fontFamily: 'Gotham',
                                fontSize: 18,
                                color: AppColor.whiteTextColor),
                            prefixIcon: const Icon(
                              Icons.person,
                              color: AppColor.whiteTextColor,
                            ),
                            border: Utils.myinputborder(),
                            enabledBorder: Utils.myinputborder(),
                            focusedBorder: Utils.myfocusborder()),
                        onFieldSubmitted: (value) {
                          Utils.fieldFocusChange(
                              context, firstnameFocusNode, lastNameFocusNode);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          controller: _lastNameController,
                          focusNode: lastNameFocusNode,
                          //obscuringCharacter: "*",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some password';
                            } else {
                              return '';
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Last Name',
                            errorStyle: const TextStyle(color: Colors.white),
                            hintStyle: const TextStyle(
                                fontFamily: 'Gotham',
                                fontSize: 18,
                                color: AppColor.whiteTextColor),
                            labelText: 'Last Name',
                            labelStyle: const TextStyle(
                                color: AppColor.whiteTextColor,
                                fontFamily: 'Gotham',
                                fontSize: 18),
                            prefixIcon: const Icon(
                              Icons.lock_open_outlined,
                              color: AppColor.whiteTextColor,
                            ),
                            border: Utils.myinputborder(),
                            enabledBorder: Utils.myinputborder(),
                            focusedBorder: Utils.myfocusborder(),
                          ),
                          onFieldSubmitted: (value) {
                            Utils.fieldFocusChange(
                                context, lastNameFocusNode, emailFocusNode);
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.name,
                        focusNode: emailFocusNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email address';
                          } else {
                            return '';
                          }
                        },
                        decoration: InputDecoration(
                            errorStyle: TextStyle(color: Colors.white),
                            hintText: 'Email',
                            hintStyle: const TextStyle(
                                fontFamily: 'Gotham',
                                fontSize: 18,
                                color: AppColor.whiteTextColor),
                            labelText: 'Email',
                            labelStyle: const TextStyle(
                                fontFamily: 'Gotham',
                                fontSize: 18,
                                color: AppColor.whiteTextColor),
                            prefixIcon: const Icon(
                              Icons.email,
                              color: AppColor.whiteTextColor,
                            ),
                            border: Utils.myinputborder(),
                            enabledBorder: Utils.myinputborder(),
                            focusedBorder: Utils.myfocusborder()),
                        onFieldSubmitted: (value) {
                          Utils.fieldFocusChange(
                              context, emailFocusNode, passwordFocusNode);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          controller: _passwordController,
                          obscureText: showPassState,
                          focusNode: passwordFocusNode,
                          obscuringCharacter: "*",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some password';
                            } else {
                              return '';
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Password',
                            errorStyle: const TextStyle(color: Colors.white),
                            hintStyle: const TextStyle(
                                fontFamily: 'Gotham',
                                fontSize: 18,
                                color: AppColor.whiteTextColor),
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                                color: AppColor.whiteTextColor,
                                fontFamily: 'Gotham',
                                fontSize: 18),
                            prefixIcon: const Icon(
                              Icons.lock_open_outlined,
                              color: AppColor.whiteTextColor,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () => ref
                                  .read(showPassProvider.notifier)
                                  .update((state) => !state),
                              icon: showPassState
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                              color: AppColor.whiteTextColor,
                            ),
                            border: Utils.myinputborder(),
                            enabledBorder: Utils.myinputborder(),
                            focusedBorder: Utils.myfocusborder(),
                          ),
                          onFieldSubmitted: (value) {
                            Utils.fieldFocusChange(context, passwordFocusNode,
                                confirmPassFocusNode);
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _confirmPassController,
                        obscureText: showConfirmPassState,
                        focusNode: confirmPassFocusNode,
                        obscuringCharacter: "*",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some password';
                          } else {
                            return '';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          errorStyle: const TextStyle(color: Colors.white),
                          hintStyle: const TextStyle(
                              fontFamily: 'Gotham',
                              fontSize: 18,
                              color: AppColor.whiteTextColor),
                          labelText: 'Confirm Password',
                          labelStyle: const TextStyle(
                              color: AppColor.whiteTextColor,
                              fontFamily: 'Gotham',
                              fontSize: 18),
                          prefixIcon: const Icon(
                            Icons.lock_open_outlined,
                            color: AppColor.whiteTextColor,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => ref
                                .read(showconfirmPassProvider.notifier)
                                .update((state) => !state),
                            icon: showConfirmPassState
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                            color: AppColor.whiteTextColor,
                          ),
                          border: Utils.myinputborder(),
                          enabledBorder: Utils.myinputborder(),
                          focusedBorder: Utils.myfocusborder(),
                        ),
                        onFieldSubmitted: (value) {
                          Utils.fieldFocusChange(
                              context, confirmPassFocusNode, phoneFocusNode);
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          return Row(children: [
                            const Expanded(
                                child: Text(
                              "Gender",
                              style: TextStyle(
                                  fontFamily: 'GothamMedium',
                                  fontSize: 22,
                                  color: Colors.white),
                            )),
                            Expanded(
                                child: Radio(
                              activeColor: Colors.white,
                              value: "male",
                              groupValue: ref.watch(RegisterVmProvider).gender,
                              onChanged: (value) {
                                ref
                                    .watch(RegisterVmProvider)
                                    .onGenderSelect(value!);
                              },
                            )),
                            const Text("Male",
                                style: TextStyle(
                                    fontFamily: 'Gotham',
                                    fontSize: 14,
                                    color: Colors.white)),
                            Expanded(
                              child: Radio(
                                activeColor: Colors.white,
                                value: "female",
                                groupValue:
                                    ref.watch(RegisterVmProvider).gender,
                                onChanged: (value) {
                                  ref
                                      .read(RegisterVmProvider)
                                      .onGenderSelect(value!);
                                },
                              ),
                            ),
                            const Text("Female",
                                style: TextStyle(
                                    fontFamily: 'Gotham',
                                    fontSize: 14,
                                    color: Colors.white)),
                          ]);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _phoneController,
                        obscureText: true,
                        focusNode: phoneFocusNode,
                        //obscuringCharacter: "*",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some password';
                          } else {
                            return '';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          errorStyle: const TextStyle(color: Colors.white),
                          hintStyle: const TextStyle(
                              fontFamily: 'Gotham',
                              fontSize: 18,
                              color: AppColor.whiteTextColor),
                          labelText: 'Phone Number',
                          labelStyle: const TextStyle(
                              color: AppColor.whiteTextColor,
                              fontFamily: 'Gotham',
                              fontSize: 18),
                          prefixIcon: const Icon(
                            Icons.lock_open_outlined,
                            color: AppColor.whiteTextColor,
                          ),
                          border: Utils.myinputborder(),
                          enabledBorder: Utils.myinputborder(),
                          focusedBorder: Utils.myfocusborder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer(builder: (context, ref, _) {
                        return CheckboxListTile(
                          activeColor: AppColor.whiteTextColor,
                          dense: true,
                          title: const Text("I agree to terms and conditions",
                              style: TextStyle(color: AppColor.whiteTextColor)),
                          value: ref.watch(RegisterVmProvider).isChecked,
                          onChanged: (bool? val) {
                            ref.read(RegisterVmProvider).onChecked();
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        );
                      }),
                      CustomButton(
                        title: 'Register',
                        onPress: () {
                          Map<String, dynamic> data = {
                            'first_name': _firstNameController.text.toString(),
                            'last_name': _lastNameController.text.toString(),
                            'email': _emailController.text.toString(),
                            'password': _passwordController.text.toString(),
                            'confirm_password':
                                _confirmPassController.text.toString(),
                            'gender': ref.watch(RegisterVmProvider).gender,
                            'phone_no': _phoneController.text
                          };
                          authviewModel.signUpApi(data, context);
                        },
                        loading: authviewModel.signUpLoading,

                        //}
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ))

        /*Center(
            child: InkWell(
          onTap: () {
            // Navigator.pushNamed(context, RoutesName.home);
            // Utils.toastMessage('In Login Screen');
            Utils.flushBarErrorMessage('I am in Login Screen', context);
            //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
          child: const Text("Click"),
        ))*/

        );
  }
}
