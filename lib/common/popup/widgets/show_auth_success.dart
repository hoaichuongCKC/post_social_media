import '../../../config/export.dart';

class ShowAuthSuccess extends StatelessWidget {
  const ShowAuthSuccess({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: const BoxDecoration(
            color: AppColors.light,
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          width: size.width * .75,
          height: size.height * .5,
          // constraints: const BoxConstraints(
          //   maxHeight: 300.0,
          //   minHeight: 200.0,
          // ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: FittedBox(
                  child:
                      SvgPicture.asset("assets/images/img-popup-success.svg"),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 15.0),
                    const Expanded(
                      child: FittedBox(
                        child: Text(
                          "Congratulations!",
                          style: TextStyle(
                            color: AppColors.success,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "Your account is ready to use. You",
                            style: TextStyle(
                              color: AppColors.dark,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Text(
                            "will be redirected to the Home",
                            style: TextStyle(
                              color: AppColors.dark,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Text(
                            "Page in a few seconds.",
                            style: TextStyle(
                              color: AppColors.dark,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 7.0),
                          spinkit,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
