import 'package:flutter/material.dart';
import 'package:injection_molding_machine_application/domain/entities/node_query_result.dart';
import 'package:injection_molding_machine_application/presentation/widgets/constant.dart';
import '../widgets/widgets.dart';
import 'package:injection_molding_machine_application/presentation/widgets/main_app_name.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NodeQueryResult nodeQueryResult =
      NodeQueryResult(connected: false, deviceQueryResults: [], eonNodeId: '');
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "QUẢN LÝ MÁY ÉP",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Constants.mainColor,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(height: SizeConfig.screenHeight * 0.1456),
            MainAppName(text: "KHU MÁY ÉP",),
            SizedBox(
              height: SizeConfig.screenHeight * 0.0702,
            ),
            CustomizedButton(
              text: "ĐĂNG NHẬP",
              fontSize: 20,
              width: SizeConfig.screenWidth * 0.3521,
              padding: 80,
              height: SizeConfig.screenHeight * 0.07121,
              onPressed: () {
                Navigator.pushNamed(context, 'loginView');
              },
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.0028),
          ],
        ),
      ),
    );
  }
}
