import 'package:flutter/material.dart';
import 'package:untitled/res/assets_res.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'Flutter Demo Home Page',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const TransitionAppBar(),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
              child: Center(
                child: Text(
                  'Scroll to see the SliverAppBar in effect.',
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  color: index.isOdd ? Colors.white : Colors.black12,
                  height: 100.0,
                  child: Center(
                    child: Text(
                      '$index',
                      textScaleFactor: 5,
                    ),
                  ),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class TransitionAppBar extends StatelessWidget {
  final double extent;

  const TransitionAppBar({
    Key? key,
    this.extent = 250,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _TransitionAppBarDelegate(
        extent: extent > 200 ? extent : 200,
      ),
    );
  }
}

class _TransitionAppBarDelegate extends SliverPersistentHeaderDelegate {
  final _progressMarginTween = EdgeInsetsTween(
    begin: const EdgeInsets.only(
      bottom: 10,
    ),
    end: const EdgeInsets.only(
      bottom: 80.0,
    ),
  );

  final _logoAlignTween = AlignmentTween(
    begin: Alignment.centerLeft,
    end: Alignment.center,
  );

  final _timeProgressMarginTween = EdgeInsetsTween(
    begin: const EdgeInsets.only(
      bottom: 40.0,
    ),
    end: const EdgeInsets.only(
      bottom: 50.0,
    ),
  );

  final _buttonProgressMarginTween = EdgeInsetsTween(
    begin: const EdgeInsets.only(
      bottom: 10.0,
    ),
    end: const EdgeInsets.only(
      bottom: 1.0,
    ),
  );

  final _buttonAlignTween = AlignmentTween(
    begin: Alignment.centerRight,
    end: Alignment.bottomCenter,
  );

  final double extent;

  _TransitionAppBarDelegate({
    this.extent = 250,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = (maxExtent - shrinkOffset) / maxExtent;
    final avatarAlign = _logoAlignTween.lerp(progress);
    final progressMargin = _progressMarginTween.lerp(progress);
    final timeMargin = _timeProgressMarginTween.lerp(progress);
    final buttonAlign = _buttonAlignTween.lerp(progress);
    const buttonSize = 38.0;

    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: extent,
          color: Colors.teal,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            AssetsRes.BACKGROUND,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Align(
          alignment: avatarAlign,
          child: Image.asset(
            AssetsRes.LOGO,
            width: 80,
            fit: BoxFit.fitHeight,
          ),
        ),
        Padding(
          padding: timeMargin,
          child: const Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              'De 9:55 à 20h30',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: progressMargin,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: const LinearProgressIndicator(
                color: Colors.white,
                value: 10,
                backgroundColor: Colors.white38,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: buttonAlign,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: buttonSize,
                  height: buttonSize,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(buttonSize / 2),
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  width: buttonSize,
                  height: buttonSize,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(buttonSize / 2),
                  ),
                  child: const Icon(
                    Icons.headphones,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => extent;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(_TransitionAppBarDelegate oldDelegate) {
    return true;
  }
}
