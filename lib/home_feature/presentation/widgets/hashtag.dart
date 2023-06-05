import 'package:flutter/material.dart';
import 'package:social_application/core/utiles/contants.dart';

class HashtagInPost extends StatelessWidget {
  const HashtagInPost({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10.0,
        top: 5.0,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          children: [
            Padding(
              padding:
              const EdgeInsetsDirectional.only(
                end: 6.0,
              ),
              child: SizedBox(
                height: 25.0,
                child: MaterialButton(
                  onPressed: () {},
                  minWidth: 1.0,
                  padding: EdgeInsets.zero,
                  child: Text(
                    '#software',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(
                      color: defaultColor,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
              const EdgeInsetsDirectional.only(
                end: 6.0,
              ),
              child: SizedBox(
                height: 25.0,
                child: MaterialButton(
                  onPressed: () {},
                  minWidth: 1.0,
                  padding: EdgeInsets.zero,
                  child: Text(
                    '#flutter',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(
                      color: defaultColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}