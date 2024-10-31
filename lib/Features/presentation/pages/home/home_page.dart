import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/Features/presentation/pages/profile/pofile.dart';
import 'package:spotify/Features/presentation/widgets/news_songs.dart';
import 'package:spotify/Features/presentation/widgets/play_list.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';

import '../../../../core/configs/assets/app_images.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        hideBackButton: true,
        actions: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage(),));
          },
          icon: const Icon(Icons.person_rounded),
        ),
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _homeTopCard(),
            _tabs(),
            SizedBox(
              height: 260,
              child: TabBarView(
                  controller: tabController,
                  children: const [
                    NewsSongs(),
                    Center(child: Text("Videos")),
                    Center(child: Text("Artists")),
                    Center(child: Text("Podcasts")),

                  ]),
            ),
            const PlayList()
          ],
        ),
      ),
    );
  }

  Widget _homeTopCard() {
    return Center(
      child: SizedBox(
        height: 188,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            SvgPicture.asset(AppVectors.homeArtist),
            Image.asset(AppImages.homeArtist),
          ],
        ),
      ),
    );
  }

  Widget _tabs() {
    return TabBar(
        controller: tabController,
        labelColor: context.isDarkMode ? Colors.white : Colors.black,
        isScrollable: true,
        dividerHeight: 0,
        dividerColor: Colors.transparent,
        indicatorColor: AppColors.primary,
        tabAlignment: TabAlignment.start,

        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        tabs:  const [
          Text("News",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
          Text("Videos",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
          Text("Artists",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
          Text("Podcasts",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
        ]);
  }
}
