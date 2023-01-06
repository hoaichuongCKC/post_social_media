import 'dart:io';

import 'package:post_media_social/bloc/upload/upload_post_bloc.dart';
import 'package:post_media_social/common/popup/upload_post/popup_uploadpost_control.dart';
import 'package:post_media_social/config/export.dart';

import 'package:post_media_social/pages/upload_post/components/header_upload.dart';

class BodyUploadPost extends StatefulWidget {
  const BodyUploadPost({super.key});

  @override
  State<BodyUploadPost> createState() => _BodyUploadPostState();
}

class _BodyUploadPostState extends State<BodyUploadPost> {
  final somethingText = TextEditingController();

  List<XFile>? _image;

  List<File>? _imageFile;

  late UploadPostBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<UploadPostBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    if (_image != null) {
      _image!.clear();
    }
    if (_imageFile != null) {
      _imageFile!.clear();
    }
    bloc.close();

    somethingText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.light,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Upload post',
          style: GoogleFonts.roboto(
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
          onPressed: () => bloc.add(SubmitPostEvent(
              content: somethingText.text, file: _imageFile ?? [])),
          width: double.infinity,
        ),
      ),
      body: BlocListener<UploadPostBloc, UploadPostState>(
        listener: (context, state) async {
          if (state is UploadingPostState) {
            FocusScope.of(context).unfocus();
            PopupUploadPostControl.instance.showLoading(context, size);
          }
          if (state is UploadPostErrorState) {
            AppRoutes.pop();
            PopupControl.instance
                .showAuthError(context: context, error: state.message);
          }
          if (state is UploadPostSuccessfulState) {
            AppRoutes.pop();
            PopupUploadPostControl.instance
                .showUploadSuccessful(context: context);
            await Future.delayed(const Duration(seconds: 2), () {
              AppRoutes.pop();
              AppRoutes.pop();
            });
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderUploadPost(),
              const SizedBox(height: 15.0),
              ValueListenableBuilder<Box<UserHive>>(
                valueListenable:
                    Hive.box<UserHive>(BoxUser.nameBox).listenable(),
                builder: (context, box, child) {
                  final boxUser = box.values.first;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: somethingText,
                        maxLines: 5,
                        minLines: 1,
                        style: GoogleFonts.roboto(
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
                          hintStyle: GoogleFonts.roboto(
                            fontSize: 13.0,
                            color: AppColors.disable,
                            fontWeight: FontWeight.w400,
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      StatefulBuilder(
                        builder: (context, setState) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              InkWell(
                                onTap: () async {
                                  _image = await sl
                                      .get<CameraServiceApp>()
                                      .pickMultiImage() as List<XFile>;
                                  if (_image != null) {
                                    _imageFile = await sl
                                        .get<ImageCompressService>()
                                        .compressAndGetListFile(
                                            _image!, boxUser.username);
                                    setState(() {});
                                  }
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: SvgPicture.asset(
                                        "assets/images/img-select-file.svg",
                                        width: 40,
                                        height: 40,
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    _imageFile == null
                                        ? const SizedBox()
                                        : Text(
                                            '${_imageFile!.length} ảnh đã được chọn',
                                            style: GoogleFonts.roboto(
                                                fontSize: 14.0,
                                                color: AppColors.primary),
                                          )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              _imageFile == null
                                  ? const SizedBox()
                                  : ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        maxHeight: 300,
                                        minHeight: 250,
                                      ),
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: size.height * .3,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: _imageFile!.map(
                                            (e) {
                                              final index =
                                                  _imageFile!.indexOf(e);
                                              return Expanded(
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    Expanded(
                                                      child: Image.file(
                                                        e,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    if (_imageFile!.length > 1)
                                                      index ==
                                                              _imageFile!
                                                                      .length -
                                                                  1
                                                          ? const SizedBox()
                                                          : const SizedBox(
                                                              width: 5),
                                                  ],
                                                ),
                                              );
                                            },
                                          ).toList(),
                                        ),
                                      ),
                                    )
                            ],
                          );
                        },
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
