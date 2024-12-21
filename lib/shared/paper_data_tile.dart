import 'package:flutter/material.dart';
import 'package:ihep/models/paper_data.dart';
import 'package:ihep/router.dart';

class PaperDataTile extends StatelessWidget {
  const PaperDataTile(
    this.paper, {
    this.showCitations = false,
    super.key,
  });

  final PaperData paper;
  final bool showCitations;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        onTap: () => context.goPaper(paper.id),
        tileColor: Colors.grey[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
