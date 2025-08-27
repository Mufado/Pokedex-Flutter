import 'package:flutter/material.dart';
import 'package:pokedex_app/presentation/widget/search_pokemon_filters.dart';

class SearchPokemonBar extends StatefulWidget {
  final void Function() onChange;
  final TextEditingController searchController;

  const SearchPokemonBar({
    super.key,
    required this.onChange,
    required this.searchController,
  });

  @override
  State<SearchPokemonBar> createState() => _SearchPokemonBarState();
}

class _SearchPokemonBarState extends State<SearchPokemonBar> {
  bool _showFilters = false;

  @override
  void initState() {
    super.initState();
    widget.searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: widget.searchController,
            onChanged: (_) => widget.onChange(),
            decoration: InputDecoration(
              hintText: 'Search Pokémon...',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.searchController.text.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.clear, color: Colors.grey),
                      onPressed: () {
                        widget.searchController.clear();
                        widget.onChange();
                      },
                    ),
                  Text('|', style: TextStyle(color: Colors.grey)),
                  IconButton(
                    icon: Icon(
                      _showFilters ? Icons.expand_less : Icons.expand_more,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _showFilters = !_showFilters;
                      });
                    },
                  ),
                ],
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: _showFilters
              ? SearchPokemonFilters(onChange: widget.onChange)
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
