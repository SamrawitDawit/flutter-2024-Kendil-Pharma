// main.dart
import 'package:blocint/Repo/loginrepo.dart';
import 'package:blocint/Repo/orderrepo.dart';
import 'package:blocint/Repo/orderrepo2.dart';
import 'package:blocint/Repo/useracceditrepo.dart';
import 'package:blocint/Repo/useraccrepo.dart';
import 'package:blocint/bloc/Loginbloc/loginbloc.dart';
import 'package:blocint/bloc/listmedbloc/listmedbloc.dart';
import 'package:blocint/bloc/orderbloc/orderbloc.dart';
import 'package:blocint/bloc/orderbloc2/orderbloc2.dart';
import 'package:blocint/bloc/useracceditbloc/useracceditbloc.dart';
import 'package:blocint/dataprovider/loginprovider.dart';
import 'package:blocint/dataprovider/orderprovider.dart';
import 'package:blocint/dataprovider/orderprovider2.dart';
import 'package:blocint/dataprovider/useracceditprovider.dart';
import 'package:blocint/dataprovider/useraccviewprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:blocint/Repo/listofmedrepo.dart';
import 'package:blocint/Repo/medaddrepo.dart';
import 'package:blocint/bloc/signupbloc/sign_bloc.dart';
import 'package:blocint/bloc/addmedbloc/addmedbloc.dart';
import 'package:blocint/dataprovider/list_medicineprovider.dart';
import 'package:blocint/dataprovider/medicinepostprovider.dart';
import 'package:blocint/dataprovider/userprovider.dart';
import 'package:blocint/bloc/useraccountviewbloc/useraccbloc.dart';
import 'presentation/screens/welcome.dart';

void main() {
  final dataProvider = DataProvider(baseUrl: 'http://localhost:3009');
  final listMedicineProvider = ListMedicineProvider('http://localhost:3009');
  final listMedicineRepository = ListMedicineRepository(listMedicineProvider);
  final medicineProvider = MedicineProvider('http://localhost:3009');
  final medicineRepository = MedicineRepository(medicineProvider);

  final userProvider = UserProvider('http://localhost:3009');
  final userRepository = UserRepository(userProvider);

  final orderDataProvider = OrderDataProvider(baseUrl: 'http://localhost:3009');
  final orderRepository = OrderRepository(dataProvider: orderDataProvider);

  final Order2Repository order2Repository = Order2Repository(
    dataProvider: Order2DataProvider(baseUrl: 'http://localhost:3009'),
  );

  final userDataProvider2 = UserDataProvider2(baseUrl: 'http://localhost:3009'); // Add this line
  final userRepository2 = UserRepository2(dataProvider: userDataProvider2); 

   final loginDataProvider = LoginDataProvider(baseUrl: 'http://localhost:3009');
  final loginRepository = LoginRepository(dataProvider: loginDataProvider);
  
  
  runApp(MyApp(
    dataProvider: dataProvider,
    listMedicineRepository: listMedicineRepository,
    medicineRepository: medicineRepository,
    userRepository: userRepository,
    orderRepository: orderRepository,
    order2Repository: order2Repository,
    userRepository2: userRepository2,
    loginRepository: loginRepository,
  ));
}

class MyApp extends StatelessWidget {
  final DataProvider dataProvider;
  final ListMedicineRepository listMedicineRepository;
  final MedicineRepository medicineRepository;
  final UserRepository userRepository;
  final OrderRepository orderRepository;
  final Order2Repository order2Repository;
  final UserRepository2 userRepository2;
  final LoginRepository loginRepository;


  const MyApp({
    required this.dataProvider,
    required this.listMedicineRepository,
    required this.medicineRepository,
    required this.userRepository,
    required this.orderRepository,
    required this.order2Repository,
    required this.userRepository2,
     required this.loginRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DataProvider>(create: (_) => dataProvider),
        Provider<ListMedicineRepository>(create: (_) => listMedicineRepository),
        BlocProvider<SignupBloc>(
          create: (context) => SignupBloc(dataProvider: dataProvider),
        ),
        BlocProvider<AddMedicineBloc>(
          create: (context) => AddMedicineBloc(medicineRepository),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(userRepository: userRepository),
        ),
        BlocProvider<OrderBloc>(
          create: (context) => OrderBloc(orderRepository: orderRepository),
        ),
        BlocProvider<Order2Bloc>(
          create: (context) => Order2Bloc(repository: order2Repository),
        ),
        BlocProvider<ListMedicineBloc>(
          create: (context) => ListMedicineBloc(listMedicineRepository),
        ),
        BlocProvider<UserBloc2>( // Add this block
          create: (context) => UserBloc2(userRepository: userRepository2),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(loginRepository: loginRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Pharmacy App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: WelcomePage(),
      ),
    );
  }
}
