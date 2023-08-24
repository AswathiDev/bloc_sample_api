import 'package:bloc_sample_api/posts/bloc/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Posts> {
  final PostsBloc postBloc = PostsBloc();

  @override
  void initState() {
    super.initState();
    postBloc.add(PostInitialFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: BlocConsumer<PostsBloc, PostsState>(
        bloc: postBloc,
        listenWhen: (previous, current) => current is PostsActionState,
        buildWhen: (previous, current) => current is !PostsActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
             case PostLoadingState:
             return const Center(child: CircularProgressIndicator());
            case PostsLoadingSuccessState:
              final successState = state as PostsLoadingSuccessState;
              return ListView.builder(
                itemCount: successState.posts.length,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: Color.fromARGB(255, 115, 171, 214)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        successState.posts[index].title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(successState.posts[index].body),
                      // ElevatedButton(onPressed: onPressed, child: Text('Click'))
                    ],
                  ),
                ),
              );

            default:
              return const SizedBox(
                height: 10,
              );
          }
        },
      ),
    );
  }
}
