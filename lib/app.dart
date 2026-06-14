import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'viewmodels/quiz_viewmodel.dart';
import 'viewmodels/story_viewmodel.dart';
import 'views/story_buddy_screen.dart';

class AiStoryBuddyApp extends StatelessWidget {
  const AiStoryBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StoryViewModel()),
        ChangeNotifierProvider(create: (_) => QuizViewModel()),
      ],
      child: MaterialApp(
        title: AppStrings.appTitle,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const StoryBuddyScreen(),
      ),
    );
  }
}
