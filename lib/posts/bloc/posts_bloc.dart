import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_sample_api/posts/models/post_model.dart';
import 'package:bloc_sample_api/posts/respos/post_repo.dart';
import 'package:bloc_sample_api/posts/ui/posts.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostInitialFetchEvent>(postInitialFetchEvent);
  }

  FutureOr<void> postInitialFetchEvent(
      PostInitialFetchEvent event, Emitter<PostsState> emit) async {
    // emit()
    emit(PostLoadingState());
    List<PostModel> postList = await PostRepo.fetchPost();
    // try {

    // } catch (e) {
    //   emit(PostFetchErrorState());
    // }
    emit(PostsLoadingSuccessState(posts: postList));
  }
}
