import 'dart:core';

import 'package:flutter/material.dart';
import 'package:injection_molding_machine_application/data/models/node_query_results_model.dart';
import 'package:injection_molding_machine_application/domain/entities/configuration.dart';
import 'package:injection_molding_machine_application/domain/entities/node_query_result.dart';
import 'package:injection_molding_machine_application/domain/entities/preShift.dart';
import 'package:injection_molding_machine_application/presentation/blocs/bloc/machine_management_bloc.dart';
import 'package:injection_molding_machine_application/presentation/blocs/state/machines_management_event.dart';
import 'package:injection_molding_machine_application/presentation/views/check_information_screen.dart';
import 'package:injection_molding_machine_application/presentation/views/models/operating_params_reliability.dart';
import 'package:injection_molding_machine_application/presentation/views/supervision_Screen.dart';
import 'package:injection_molding_machine_application/presentation/widgets/constant.dart';
import 'package:injection_molding_machine_application/presentation/views/models/mold_params_reliability.dart';
import 'package:injection_molding_machine_application/presentation/widgets/global.dart';
import '../widgets/widgets.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MachineDetailsScreen extends StatefulWidget {
  DeviceQueryResult deviceQueryResult;
  MachineDetailsScreen(this.deviceQueryResult);
  @override
  _MachineDetailsScreenState createState() =>
      _MachineDetailsScreenState(deviceQueryResult);
}

class _MachineDetailsScreenState extends State<MachineDetailsScreen> {
  DeviceQueryResult deviceQueryResult;
  _MachineDetailsScreenState(this.deviceQueryResult);
  //final _channel = WebSocketChannel.connect(Uri.parse(Constants.signalRUrl));
  late HubConnection hubConnection;
  List<Product> productList = [];
  List<PreShift> preShiftList = [];
  PreShift preShift = PreShift();
  NodeQueryResultModel nodeQueryResultModel = NodeQueryResultModel(
      eonNodeId: '', connected: false, deviceQueryResults: []);
  Product product = Product();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'TH??NG S??? M??Y ??P',
          ),
          backgroundColor: Constants.mainColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        endDrawer: Drawer(
          backgroundColor: Constants.secondaryColor,
          child: Column(
            children: [
              Container(
                width: SizeConfig.screenWidth * 0.7421,
                height: SizeConfig.screenHeight * 0.4659,
                decoration: const BoxDecoration(
                    color: Constants.mainColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35.0),
                        bottomRight: Radius.circular(35.0))),
                child: Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.0664,
                    ),
                    Icon(
                      Icons.account_circle_rounded,
                      size: SizeConfig.screenHeight * 0.2659,
                      color: Colors.white,
                    ),
                    const Text(
                      'Ng?????i Ki???m Tra: nhi0201',
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth * 0.0468,
                        top: SizeConfig.screenHeight * 0.0797),
                    child: Row(
                      children: [
                        Icon(
                          Icons.settings_outlined,
                          size: SizeConfig.screenHeight * 0.0398,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.0156,
                        ),
                        const Text(
                          'C??i ?????t',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.0398,
                  ),
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.0468),
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            size: SizeConfig.screenHeight * 0.0398,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: SizeConfig.screenWidth * 0.0156,
                          ),
                          const Text(
                            '????ng Xu???t',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.popAndPushNamed(context, '/');
                    },
                  )
                ],
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: BlocConsumer<MachinesManagementBloc, MachineManagementState>(
            listener: (context, MachineManagementState state) {
              if (state is MachineManagementStateLoaded) {
                productList = state.productList;
                preShiftList = state.preShiftList;
                print('productList: $productList');
                for (int i = 0; i < preShiftList.length; i++) {
                  if (preShiftList[i].product!.id ==
                      deviceQueryResult.deviceId) {
                    preShift = preShiftList[i];
                  }
                }
                // for(int i = 0; i < machineList.length; i++){
                //   if()
                // }
                print('information: $product');
              }
            },
            builder: (context, MachineDetailsState) {
              bool warning = false;
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: SizeConfig.screenHeight * 0.0256),
                      const Text(
                        'TH??NG S??? V???N H??NH',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.0128),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              right: 5,
                            ),
                            child: CustomizedButton(
                                text: "T???m D???ng",
                                fontSize: 20,
                                width: SizeConfig.screenWidth * 0.3121,
                                height: SizeConfig.screenHeight * 0.07121,
                                onPressed: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CheckInfomationView()));
                                  bool disconnectMachine = bool.fromEnvironment(
                                          deviceQueryResult.connected
                                              .toString()) ==
                                      false;
                                  hubConnection = HubConnectionBuilder()
                                      .withUrl(Constants.signalRUrl)
                                      .withAutomaticReconnect()
                                      .build();
                                  // hubConnection.keepAliveIntervalInMilliseconds = 15000;
                                  hubConnection.serverTimeoutInMilliseconds =
                                      100000;
                                  hubConnection.onclose(
                                      (error) => print("Connection Closed"));
                                  await hubConnection.start();
                                  if (hubConnection.state ==
                                      HubConnectionState.connected) {
                                    hubConnection.invoke('methodName',
                                        args: <String>[
                                          'T???m D???ng m??y ${deviceQueryResult.deviceId}'
                                        ]);
                                  }
                                }),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              left: 5,
                            ),
                            child: CustomizedButton(
                                text: "Ti???p T???c",
                                fontSize: 20,
                                width: SizeConfig.screenWidth * 0.3121,
                                height: SizeConfig.screenHeight * 0.07121,
                                onPressed: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CheckInfomationView()));
                                  bool connectMachine = bool.fromEnvironment(
                                          deviceQueryResult.connected
                                              .toString()) ==
                                      true;
                                  hubConnection = HubConnectionBuilder()
                                      .withUrl(Constants.signalRUrl)
                                      .withAutomaticReconnect()
                                      .build();
                                  // hubConnection.keepAliveIntervalInMilliseconds = 15000;
                                  hubConnection.serverTimeoutInMilliseconds =
                                      100000;
                                  hubConnection.onclose(
                                      (error) => print("Connection Closed"));
                                  await hubConnection.start();
                                  if (hubConnection.state ==
                                      HubConnectionState.connected) {
                                    hubConnection.invoke('methodName',
                                        args: <String>[
                                          'Ti??p t???c m??y ${deviceQueryResult.deviceId}'
                                        ]);
                                  }
                                }),
                          )
                        ],
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.0128),
                      Container(
                        decoration: BoxDecoration(border: Border.all()),
                        width: SizeConfig.screenWidth * 0.8992,
                        height: SizeConfig.screenHeight * 0.1561,
                        child: MonitorOperatingParamsReli(
                          text1: "M?? s???n ph???m",
                          text2: "S??? l?????ng k??? ho???ch",
                          text3: "S??? l?????ng th???c t???",
                          data1: 'BX-02', //preShift.product!.id.toString(),
                          data2: '1200', //preShift.totalQuantity.toString(),
                          data3:
                              '1100', //deviceQueryResult.tagQueryResults[2].value.toString(),
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.0256),
                      const Text(
                        'TH??NG S??? KHU??N',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.0128),
                      Container(
                        decoration: BoxDecoration(border: Border.all()),
                        width: SizeConfig.screenWidth * 0.8992,
                        height: SizeConfig.screenHeight * 0.2461,
                        child: MoldParamsReli(
                          text4: "M?? s??? khu??n",
                          text5: "Chu k??? ??p",
                          text6: "Th???i gian m??? c???a",
                          text7: "Ch??? ????? v???n h??nh",
                          text8: "S??? s???n ph???m/l???n ??p",
                          data4: 'NX-36', //product.mold!.id.toString(),
                          data5: deviceQueryResult.tagQueryResults[0].value
                              .toString(),
                          data6: deviceQueryResult.tagQueryResults[1].value
                              .toString(),
                          data7: deviceQueryResult.tagQueryResults[4].value
                              .toString(),
                          data8: deviceQueryResult.tagQueryResults[2].value
                              .toString(),
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.0256),
                      const Text(
                        'B???NG GI??M S??T',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.0356),
                      Container(
                        decoration: BoxDecoration(border: Border.all()),
                        width: SizeConfig.screenWidth * 0.8992,
                        height: SizeConfig.screenHeight * 0.1996,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: SizeConfig.screenHeight * 0.1230,
                                  height: SizeConfig.screenHeight * 0.1230,
                                  decoration: BoxDecoration(
                                    color: (deviceQueryResult
                                                    .tagQueryResults[4].value ==
                                                1 ||
                                            deviceQueryResult
                                                    .tagQueryResults[4].value ==
                                                2 ||
                                            deviceQueryResult
                                                    .tagQueryResults[4].value ==
                                                3)
                                        ? Colors.green
                                        : Colors.black26,
                                    border: Border.all(),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const Text(
                                  "??ANG CH???Y",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: SizeConfig.screenHeight * 0.1230,
                                  height: SizeConfig.screenHeight * 0.1230,
                                  decoration: BoxDecoration(
                                    color:
                                        warning ? Colors.yellow : Colors.white,
                                    border: Border.all(),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const Text(
                                  "C???NH B??O",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        width: 250,
                        height: 60,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Constants.mainColor)),
                            onPressed: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=> SupervisionScreen(deviceQueryResult.deviceId)));
                              Navigator.pushNamed(context, '/supervisionView');
                              Global.machineId = deviceQueryResult.deviceId;
                            },
                            child: const Text(
                              'GI??M S??T',
                              style: TextStyle(fontSize: 30),
                            )),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
