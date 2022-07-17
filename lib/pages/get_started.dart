import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditation/theme/app_assets.dart';
import 'package:meditation/theme/theme.dart';
import 'package:meditation/extensions/app_extensions.dart';
import 'package:meditation/widgets/responsive_builder.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kColorPrimary,
      body: SafeArea(
        child: ResponsiveBuilder(
          portrait: Stack(
            children: [
              const GetStartedBackground(),
              const FractionallySizedBox(
                heightFactor: 0.4,
                widthFactor: 1,
                child: GetStartedHeader(),
              ),
              Align(
                alignment: const Alignment(0, 0.85),
                child: _GetStatedButton(
                  fixedSize: MaterialStateProperty.all(
                    Size(size.width * 0.9, size.height * 0.065),
                  ),
                  textStyle: MaterialStateProperty.all(
                    PrimaryFont.bold(size.height * 0.015),
                  ),
                ),
              ),
            ],
          ),
          landscape: Row(
            children: [
              const Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: FractionallySizedBox(
                    heightFactor: 0.8,
                    child: GetStartedHeader(),
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    const GetStartedBackground(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: _GetStatedButton(
                        fixedSize: MaterialStateProperty.all(
                          Size(size.width * 0.4, size.height * 0.065),
                        ),
                        textStyle: MaterialStateProperty.all(
                          PrimaryFont.bold(size.height * 0.015),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GetStatedButton extends StatelessWidget {
  const _GetStatedButton({
    Key? key,
    required this.fixedSize,
    required this.textStyle,
  }) : super(key: key);

  final MaterialStateProperty<Size>? fixedSize;
  final MaterialStateProperty<TextStyle>? textStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushNamed('ChooseTopicPage');
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(kColorLightGrey),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(38),
          ),
        ),
        elevation: MaterialStateProperty.all(0),
        fixedSize: fixedSize,
        foregroundColor: MaterialStateProperty.all(kColorDarkGrey),
        textStyle: textStyle,
      ),
      child: const Text('GET STARTED'),
    );
  }
}

class GetStartedBackground extends StatelessWidget {
  const GetStartedBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: context.orientation == Orientation.portrait ? 0.6 : 0.8,
        widthFactor: 1,
        child: FittedBox(
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
          child: SvgPicture.asset(AppAssets.BG_GET_STATED),
        ),
      ),
    );
  }
}

class GetStartedHeader extends StatelessWidget {
  const GetStartedHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: SvgPicture.asset(
            AppAssets.IC_LOGO,
            alignment: const Alignment(0.0, -0.8),
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: FittedBox(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Hi Afsar, Welcome\n',
                style: PrimaryFont.bold(30).copyWith(
                  color: kColorLightYellow,
                  height: 1.3,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'to Silent Moon',
                    style: PrimaryFont.thin(30),
                  ),
                ],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Align(
              alignment: Alignment.center,
              child: FittedBox(
                child: Text(
                  'Explore the app, Find some peace of mind \nto prepare for meditation.',
                  style: PrimaryFont.light(16).copyWith(
                    color: kColorLightGrey,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
