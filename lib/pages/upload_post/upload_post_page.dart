import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:post_media_social/bloc/upload/upload_post_bloc.dart';
import 'package:post_media_social/config/export.dart';
import 'package:post_media_social/core/camera/camera_app.dart';
import 'package:post_media_social/core/hive/user_hive.dart';
import 'package:post_media_social/pages/upload_post/components/header_upload.dart';

class UploadPostPage extends StatefulWidget {
  const UploadPostPage({super.key});

  @override
  State<UploadPostPage> createState() => _UploadPostPageState();
}

class _UploadPostPageState extends State<UploadPostPage> {
  final somethingText = TextEditingController();

  List<XFile>? _image;
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
      child: BlocProvider(
        create: (context) => sl<UploadPostBloc>(),
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
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderUploadPost(),
                ValueListenableBuilder<Box<UserHive>>(
                    valueListenable:
                        Hive.box<UserHive>(BoxUser.nameBox).listenable(),
                    builder: (context, box, child) {
                      final boxUser = box.values.first;
                      return TextFormField(
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
                          hintText:
                              "${boxUser.displayName}, What are you thinking?",
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
                      );
                    }),
                const SizedBox(height: 15.0),
                DecoratedBox(
                  decoration: const BoxDecoration(
                    color: AppColors.light,
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 200,
                      minHeight: 150,
                    ),
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        return InkWell(
                          onTap: () async {
                            _image = await sl
                                .get<CameraServiceApp>()
                                .pickMultiImage();
                            setState(() {});
                          },
                          child: SizedBox(
                            width: size.width,
                            height: size.height * 0.2,
                            child: _image == null
                                ? Align(
                                    child: SvgPicture.asset(
                                      "assets/images/img-select-file.svg",
                                      width: 80,
                                      height: 60,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12.0),
                                    ),
                                    child: Image.file(
                                      File(_image![0].path),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
