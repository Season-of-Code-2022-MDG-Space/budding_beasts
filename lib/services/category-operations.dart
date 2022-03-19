import '../model/category.dart';

class CategoryOperations {
  CategoryOperations._();
  static List<category> getCategories() {
    return <category>[
      category(
          'Lo-Fi 1',
          'Study!',
          'https://64.media.tumblr.com/2474f73eb9e1f6026a0ca8882ed696e1/0d80a09f5022bf82-f9/s128x128u_c1/8c2a062aa5c5412cc7712f92341062f9be31e001.jpg',
          'https://audio-previews.elements.envatousercontent.com/files/272833782/preview.mp3?response-content-disposition=attachment%3B+filename%3D%22KJVX97F-daydream-lo-fi-hip-hop.mp3%22'),
      category(
          'Lo-Fi 2',
          'Study!',
          'https://64.media.tumblr.com/2474f73eb9e1f6026a0ca8882ed696e1/0d80a09f5022bf82-f9/s128x128u_c1/8c2a062aa5c5412cc7712f92341062f9be31e001.jpg',
          'https://audio-previews.elements.envatousercontent.com/files/294689298/preview.mp3?response-content-disposition=attachment%3B+filename%3D%22ASUJ36G-chill-lo-fi.mp3%22'),
      category(
          'Lo-Fi 3',
          'Study!',
          'https://64.media.tumblr.com/2474f73eb9e1f6026a0ca8882ed696e1/0d80a09f5022bf82-f9/s128x128u_c1/8c2a062aa5c5412cc7712f92341062f9be31e001.jpg',
          'https://audio-previews.elements.envatousercontent.com/files/356292585/preview.mp3?response-content-disposition=attachment%3B+filename%3D%22SZLP34Y-the-lo-fi.mp3%22'),
      category(
          'Lo-Fi 4',
          'Study!',
          "https://64.media.tumblr.com/2474f73eb9e1f6026a0ca8882ed696e1/0d80a09f5022bf82-f9/s128x128u_c1/8c2a062aa5c5412cc7712f92341062f9be31e001.jpg",
          'https://assets.mixkit.co/music/preview/mixkit-sleepy-cat-135.mp3'),
    ];
  }
}
