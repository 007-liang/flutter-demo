import 'package:fluwx/fluwx.dart';

share() => shareToWeChat(WeChatShareWebPageModel(
      'http://apptest.quguonet.com/nkuw',
      title: '手机定位迹寻app下载',
      thumbnail: WeChatImage.asset('assets/images/welcome.png'),
      scene: WeChatScene.SESSION,
    ));
