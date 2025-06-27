import 'package:shimmer/shimmer.dart';
import 'package:shoppe/core/package/package_export.dart';
import 'package:shoppe/core/package/utils.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  Widget shimmerBox({double width = double.infinity, double height = 16}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,

        decoration: BoxDecoration(
          borderRadius: radius(20),
          color: Colors.white,
        ),
      ),
    );
  }

  Widget shimmerRow({double iconSize = 24, double textWidth = 200}) {
    return Row(
      children: [
        shimmerBox(width: iconSize, height: iconSize),
        sizeW10(),
        shimmerBox(width: textWidth, height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CP(
        h: 16,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: shimmerBox(width: 50, height: 20),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: const CircleAvatar(
                radius: 65,
                backgroundColor: Colors.grey,
              ),
            ),
            sizeH25(),
            shimmerBox(width: 150, height: 20),
            sizeH15(),
            const Divider(),
            sizeH15(),
            shimmerRow(),
            sizeH15(),
            shimmerRow(),
            sizeH15(),
            const Divider(),
            sizeH10(),
            shimmerRow(),
            sizeH10(),
            const Divider(),
            sizeH10(),
            shimmerRow(),
          ],
        ),
      ),
    );
  }
}
