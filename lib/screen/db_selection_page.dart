import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trafiqpro/controller/controller.dart';
import 'package:trafiqpro/controller/registration_controller.dart';
import 'package:trafiqpro/screen/home_page.dart';

class DbSelection extends StatefulWidget {
  const DbSelection({super.key});

  @override
  State<DbSelection> createState() => _DbSelectionState();
}

class _DbSelectionState extends State<DbSelection> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    Provider.of<RegistrationController>(context, listen: false)
        .initDb(context, "");

    // Provider.of<RegistrationController>(context, listen: false)
    //     .getDatabasename(context);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Consumer<RegistrationController>(
          builder: (context, value, child) => value.isdbLoading
              ? const SpinKitCircle(
                  color: Colors.black,
                )
              : ListView.builder(
                  itemCount: value.db_list.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString("db_name",
                              value.db_list[index]["Data_Name"].toString());
                          prefs.setString("yr_name",
                              value.db_list[index]["Year_Name"].toString());
                          Provider.of<Controller>(context, listen: false)
                              .initYearsDb(context,
                                  value.db_list[index]["Data_Name"].toString());
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => HomePage()),
                          );
                        },
                        title: Text(value.db_list[index]["Year_Name"]),
                      ),
                    );
                  })),
    );
  }
}
