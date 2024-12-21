import 'package:flutter/material.dart';
import 'package:ihep/models/paper_data.dart';

class PaperDataTile extends StatelessWidget {
  const PaperDataTile(
    this.paper, {
    required this.onTap,
    this.showCitations = false,
    super.key,
  });

  final PaperData paper;
  final bool showCitations;
  final void Function(PaperData) onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        onTap: () => onTap(paper),
        tileColor: Colors.white30,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.deepPurple),
          borderRadius: BorderRadius.circular(8),
        ),
        title: Text(paper.titles.first),
        subtitle: Text(
          paper.authors.join('; '),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        trailing: showCitations
            ? Chip(label: Text(paper.citations.toString()))
            : null,
      ),
    );
  }
}
