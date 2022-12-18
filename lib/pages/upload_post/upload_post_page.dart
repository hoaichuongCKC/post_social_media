import 'package:post_media_social/common/widgets/button_cts.dart';
import 'package:post_media_social/config/export.dart';
import 'package:post_media_social/pages/upload_post/components/header_upload.dart';

class UploadPostPage extends StatefulWidget {
  const UploadPostPage({super.key});

  @override
  State<UploadPostPage> createState() => _UploadPostPageState();
}

class _UploadPostPageState extends State<UploadPostPage> {
  final somethingText = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    somethingText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.light,
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            'Upload post',
            style: GoogleFonts.robotoMono(
              fontSize: 22.0,
              color: AppColors.dark,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ButtonCustom(
            text: "Upload",
            onPressed: () {},
            width: double.infinity,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderUploadPost(),
              TextFormField(
                maxLines: 5,
                minLines: 1,
                style: GoogleFonts.robotoMono(
                  fontSize: 16.0,
                  color: AppColors.dark,
                  fontWeight: FontWeight.w400,
                ),
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  hintText: "Tùnglakachim, What are you thinking?",
                  filled: true,
                  fillColor: AppColors.disable.withOpacity(0.2),
                  hintStyle: GoogleFonts.robotoMono(
                    fontSize: 13.0,
                    color: AppColors.disable,
                    fontWeight: FontWeight.w400,
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
              const SizedBox(height: 15.0),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.light,
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  border: Border.all(color: AppColors.disable),
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 200,
                    minHeight: 150,
                  ),
                  child: SizedBox(
                      width: size.width,
                      height: size.height * 0.2,
                      child: Align(
                        child: SvgPicture.asset(
                          "assets/images/img-select-file.svg",
                          width: 80,
                          height: 60,
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
