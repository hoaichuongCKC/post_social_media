import 'package:post_media_social/config/export.dart';

class PopupNotiControl {
  PopupNotiControl._();

  static PopupNotiControl instance = PopupNotiControl._();

  static OverlayEntry? _overlayEntry;

  static bool isVisible = false;

  void showOption(GlobalKey keyItem, BuildContext context) {
    if (isVisible) return;

    final renderBox = keyItem.currentContext!.findRenderObject() as RenderBox;
    final size = MediaQuery.of(context).size;
    var overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        top: renderBox.size.height,
        right: 10,
        width: renderBox.size.width / 1.7,
        child: Material(
          color: AppColors.light,
          elevation: 10.0,
          shadowColor: AppColors.dark.withOpacity(0.4),
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 40,
                    minHeight: 35.0,
                  ),
                  child: SizedBox(
                    height: size.height * .04,
                    child: InkWell(
                      onTap: () {
                        dismiss();
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/icons/trash.svg"),
                          const SizedBox(width: 10.0),
                          Text(
                            'Delete all',
                            style: GoogleFonts.robotoMono(
                              fontSize: 14.0,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 40,
                    minHeight: 35.0,
                  ),
                  child: SizedBox(
                    height: size.height * .04,
                    child: InkWell(
                      onTap: () {
                        dismiss();
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/icons/check-mark.svg"),
                          const SizedBox(width: 10.0),
                          Text(
                            'Read all',
                            style: GoogleFonts.robotoMono(
                              fontSize: 14.0,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    isVisible = true;

    overlayState.insert(_overlayEntry!);
  }

  void showDeleteItem(BuildContext context, {required VoidCallback onTap}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/icons/trash.svg"),
              const SizedBox(width: 6.0),
              Text(
                'Delete item?',
                style: GoogleFonts.robotoMono(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.end,
          // actionsOverflowButtonSpacing: 1.0,
          actionsPadding: const EdgeInsets.fromLTRB(0, 0, 20, 15),
          actions: [
            InkWell(
              onTap: onTap,
              child: Text(
                'Yes',
                style: GoogleFonts.robotoMono(
                  fontSize: 12.0,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(width: 20.0),
            InkWell(
              onTap: () => AppRoutes.pop(),
              child: Text(
                'No',
                style: GoogleFonts.robotoMono(
                  fontSize: 12.0,
                  color: AppColors.disable,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void dismiss() {
    if (isVisible) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      isVisible = false;
    }
  }
}
