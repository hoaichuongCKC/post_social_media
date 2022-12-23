import '../../../config/export.dart';

class HeaderOtp extends StatelessWidget {
  const HeaderOtp({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 250,
        minHeight: 200.0,
      ),
      child: SizedBox(
        width: double.infinity,
        height: size.height * 0.4,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: FractionallySizedBox(
                heightFactor: 0.4,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Flexible(
                        child: FittedBox(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Verified",
                            style: GoogleFonts.robotoMono(
                              fontSize: 20.0,
                              color: AppColors.dark,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: FittedBox(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "OTP code",
                            style: GoogleFonts.robotoMono(
                              fontSize: 20.0,
                              color: AppColors.dark,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: size.width * 0.03),
            Expanded(
              flex: 2,
              child: SvgPicture.asset(
                "assets/images/img-otp.svg",
                fit: BoxFit.contain,
              ),
            )
          ],
        ),
      ),
    );
  }
}
