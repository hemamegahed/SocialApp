import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ksocial_app/layout/cubit/cubit.dart';
import 'package:ksocial_app/layout/cubit/states.dart';
import 'package:ksocial_app/modules/edit_profile/edit_profile_screen.dart';
import 'package:ksocial_app/modules/social_login/social_login_screen.dart';
import 'package:ksocial_app/shared/components/components.dart';
import 'package:ksocial_app/shared/network/local/cache_helper.dart';
import 'package:ksocial_app/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SocialCubit.get(context).userModel != null ? SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 190.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          height: 140.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.only(
                              topStart: Radius.circular(4.0),
                              topEnd: Radius.circular(4.0),
                            ),
                            image: DecorationImage(
                              image: NetworkImage('${SocialCubit.get(context).userModel!.cover}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 64.0,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor, //to be the same scafold color
                        child: CircleAvatar(
                          radius: 60.0,
                          backgroundImage: NetworkImage('${SocialCubit.get(context).userModel!.image}'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text('${SocialCubit.get(context).userModel!.name}',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text('${SocialCubit.get(context).userModel!.bio}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        FirebaseMessaging.instance.subscribeToTopic('announcements');
                      },
                      child: Text('subscribe'),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        FirebaseMessaging.instance.unsubscribeFromTopic('announcements');
                      },
                      child: Text('unsubscribe'),
                    ),
                    Spacer(),
                    OutlinedButton(
                      onPressed: () {
                        navigateTo(context, EditProfileScreen());
                      },
                      child: Icon(
                        IconBroken.Edit,
                        size: 16.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                defaultButton(  //I added it
                  function: () {
                    CacheHelper.removeData(key: 'uId').then((value) {
                      if(value){
                        navigateAndFinish(context, SocialLoginScreen());
                      }
                    });
                  },
                  text: 'log out',
                ),
              ],
            ),
          ),
        ) : Center(child: CircularProgressIndicator(),);
      },
    );
  }
}
