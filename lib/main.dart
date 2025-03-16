import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktik_app/config/theme/app_theme.dart';
import 'package:toktik_app/infrastructure/datasources/local_video_datasource_impl.dart';
import 'package:toktik_app/infrastructure/repositories/video_posts_repository_impl.dart';
import 'package:toktik_app/presentation/providers/discover_provider.dart';
import 'package:toktik_app/presentation/screens/discover/discover_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final videoPostRepository = VideoPostRepositoryImpl(
        videoPostsDatasource: LocalVideoDataSourceImpl());

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            lazy: false,

            /// NOTE: This is because we want to load the videos as soon as the app starts.
            create: (_) =>
                DiscoverProvider(videosRepository: videoPostRepository)
                  ..loadNextPage()),
      ],
      child: MaterialApp(
        title: 'TokTik App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme().getTheme(),
        home: const DiscoverScreen(),
      ),
    );
  }
}
