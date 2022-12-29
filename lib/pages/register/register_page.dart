import 'dart:io';

import 'package:post_media_social/bloc/register/register_bloc.dart';

import 'package:post_media_social/pages/register/components/header_register.dart';

import '../../config/export.dart';
import 'components/form_register.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: BlocProvider(
        create: (context) => sl<RegisterBloc>(),
        child: Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ArrowBackWidget(),
                HeaderRegister(size: size),
                const FormRegister(),
                const SizedBox(height: 30.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
