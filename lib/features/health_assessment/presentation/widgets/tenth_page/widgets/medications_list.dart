import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/tenth_page/widgets/selected_row.dart';

class MedicationsList extends StatefulWidget {
  const MedicationsList({
    super.key,
    required this.scrollController,
    required this.alphabetWords,
    required this.theme,
  });
  final ScrollController scrollController;
  final List<String> alphabetWords;
  final ThemeData theme;

  @override
  State<MedicationsList> createState() => _MedicationsListState();
}

class _MedicationsListState extends State<MedicationsList> {
  final List<bool> selected = List.generate(5 * 26, (index) => false);
  onTap(int index) {
    setState(() {
      selected[index] = !selected[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 320,
          child: ListView.builder(
            controller: widget.scrollController,
            itemCount: widget.alphabetWords.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color:
                    selected[index]
                        ? widget.theme.colorScheme.secondary
                        : widget.theme.colorScheme.primaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    SizesManager.circularBorderRadius,
                  ),
                  side: BorderSide(
                    color:
                        selected[index]
                            ? widget.theme.colorScheme.secondary.withAlpha(120)
                            : widget.theme.colorScheme.primaryContainer,
                    width: selected[index] ? 3 : 0,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                ),
                child: RadioListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      SizesManager.circularBorderRadius,
                    ),
                  ),
                  activeColor: Colors.white,
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      widget.alphabetWords[index],
                      style: widget.theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color:
                            selected[index]
                                ? Colors.white
                                : widget.theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  value: true,
                  groupValue: selected[index],
                  toggleable: true,
                  onChanged:
                      (_) => setState(() {
                        selected[index] = !selected[index];
                      }),
                ),
              );
            },
          ),
        ),
        if (selected.contains(true))
          SelectedRow(
            theme: widget.theme,
            alphabetWords: widget.alphabetWords,
            selected: selected,
            onTap: onTap,
          ),
      ],
    );
  }
}
