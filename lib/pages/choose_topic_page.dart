import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditation/data/topic_data.dart';
import 'package:meditation/models/topic_model.dart';
import 'package:meditation/theme/theme.dart';
import 'package:meditation/widgets/responsive_builder.dart';

final topicStorage = AssetTopicStorage();

class ChooseTopicPage extends StatelessWidget {
  const ChooseTopicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ResponsiveBuilder(
          portrait: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: _Header(),
              ),
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: _TopicGridView(),
              ),
            ],
          ),
          landscape: Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Column(
                  children: const [
                    Expanded(child: _Header()),
                    Spacer(),
                  ],
                ),
              ),
              const Flexible(flex: 2, fit: FlexFit.tight, child: _TopicGridView()),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopicGridView extends StatelessWidget {
  const _TopicGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Topic>>(
      future: topicStorage.load(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final topics = snapshot.data!;
        return MasonryGridView.count(
          crossAxisCount: 2,
          itemCount: topics.length,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          itemBuilder: (context, index) {
            final topic = topics[index];
            return DecoratedBox(
              decoration: BoxDecoration(
                color: topic.bgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  LayoutBuilder(
                    builder: (context, constraint) {
                      return SvgPicture.asset(
                        topic.thumbnail,
                        width: constraint.maxWidth,
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      topic.title,
                      style: PrimaryFont.bold(18).copyWith(color: topic.textColor),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(flex: 3),
          Flexible(
            flex: 3,
            child: FittedBox(
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: PrimaryFont.bold(28).copyWith(
                    color: kColorDarkGrey,
                    height: 1.3,
                  ),
                  text: 'What Brings you\n',
                  children: <TextSpan>[
                    TextSpan(
                      text: 'to Silent Moon?',
                      style: PrimaryFont.thin(28),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Flexible(
            flex: 1,
            child: FittedBox(
              child: Text(
                'choose a topic to focuse on:',
                style: PrimaryFont.thin(20).copyWith(
                  color: kColorDarkGrey,
                ),
              ),
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
