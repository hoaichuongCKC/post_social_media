import '../../config/export.dart';

class MyPostPage extends StatelessWidget {
  const MyPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'My post',
          style: GoogleFonts.robotoMono(
            fontSize: 22.0,
            color: AppColors.dark,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            child: SvgPicture.asset("assets/images/img-list-empty.svg"),
          ),
          const SizedBox(height: 15.0),
          Align(
            child: Text(
              'List post empty',
              style: GoogleFonts.robotoMono(
                fontSize: 18.0,
                color: AppColors.dark,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}
