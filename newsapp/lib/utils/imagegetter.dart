import 'package:flutter/material.dart';

class ImageProviderUtil {
  static ImageProvider getImageProvider(String imageUrl, String defaultAssetImageDir) {
    if (imageUrl.toString() == "null"  ) {
      return AssetImage(defaultAssetImageDir);
    } else {
      return NetworkImage(imageUrl);

    }
  }
}
