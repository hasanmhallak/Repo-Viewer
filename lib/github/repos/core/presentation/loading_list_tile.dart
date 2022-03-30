import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingListTile extends StatelessWidget {
  const LoadingListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade300,
      child: ListTile(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Colors.grey,
            ),
            height: 14,
            width: 120,
          ),
        ),
        subtitle: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Colors.grey,
            ),
            height: 14,
            width: 250,
          ),
        ),
        leading: const CircleAvatar(
          backgroundColor: Colors.grey,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.star_outline,
              color: Colors.grey,
            ),
            Text(
              '',
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}
