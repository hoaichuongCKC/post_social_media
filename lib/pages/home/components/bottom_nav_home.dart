// ignore_for_file: must_be_immutable

import '../../../config/export.dart';

class BottomNavHome extends StatelessWidget {
  BottomNavHome({super.key, required this.onTap});
  final Function(int) onTap;
  int indexHome = 0;
  int indexProfile = 1;
  int initIndex = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.light,
        boxShadow: [
          BoxShadow(
            color: AppColors.dark.withOpacity(0.25),
            blurRadius: 50,
            offset: const Offset(0, 0),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 60,
          minHeight: 40,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            width: double.infinity,
            height: size.height * 0.1,
            child: StatefulBuilder(builder: (context, setState) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildBottomNavItem(
                    label: "Home",
                    urlIcon: "home.svg",
                    myIndex: indexHome,
                    currentIndex: initIndex,
                    onTap: () {
                      onTap(indexHome);
                      initIndex = indexHome;
                      setState(() {});
                    },
                  ),
                  _buildBottomNavItem(
                    label: "Profile",
                    urlIcon: "user.svg",
                    currentIndex: initIndex,
                    myIndex: indexProfile,
                    onTap: () {
                      onTap(indexProfile);
                      initIndex = indexProfile;
                      setState(() {});
                    },
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem({
    required String label,
    required String urlIcon,
    required VoidCallback onTap,
    required int myIndex,
    required int currentIndex,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Stack(
          fit: StackFit.loose,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset("assets/icons/$urlIcon"),
                const SizedBox(width: 6.0),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    label,
                    style: GoogleFonts.robotoMono(
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: FractionallySizedBox(
                widthFactor: 0.7,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 200,
                  height: myIndex == initIndex ? 5.0 : .0,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5.0),
                      bottomRight: Radius.circular(5.0),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
