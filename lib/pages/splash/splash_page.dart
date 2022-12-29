import 'dart:async';

import 'package:post_media_social/bloc/user/user_bloc.dart';

import '../../config/export.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => sl<UserBloc>(),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              height: double.infinity,
              width: size.width,
              child: const BodySplash(),
            ),
          ),
        ),
      ),
    );
  }
}

class BodySplash extends StatefulWidget {
  const BodySplash({
    super.key,
  });

  @override
  State<BodySplash> createState() => _BodySplashState();
}

class _BodySplashState extends State<BodySplash> {
  late UserBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<UserBloc>(context);

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timer.tick == 1) {
        bloc.add(CheckData());
        timer.cancel();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(flex: 2),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: SvgPicture.asset("assets/icons/logo.svg"),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: FractionallySizedBox(
            heightFactor: 0.25,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                "Mr.Chương Social",
                style: AppStyleText.heading1StyleColor,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: spinkit,
        )
      ],
    );
  }
}
