import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mi_gente/config/app_constants.dart';
import 'package:mi_gente/domain/people_controller.dart';
import 'package:mi_gente/models/pagination.dart';
import 'package:mi_gente/models/people.dart';
import 'package:mi_gente/models/person.dart';
import 'package:mi_gente/ui/locator.dart';
import 'package:mi_gente/ui/views/base_future_widget.dart';
import 'package:mi_gente/utils/strings.dart';

var logger = Logger();

class PeoplePage extends StatefulWidget {
  final String? votes;
  final bool showAll;
  const PeoplePage({super.key, this.votes = 'all', this.showAll = false});

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  final int page = 0;
  final int perPage = 50;

  String? query;
  final TextEditingController _searchController = TextEditingController();

  void onQueryChanged(String? text) async {
    setState(() {
      query = text;
    });
  }

  Future<People> getPeole() {
    if (query == null && widget.votes == null) {
      return Future<People>.value(People(
          pagination: Pagination(count: 0, page: 0, pages: 0, perPage: 0),
          persons: []));
    }
    return locator
        .get<PeopleDomainController>()
        .getPeople(ndi: query, votes: widget.votes);
  }

  Future<void> onOpenQRCodeScan(BuildContext context) async {
    final result = await Navigator.pushNamed(context, RoutePaths.qrCode);

    List<String>? ndiData = (result as String?)?.decompileNdi();
    if (ndiData != null) {
      setState(() {
        query = ndiData.first;
      });
    }
  }

  Widget renderChildren(People? people) {
    List<Person> persons = people!.persons;

    if (persons.isEmpty) {
      return const Center(child: Text('No hay resultados'));
    }

    return ListView.separated(
        itemBuilder: (context, index) {
          final Person person = persons.elementAt(index);

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Text(
                person.initials,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            title: Text('${person.names} ${person.lastNames}'),
            subtitle: Text('${person.ndi} • ${person.dateFormatted}'),
            onTap: () => {
              Navigator.pushNamed(context, RoutePaths.code, arguments: {
                "person": person,
                'route': RoutePaths.updatePerson
              })
            },
            trailing: const Icon(Icons.arrow_forward),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: persons.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverAppBar(
        floating: true,
        pinned: true,
        snap: false,
        centerTitle: false,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text('Búsqueda'),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_2),
            onPressed: () {
              onOpenQRCodeScan(context);
            },
          ),
        ],
        bottom: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Container(
            width: double.infinity,
            height: 44,
            // color: Colors.white,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: TextField(
              controller: _searchController,
              onSubmitted: onQueryChanged,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Escriba la cédula a buscar',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                    onPressed: () {
                      _searchController.clear();
                      onQueryChanged(null);
                    },
                    icon: const Icon(Icons.clear)),
              ),
            ),
          ),
        ),
      ),
      SliverFillRemaining(
          child: BaseFutureWidget<People>(
              renderChildren: renderChildren, future: getPeole()))
    ]));
  }
}
