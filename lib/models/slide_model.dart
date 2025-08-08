class SlideModel {
  final String title;
  final String subtitle;
  final List<String> bulletPoints;
  final String? imageUrl;

  SlideModel({
    required this.title,
    required this.subtitle,
    this.bulletPoints = const [],
    this.imageUrl,
  });
}

class SlideData {
  static List<SlideModel> getDummySlides() {
    return [
      SlideModel(
        title: "Welcome to Our Presentation",
        subtitle: "Innovative Solutions for Modern Challenges",
        bulletPoints: [
          "Cutting-edge technology solutions",
          "Expert team with 10+ years experience",
          "Proven track record of success",
          "Customer-focused approach",
        ],
      ),
      // SlideModel(
      //   title: "Our Services",
      //   subtitle: "Comprehensive Digital Solutions",
      //   bulletPoints: [
      //     "Web Development & Design",
      //     "Mobile App Development",
      //     "Cloud Infrastructure",
      //     "Digital Marketing",
      //     "Consulting & Strategy",
      //   ],
      // ),
      // SlideModel(
      //   title: "Why Choose Us?",
      //   subtitle: "Excellence in Every Project",
      //   bulletPoints: [
      //     "24/7 Customer Support",
      //     "Agile Development Methodology",
      //     "Scalable & Secure Solutions",
      //     "Competitive Pricing",
      //     "On-time Delivery Guarantee",
      //   ],
      // ),
    ];
  }
}