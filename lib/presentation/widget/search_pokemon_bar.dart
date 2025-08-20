import 'package:flutter/material.dart';

class SearchPokemonBar extends StatefulWidget {
  final ValueChanged<String> onChange;
  final TextEditingController searchController;
  
  const SearchPokemonBar({super.key, required this.onChange, required this.searchController});

  @override
  State<SearchPokemonBar> createState() => _SearchPokemonBarState();
}

class _SearchPokemonBarState extends State<SearchPokemonBar> {
  @override
  void initState() {
    super.initState();
    widget.searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        onChanged: widget.onChange,
        decoration: InputDecoration(
          hintText: 'Search Pokémon...',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon: widget.searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    widget.searchController.clear();
                    widget.onChange('');
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
        ),
      ),
    );
  }
}
