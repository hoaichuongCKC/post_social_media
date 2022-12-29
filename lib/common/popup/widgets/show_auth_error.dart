import 'package:post_media_social/config/export.dart';

class ShowAuthError extends StatelessWidget {
  const ShowAuthError({
    super.key,
    required this.size,
    required this.error,
  });

  final Size size;
  final String error;
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
          height: size.height * .55,
          constraints: const BoxConstraints(
            maxHeight: 350.0,
            minHeight: 200.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: FittedBox(
                  child: SvgPicture.asset("assets/images/img-popup-error.svg"),
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
                          "Error",
                          style: TextStyle(
                            color: AppColors.error,
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
                          Flexible(
                            child: FractionallySizedBox(
                              heightFactor: 0.9,
                              child: Text(
                                error,
                                style: const TextStyle(
                                  color: AppColors.dark,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w300,
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              ),
                            ),
                          ),
                          ButtonCustom(
                              text: "Ok",
                              onPressed: () => AppRoutes.pop(),
                              width: size.width * 0.6),
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
