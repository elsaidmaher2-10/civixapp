import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/customtextfromfield.dart';
import 'package:citifix/feature/home/presentation/view/allReportCarditem.dart';
import 'package:citifix/feature/home/presentation/view/allReportFlutterCheap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportsPage extends StatefulWidget {
  ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  List<Map<String, dynamic>> filters = [
    {"title": "All", "selected": true},
    {"title": "In Progress", "selected": false},
    {"title": "Pending", "selected": false},
    {"title": "Resolved", "selected": false},
  ];
  final List<Map<String, dynamic>> reports = [
    {
      "status": "In Progress",
      "statusColor": Colors.amber,
      "title": "Large Pothole Hazard",
      "location": "123 Liberty Ave, Downtown",
      "date": "Oct 12, 2023",
      "ref": "#CF-9821",
      "imageUrl":
          "https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?q=80&w=200&auto=format&fit=crop",
    },
    {
      "status": "Pending",
      "statusColor": Colors.orange,
      "title": "Broken Street Light",
      "location": "45 Main St, City Center",
      "date": "Oct 10, 2023",
      "ref": "#CF-9815",
      "imageUrl":
          "https://images.unsplash.com/photo-1509395176047-4a66953fd231?q=80&w=200&auto=format&fit=crop",
    },

    {
      "status": "Pending",
      "statusColor": Colors.orange,
      "title": "Road Crack",
      "location": "22 Sunset Blvd",
      "date": "Oct 5, 2023",
      "ref": "#CF-9802",
      "imageUrl":
          "https://images.unsplash.com/photo-1503387762-592deb58ef4e?q=80&w=200&auto=format&fit=crop",
    },
    {
      "status": "Resolved",
      "statusColor": Colors.green,
      "title": "Water Leakage",
      "location": "90 Riverside Dr",
      "date": "Oct 2, 2023",
      "ref": "#CF-9795",
      "imageUrl":
          "https://images.unsplash.com/photo-1509395176047-4a66953fd231?q=80&w=200&auto=format&fit=crop",
    },
    {
      "status": "In Progress",
      "statusColor": Colors.amber,
      "title": "Damaged Traffic Sign",
      "location": "11 Central Square",
      "date": "Sep 30, 2023",
      "ref": "#CF-9788",
      "imageUrl":
          "https://images.unsplash.com/photo-1486006920555-c77dcf18193c?q=80&w=200&auto=format&fit=crop",
    },
    {
      "status": "Pending",
      "statusColor": Colors.orange,
      "title": "Blocked Drain",
      "location": "55 Hill Street",
      "date": "Sep 28, 2023",
      "ref": "#CF-9779",
      "imageUrl":
          "https://images.unsplash.com/photo-1558618666-fcd25c85cd64?q=80&w=200&auto=format&fit=crop",
    },
    {
      "status": "Resolved",
      "statusColor": Colors.green,
      "title": "Fallen Tree",
      "location": "Green Park Avenue",
      "date": "Sep 25, 2023",
      "ref": "#CF-9765",
      "imageUrl":
          "https://images.unsplash.com/photo-1501785888041-af3ef285b470?q=80&w=200&auto=format&fit=crop",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F7F8),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xFF003366),
        ),
        title: const Text(
          'Reports',
          style: TextStyle(
            color: Color(0xFF003366),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        scrolledUnderElevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80.h),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtilsManager.w16,
              vertical: ScreenUtilsManager.h8,
            ),
            child: CustomTextfromfield(
              prefix: Icon(Icons.search, color: Colors.black45),
              hinttext:Constantmanger.hsearch,
              lable: Constantmanger.search,
              controller: TextEditingController(),
            ),
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          SizedBox(
            height: 80,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemBuilder: (BuildContext context, int index) => InkWell(
                onTap: () {
                  filters = [
                    {"title": "All", "selected": false},
                    {"title": "In Progress", "selected": false},
                    {"title": "Pending", "selected": false},
                    {"title": "Resolved", "selected": false},
                  ];
                  filters[index]["selected"] = true;
                  setState(() {});
                },
                child: FliterCheap(
                  label: filters[index]["title"],
                  isActive: filters[index]["selected"],
                ),
              ),
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(width: 5),
              itemCount: filters.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: reports.length,
              itemBuilder: (ctx, index) {
                final report = reports[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ReportCard(
                    status: report['status'],
                    statusColor: report['statusColor'],
                    title: report['title'],
                    location: report['location'],
                    date: report['date'],
                    ref: report['ref'],
                    imageUrl: report['imageUrl'],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
