import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final String subTitle;
  final Widget? child;

  const CardItem(
      {Key? key,
      required this.width,
      required this.height,
      required this.title,
      required this.subTitle,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 18,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FittedBox(
                child: Text(
                  subTitle,
                  style: const TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 40,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (child != null)
                Container(
                  child: child,
                )
            ],
          ),
        ),
      ),
    );
  }
}
