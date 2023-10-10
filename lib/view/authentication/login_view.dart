import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvvm_signin_out/res/color.dart';
import 'package:mvvm_signin_out/utils/routes/routes_name.dart';
import 'package:mvvm_signin_out/utils/utlis.dart';

import 'package:mvvm_signin_out/res/components/heading.dart';

import '../../res/components/button.dart';
import '../../view_model/auth_view_model.dart';

class LoginView extends StatefulHookConsumerWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final showPassProvider = StateProvider<bool>((ref) => true);

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  @override
  void initState() {
    _emailController = TextEditingController(text: "abc@neosoft.com");
    _passwordController = TextEditingController(text: "abc@123");

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose;
    _passwordController.dispose;
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authviewModel = ref.read(authViewModelProvider);
    final bool showPassState = ref.watch(showPassProvider);
    return Scaffold(
        backgroundColor: AppColor.backgroundredColor,
        appBar: AppBar(
          title: const Text('Login'),
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
                height: 100,
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(50, 10, 50, 20),
                  child: const CustomHeading(headingtitle: 'NeoSTORE'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        focusNode: emailFocusNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email address';
                          } else {
                            return '';
                          }
                        },
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(color: Colors.white),
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
                        height: 40,
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
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Consumer(
                        builder: ((context, ref, child) => CustomButton(
                              title: 'Login',
                              onPress: () {
                                //  ref.read(loginprovider).saveUser()
                                //if (_formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                //Utils.snackBar('Processing', context);
                                //Utils.flushBarErrorMessage('Processing', context);
                                /*var map = new Map<String, dynamic>();
                          map['email'] = _emailController.text.toString();
                          map['password'] = _passwordController.text.toString();*/
                                //print(map);
                                /*Map data = {
                            'email': _emailController.text.toString(),
                            'password': _passwordController.text.toString()
                          };*/

                                authviewModel.loginApi(
                                    _emailController.text.toString(),
                                    _passwordController.text.toString(),
                                    context);
                              },
                              loading: authviewModel.loading,
                              //}
                            )),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text("Forgot Password?",
                              style: TextStyle(
                                  fontFamily: 'Gotham',
                                  fontSize: 18,
                                  color: AppColor.whiteTextColor))),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("DONT HAVE AN ACCOUNT?",
                        style: TextStyle(
                            fontFamily: 'Gotham',
                            color: AppColor.whiteTextColor,
                            fontSize: 18)),
                    Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 144, 3, 3)),
                      child: IconButton(
                          iconSize: 30,
                          onPressed: () {
                            print(MediaQuery.of(context).size.height);
                            Navigator.pushNamed(context, RoutesName.signUp);
                          },
                          icon: const Icon(
                            Icons.add,
                            color: AppColor.whiteTextColor,
                          )),
                    )
                  ],
                ),
              )
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
