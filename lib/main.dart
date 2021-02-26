import 'package:country_picker_example/model/country.dart';
import 'package:country_picker_example/page/country_page.dart';
import 'package:country_picker_example/provider/country_provider.dart';
import 'package:country_picker_example/widget/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Select Countries';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => CountryProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primaryColor: Colors.blueAccent,
          ),
          home: MainPage(),
        ),
      );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Country country;
  List<Country> countries = [];

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSingleCountry(),
              const SizedBox(height: 24),
              buildMultipleCountry(),
            ],
          ),
        ),
      );

  Widget buildSingleCountry() {
    final onTap = () async {
      final country = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CountryPage()),
      );

      if (country == null) return;

      setState(() => this.country = country);
    };

    return buildCountryPicker(
      title: 'Select Country',
      child: country == null
          ? buildListTile(title: 'No Country', onTap: onTap)
          : buildListTile(
              title: country.name,
              leading: FlagWidget(code: country.code),
              onTap: onTap,
            ),
    );
  }

  Widget buildMultipleCountry() {
    final countriesText = countries.map((country) => country.name).join(', ');
    final onTap = () async {
      final countries = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CountryPage(
                  isMultiSelection: true,
                  countries: List.of(this.countries),
                )),
      );

      if (countries == null) return;

      setState(() => this.countries = countries);
    };

    return buildCountryPicker(
      title: 'Select Countries',
      child: countries.isEmpty
          ? buildListTile(title: 'No Countries', onTap: onTap)
          : buildListTile(title: countriesText, onTap: onTap),
    );
  }

  Widget buildListTile({
    @required String title,
    @required VoidCallback onTap,
    Widget leading,
  }) {
    return ListTile(
      onTap: onTap,
      leading: leading,
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
      trailing: Icon(Icons.arrow_drop_down, color: Colors.black),
    );
  }

  Widget buildCountryPicker({
    @required String title,
    @required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Card(margin: EdgeInsets.zero, child: child),
        ],
      );
}
