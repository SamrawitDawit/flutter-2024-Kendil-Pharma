import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/listmedbloc/listmedbloc.dart';
import '../../bloc/listmedbloc/listmedevent.dart';
import '../../bloc/listmedbloc/listmedstate.dart';
import 'editmed.dart';
import 'addmed.dart';
import 'medicine_view.dart';

class ListOFMedicine extends StatefulWidget {
  final bool isPharmacist;
  final String token;

  ListOFMedicine({Key? key, required this.isPharmacist, required this.token}) : super(key: key);

  @override
  _ListOFMedicineState createState() => _ListOFMedicineState();
}

class _ListOFMedicineState extends State<ListOFMedicine> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ListMedicineBloc>().add(FetchMedicines(widget.token));
    RouteObserver().subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    RouteObserver().unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    context.read<ListMedicineBloc>().add(FetchMedicines(widget.token));
  }

  void _refreshMedicines(BuildContext context) {
    context.read<ListMedicineBloc>().add(FetchMedicines(widget.token));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListMedicineBloc, ListMedicineState>(
      builder: (context, state) {
        if (state is MedicineLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is MedicineError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is MedicineLoaded) {
          final medicines = state.medicines;
          if (medicines.isEmpty) {
            return Center(child: Text('No medicines found.'));
          }
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Products', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                    if (widget.isPharmacist)
                      GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddMedicineScreen()),
                          );
                          if (result == true) {
                            _refreshMedicines(context);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.lightGreen, width: 2),
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.lightGreen,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: medicines.length,
                itemBuilder: (context, index) {
                  final item = medicines[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MedicineViewPage(
                            medicineItem: item,
                            isPharmacist: widget.isPharmacist,
                            onUpdate: (updatedItem) {
                              _refreshMedicines(context);
                            },
                            token: widget.token,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      child: Card(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                        child: Text(item.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.lightGreen)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(15, 0, 4, 0),
                                        child: Text(
                                          item.description,
                                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(15, 0, 3, 0),
                                    child: Text(item.price, style: TextStyle(color: Colors.green[900])),
                                  ),
                                ],
                              ),
                            ),
                            if (widget.isPharmacist)
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit, color: Colors.blue),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditMedicineScreen(
                                            medicineItem: item,
                                            onUpdate: (updatedItem) {
                                              _refreshMedicines(context);
                                            },
                                            token: widget.token,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      context.read<ListMedicineBloc>().add(DeleteMedicine(item.medid, widget.token));
                                    },
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
