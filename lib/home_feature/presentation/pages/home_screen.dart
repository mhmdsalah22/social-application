import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_application/home_feature/presentation/widgets/build_post_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 10,
                margin: const EdgeInsets.all(8),
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    const Image(
                      image: NetworkImage(
                        'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg',
                      ),
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Communication with friends',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => BuildPostItem(
                  snap: snapshot.data!.docs[index].data(),
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 8.0,
                ),
                itemCount: snapshot.data!.docs.length,
              ),
              const SizedBox(
                height: 8.0,
              ),
            ],
          ),
        );
      },
    );
  }
}
