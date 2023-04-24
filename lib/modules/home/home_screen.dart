import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ksocial_app/layout/cubit/cubit.dart';
import 'package:ksocial_app/layout/cubit/states.dart';
import 'package:ksocial_app/shared/styles/colors.dart';
import 'package:ksocial_app/shared/styles/icon_broken.dart';

class HomeScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return (SocialCubit.get(context).posts.length > 0 && SocialCubit.get(context).userModel != null) ?
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children:
            [
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer, //aLSHAN EL SORA TAKHOD ELZAWYA BTAA EL Card
                elevation: 5.0,
                margin: EdgeInsets.all(8.0),
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Image(
                      image: NetworkImage(
                        'https://image.freepik.com/free-photo/photo-attractive-bearded-young-man-with-cherful-expression-makes-okay-gesture-with-both-hands-likes-something-dressed-red-casual-t-shirt-poses-against-white-wall-gestures-indoor_273609-16239.jpg',
                      ),
                      fit: BoxFit.cover,
                      height: 200.0,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'communicate with friends',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts[index],context),
                separatorBuilder: (context, index) => SizedBox(height: 8.0),
                itemCount: SocialCubit.get(context).posts.length,
              ),
              SizedBox(
                height: 8.0,
              ),
            ],
          ),
        ) : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildPostItem(model, context) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    color: Theme.of(context).scaffoldBackgroundColor, //alshan ykon nafs lon el scafold fe el dark mode
    elevation: 15.0,
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage('${model.image}'),
              ),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('${model.name}',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: defaultColor,
                          size: 16.0,
                        ),
                      ],
                    ),
                    Text(
                      '${model.dateTime}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          Text('${model.text}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          if(model.postImage != '')
            Padding(
              padding: const EdgeInsetsDirectional.only(
                  top: 15.0
              ),
              child: Container(
                height: 140.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  image: DecorationImage(
                    image: NetworkImage(
                      '${model.postImage}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            size: 16.0,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '0 likes',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Chat,
                            size: 16.0,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '0 comment',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
              bottom: 10.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18.0,
                        backgroundImage: NetworkImage(
                          '${SocialCubit.get(context).userModel!.image}',
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'write a comment ...',
                        style:Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                  onTap: () {},
                ),
              ),
              InkWell(
                child: Row(
                  children: [
                    Icon(
                      IconBroken.Heart,
                      size: 16.0,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Like',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                onTap: ()
                {},
              ),
            ],
          ),
        ],
      ),
    ),
  );

}




/////////////////////////////////with like post /////////////////////////////////

//import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:ksocial_app/layout/cubit/cubit.dart';
//import 'package:ksocial_app/layout/cubit/states.dart';
//import 'package:ksocial_app/shared/styles/colors.dart';
//import 'package:ksocial_app/shared/styles/icon_broken.dart';
//
//class HomeScreen extends StatelessWidget
//{
//  @override
//  Widget build(BuildContext context)
//  {
//    return BlocConsumer<SocialCubit, SocialStates>(
//      listener: (context, state) {},
//      builder: (context, state)
//      {
//        return (SocialCubit.get(context).posts.length > 0 && SocialCubit.get(context).userModel != null) ?
//        SingleChildScrollView(
//          physics: BouncingScrollPhysics(),
//          child: Column(
//            children:
//            [
//              Card(
//                clipBehavior: Clip.antiAliasWithSaveLayer,
//                elevation: 5.0,
//                margin: EdgeInsets.all(
//                  8.0,
//                ),
//                child: Stack(
//                  alignment: AlignmentDirectional.bottomEnd,
//                  children: [
//                    Image(
//                      image: NetworkImage(
//                        'https://image.freepik.com/free-photo/photo-attractive-bearded-young-man-with-cherful-expression-makes-okay-gesture-with-both-hands-likes-something-dressed-red-casual-t-shirt-poses-against-white-wall-gestures-indoor_273609-16239.jpg',
//                      ),
//                      fit: BoxFit.cover,
//                      height: 200.0,
//                      width: double.infinity,
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Text(
//                        'communicate with friends',
//                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
//                          color: Colors.white,
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//              ListView.separated(
//                shrinkWrap: true,
//                physics: NeverScrollableScrollPhysics(),
//                itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts[index],context, index),
//                separatorBuilder: (context, index) => SizedBox(
//                  height: 8.0,
//                ),
//                itemCount: SocialCubit.get(context).posts.length,
//              ),
//              SizedBox(
//                height: 8.0,
//              ),
//            ],
//          ),
//        ) : Center(child: CircularProgressIndicator());
//      },
//    );
//  }
//
//  Widget buildPostItem(model, context, index) => Card(
//        clipBehavior: Clip.antiAliasWithSaveLayer,
//        color: Theme.of(context).scaffoldBackgroundColor,
//        elevation: 15.0,
//        margin: EdgeInsets.symmetric(
//          horizontal: 8.0,
//        ),
//        child: Padding(
//          padding: const EdgeInsets.all(10.0),
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: [
//              Row(
//                children: [
//                  CircleAvatar(
//                    radius: 25.0,
//                    backgroundImage: NetworkImage(
//                      '${model.image}',
//                    ),
//                  ),
//                  SizedBox(
//                    width: 15.0,
//                  ),
//                  Expanded(
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: [
//                        Row(
//                          children: [
//                            Text('${model.name}',
//                              style: Theme.of(context).textTheme.subtitle1,
//                            ),
//                            SizedBox(
//                              width: 5.0,
//                            ),
//                            Icon(
//                              Icons.check_circle,
//                              color: defaultColor,
//                              size: 16.0,
//                            ),
//                          ],
//                        ),
//                        Text(
//                          '${model.dateTime}',
//                          style: Theme.of(context).textTheme.bodyText1,
//                        ),
//                      ],
//                    ),
//                  ),
//                ],
//              ),
//              SizedBox(
//                height: 15.0,
//              ),
//              Text('${model.text}',
//                style: Theme.of(context).textTheme.subtitle1,
//              ),
//              if(model.postImage != '')
//                Padding(
//                padding: const EdgeInsetsDirectional.only(
//                  top: 15.0
//                ),
//                child: Container(
//                  height: 140.0,
//                  width: double.infinity,
//                  decoration: BoxDecoration(
//                    borderRadius: BorderRadius.circular(
//                      4.0,
//                    ),
//                    image: DecorationImage(
//                      image: NetworkImage(
//                        '${model.postImage}',
//                      ),
//                      fit: BoxFit.cover,
//                    ),
//                  ),
//                ),
//              ),
//              Padding(
//                padding: const EdgeInsets.symmetric(
//                  vertical: 5.0,
//                ),
//                child: Row(
//                  children: [
//                    Expanded(
//                      child: InkWell(
//                        child: Padding(
//                          padding: const EdgeInsets.symmetric(
//                            vertical: 5.0,
//                          ),
//                          child: Row(
//                            children: [
//                              Icon(
//                                IconBroken.Heart,
//                                size: 16.0,
//                                color: Colors.red,
//                              ),
//                              SizedBox(
//                                width: 5.0,
//                              ),
//                              Text(
//                                '${SocialCubit.get(context).likes[index]}',
//                                style: Theme.of(context).textTheme.bodyText1,
//                              ),
//                            ],
//                          ),
//                        ),
//                        onTap: () {},
//                      ),
//                    ),
//                    Expanded(
//                      child: InkWell(
//                        child: Padding(
//                          padding: const EdgeInsets.symmetric(
//                            vertical: 5.0,
//                          ),
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.end,
//                            children: [
//                              Icon(
//                                IconBroken.Chat,
//                                size: 16.0,
//                                color: Colors.amber,
//                              ),
//                              SizedBox(
//                                width: 5.0,
//                              ),
//                              Text(
//                                '0 comment',
//                                style: Theme.of(context).textTheme.bodyText1,
//                              ),
//                            ],
//                          ),
//                        ),
//                        onTap: () {},
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//              Padding(
//                padding: const EdgeInsets.only(
//                  bottom: 10.0,
//                ),
//                child: Container(
//                  width: double.infinity,
//                  height: 1.0,
//                  color: Colors.grey[300],
//                ),
//              ),
//              Row(
//                children: [
//                  Expanded(
//                    child: InkWell(
//                      child: Row(
//                        children: [
//                          CircleAvatar(
//                            radius: 18.0,
//                            backgroundImage: NetworkImage(
//                              '${SocialCubit.get(context).userModel!.image}',
//                            ),
//                          ),
//                          SizedBox(
//                            width: 15.0,
//                          ),
//                          Text(
//                            'write a comment ...',
//                            style:Theme.of(context).textTheme.bodyText1,
//                          ),
//                        ],
//                      ),
//                      onTap: () {},
//                    ),
//                  ),
//                  InkWell(
//                    child: Row(
//                      children: [
//                        Icon(
//                          IconBroken.Heart,
//                          size: 16.0,
//                          color: Colors.red,
//                        ),
//                        SizedBox(
//                          width: 5.0,
//                        ),
//                        Text(
//                          'Like',
//                          style: Theme.of(context).textTheme.bodyText1,
//                        ),
//                      ],
//                    ),
//                    onTap: ()
//                    {
//                      SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
//                    },
//                  ),
//                ],
//              ),
//            ],
//          ),
//        ),
//      );
//}