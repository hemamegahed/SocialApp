import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ksocial_app/layout/cubit/cubit.dart';
import 'package:ksocial_app/layout/cubit/states.dart';
import 'package:ksocial_app/modules/chat_details/chat_details_screen.dart';
import 'package:ksocial_app/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SocialCubit.get(context).users.length > 0 ? ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildChatItem(SocialCubit.get(context).users[index], context),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: SocialCubit.get(context).users.length,
        ) : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildChatItem(model, context) => InkWell(
        onTap: () {
          navigateTo(context, ChatDetailsScreen(model));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage('${model.image}'),
              ),
              SizedBox(
                width: 15.0,
              ),
              Text('${model.name}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
      );
}
