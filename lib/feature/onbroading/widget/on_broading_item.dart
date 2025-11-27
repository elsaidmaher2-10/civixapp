import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/onbroadingprovider.dart';
import '../model/onbroadingmodel.dart';
import '../widget/indicator.dart';

class customonbroadingitem extends StatelessWidget {
  const customonbroadingitem({
    super.key,
    required this.x,
    required this.value,
    required this.pages,
    required this.controller,
  });

  final int value;
  final int x;
  final List<Onbroadingmodel> pages;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              !context.read<Onbroadingprovider>().isLastPage
                  ? TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Color(0xff2A4D8B),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      onPressed: () {
                        controller.jumpToPage(pages.length - 1);
                      },
                      child: const Text(
                        "Skip",
                        style: TextStyle(
                          color: Color(0xff2A4D8B),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : const SizedBox(height: 15),
            ],
          ),

          const SizedBox(height: 9),

          Image.asset(
            pages[x].image,
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height * 0.45,
          ),

          const SizedBox(height: 16),

          Text(
            pages[x].title,
            style: const TextStyle(
              fontSize: 32,
              color: Color(0xff003366),
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 9),

          Text(
            pages[x].subtitle,
            style: const TextStyle(
              fontSize: 20,
              color: Color(0xff003366),
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(height: 18),

          customindicator(controller: controller),

          const SizedBox(height: 42),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                fixedSize: const Size(double.infinity, 70),
                foregroundColor: const Color(0xffFFFFFF),
                backgroundColor: const Color(0xff2A4D8B),
              ),
              onPressed: () {
                final provider = context.read<Onbroadingprovider>();

                if (!provider.isLastPage) {
                  controller.nextPage(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.fastOutSlowIn,
                  );
                } else {}
              },
              child: Text(
                context.watch<Onbroadingprovider>().isLastPage
                    ? "Finish"
                    : "Next",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
