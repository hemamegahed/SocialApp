import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ksocial_app/layout/cubit/cubit.dart';
import 'package:ksocial_app/layout/cubit/states.dart';
import 'package:ksocial_app/shared/components/components.dart';
import 'package:ksocial_app/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        nameController.text = SocialCubit.get(context).userModel!.name!;
        phoneController.text = SocialCubit.get(context).userModel!.phone!;
        bioController.text = SocialCubit.get(context).userModel!.bio!;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(IconBroken.Arrow___Left_2),
            ),
            titleSpacing: 5.0,
            title: Text('Edit Profile'),
            actions: [
              defaultTextButton(
                function: () {
                  if(formKey.currentState!.validate()){
                    if(SocialCubit.get(context).coverImage != null && SocialCubit.get(context).profileImage != null) {
                      SocialCubit.get(context).uploadProfileAndCover(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text,
                      );
                    } else if(SocialCubit.get(context).profileImage != null) {
                      SocialCubit.get(context).uploadProfileImage(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text,
                      );
                    } else if (SocialCubit.get(context).coverImage != null) {
                      SocialCubit.get(context).uploadCoverImage(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text,
                      );
                    } else {
                      SocialCubit.get(context).updateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text,
                      );
                    }
                  }
                },
                text: 'Update',
              ),
              SizedBox(width: 15.0),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is SocialUpdateLoadingState)
                      LinearProgressIndicator(),
                    if (state is SocialUpdateLoadingState)
                      SizedBox(
                        height: 10.0,
                      ),
                    Container(
                      height: 190.0,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 140.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadiusDirectional.only(
                                      topStart: Radius.circular(4.0),
                                      topEnd: Radius.circular(4.0),
                                    ),
                                    image: DecorationImage(
                                      image: SocialCubit.get(context).coverImage == null ? NetworkImage('${SocialCubit.get(context).userModel!.cover}') : FileImage( SocialCubit.get(context).coverImage!) as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: CircleAvatar(
                                    radius: 20.0,
                                    child: Icon(IconBroken.Camera,
                                      size: 16.0,
                                    ),
                                  ),
                                  onPressed: () {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 64.0,
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 60.0,
                                  backgroundImage: SocialCubit.get(context).profileImage == null ? NetworkImage('${SocialCubit.get(context).userModel!.image}') : FileImage(SocialCubit.get(context).profileImage!) as ImageProvider,
                                ),
                              ),
                              IconButton(
                                icon: CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(IconBroken.Camera,
                                    size: 16.0,
                                  ),
                                ),
                                onPressed: () {
                                  SocialCubit.get(context).getProfileImage();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefix: IconBroken.User,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    defaultFormField(
                      controller: bioController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'bio must not be empty';
                        }
                        return null;
                      },
                      label: 'Bio',
                      prefix: IconBroken.Info_Circle,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'phone number must not be empty';
                        }

                        return null;
                      },
                      label: 'Phone',
                      prefix: IconBroken.Call,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
