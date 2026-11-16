import 'package:flutter/material.dart';
import '../models/ingredient.dart';
import '../models/recipe.dart';
import '../l10n/app_localizations.dart';
import '../widgets/unified_add_side_dialog.dart';
import '../utils/sorting_utils.dart';
import 'servings_stepper.dart';

/// Dialog for selecting recipes for meal planning slots.
///
/// Provides two modes:
/// - Selection mode: Browse all recipes
/// - Menu mode: Manage selected recipe and side dishes
class RecipeSelectionDialog extends StatefulWidget {
  final List<Recipe> recipes;
  final Recipe? initialPrimaryRecipe;
  final List<Recipe>? initialAdditionalRecipes;
  final int? initialPlannedServings;
  final List<Ingredient> availableIngredients;
  final List<Map<String, dynamic>> initialSimpleSides;
  final bool isEditMode;
  final bool initialMealCooked;

  const RecipeSelectionDialog({
    super.key,
    required this.recipes,
    this.initialPrimaryRecipe,
    this.initialAdditionalRecipes,
    this.initialPlannedServings,
    this.availableIngredients = const [],
    this.initialSimpleSides = const [],
    this.isEditMode = false,
    this.initialMealCooked = false,
  });

  @override
  RecipeSelectionDialogState createState() => RecipeSelectionDialogState();
}

class RecipeSelectionDialogState extends State<RecipeSelectionDialog> {
  String _searchQuery = '';
  Recipe? _selectedRecipe;
  bool _showingMenu = false;
  List<Recipe> _additionalRecipes = [];
  int _plannedServings = 4;
  List<Map<String, dynamic>> _simpleSides = [];

  @override
  void initState() {
    super.initState();

    if (widget.initialPrimaryRecipe != null) {
      _selectedRecipe = widget.initialPrimaryRecipe;
      _additionalRecipes = List.from(widget.initialAdditionalRecipes ?? []);
      _showingMenu = true;
      _plannedServings = widget.initialPlannedServings ??
          widget.initialPrimaryRecipe!.servings;
    }

    _simpleSides = List.from(widget.initialSimpleSides);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _showingMenu
                  ? AppLocalizations.of(context)!.mealOptions
                  : AppLocalizations.of(context)!.selectRecipe,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _showingMenu ? _buildMenu() : _buildRecipeSelection(),
            ),
            TextButton(
              key: const Key('recipe_selection_cancel_button'),
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeSelection() {
    final filtered = widget.recipes
        .where((recipe) =>
            recipe.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
    final filteredRecipes = SortingUtils.sortByName(filtered, (r) => r.name);

    return Column(
      children: [
        // Search field
        TextField(
          key: const Key('recipe_selection_all_tab'),
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.searchRecipesHint,
            prefixIcon: const Icon(Icons.search),
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value.trim();
            });
          },
        ),
        const SizedBox(height: 16),

        Expanded(
          child: ListView.builder(
            itemCount: filteredRecipes.length,
            itemBuilder: (context, index) {
              final recipe = filteredRecipes[index];
              return _buildRecipeListTile(recipe);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMenu() {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Primary recipe header
          if (widget.isEditMode)
            Material(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => Navigator.pop(context, {'action': 'view'}),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Icon(Icons.restaurant),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _selectedRecipe!.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.info_outline, size: 20),
                        tooltip: l10n.viewRecipeDetails,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () =>
                            Navigator.pop(context, {'action': 'view'}),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.restaurant),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _selectedRecipe!.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 12),

          // Acompanhamentos section — visible upfront, not buried in list
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.completeMealSection,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),

                // Existing recipe side dishes
                if (_additionalRecipes.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  ..._additionalRecipes.map((recipe) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            const Icon(Icons.restaurant_menu,
                                size: 16, color: Colors.grey),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(recipe.name,
                                  style: Theme.of(context).textTheme.bodySmall),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, size: 18),
                              tooltip: '${l10n.remove} ${recipe.name}',
                              visualDensity: VisualDensity.compact,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () => setState(
                                  () => _additionalRecipes.remove(recipe)),
                            ),
                          ],
                        ),
                      )),
                ],

                // Existing simple sides
                if (_simpleSides.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  ..._simpleSides.map((side) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            const Icon(Icons.eco_outlined,
                                size: 16, color: Colors.grey),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(_resolveSideName(side),
                                  style: Theme.of(context).textTheme.bodySmall),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, size: 18),
                              tooltip:
                                  '${l10n.remove} ${_resolveSideName(side)}',
                              visualDensity: VisualDensity.compact,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () =>
                                  setState(() => _simpleSides.remove(side)),
                            ),
                          ],
                        ),
                      )),
                ],

                const SizedBox(height: 8),

                // Single button — opens unified add dialog for both recipe and ingredient sides
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    key: const Key('recipe_selection_add_side_dish_button'),
                    icon: const Icon(Icons.add, size: 18),
                    label: Text(l10n.addSideDish),
                    onPressed: _showUnifiedAddSideDialog,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Servings stepper
          ServingsStepper(
            key: const Key('recipe_selection_planned_servings_stepper'),
            value: _plannedServings,
            onChanged: (v) => setState(() => _plannedServings = v),
          ),
          const SizedBox(height: 12),

          // Save — primary action, full-width ElevatedButton
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              key: const Key('recipe_selection_save_button'),
              icon: const Icon(Icons.save),
              label: Text(widget.isEditMode ? l10n.saveChanges : l10n.saveMeal),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () => Navigator.pop(
                  context,
                  widget.isEditMode
                      ? {
                          'action': 'save',
                          'primaryRecipe': _selectedRecipe!,
                          'additionalRecipes': _additionalRecipes,
                          'plannedServings': _plannedServings,
                          'simpleSides': _simpleSides,
                        }
                      : {
                          'primaryRecipe': _selectedRecipe!,
                          'additionalRecipes': _additionalRecipes,
                          'plannedServings': _plannedServings,
                          'simpleSides': _simpleSides,
                        }),
            ),
          ),

          if (widget.isEditMode) ...[
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OutlinedButton.icon(
                  icon: Icon(
                    widget.initialMealCooked
                        ? Icons.edit_outlined
                        : Icons.check_circle_outline,
                  ),
                  label: Text(
                    widget.initialMealCooked
                        ? l10n.editCookedMeal
                        : l10n.markAsCooked,
                  ),
                  onPressed: () => Navigator.pop(context, {
                    'action':
                        widget.initialMealCooked ? 'edit_cooked' : 'cooked',
                  }),
                ),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  icon: const Icon(Icons.swap_horiz),
                  label: Text(l10n.changeRecipe),
                  onPressed: () => Navigator.pop(context, {'action': 'change'}),
                ),
              ],
            ),
            const Divider(height: 20),
            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                icon: const Icon(Icons.delete_outline),
                label: Text(l10n.removeFromPlan),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
                onPressed: _handleRemoveTap,
              ),
            ),
          ],

          if (!widget.isEditMode) ...[
            const SizedBox(height: 4),
            TextButton.icon(
              icon: const Icon(Icons.arrow_back, size: 16),
              label: Text(l10n.back),
              onPressed: () {
                if (widget.initialPrimaryRecipe != null) {
                  Navigator.pop(context);
                } else {
                  setState(() {
                    _showingMenu = false;
                    _selectedRecipe = null;
                  });
                }
              },
            ),
          ],
        ],
      ),
    );
  }

  // Helper method to build consistent recipe list tiles
  Widget _buildRecipeListTile(Recipe recipe) {
    return ListTile(
      key: Key('recipe_card_${recipe.id}'),
      leading: const Icon(Icons.restaurant_menu),
      title: Text(recipe.name),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _handleRecipeSelection(recipe),
    );
  }

  Future<void> _showUnifiedAddSideDialog() async {
    if (!mounted) return;
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => UnifiedAddSideDialog(
        availableRecipes: widget.recipes,
        excludeRecipes: [_selectedRecipe!],
        availableIngredients: widget.availableIngredients,
      ),
    );
    if (result == null || !mounted) return;
    final type = result['type'] as String?;
    if (type == 'recipe') {
      final recipe = result['recipe'] as Recipe;
      if (!_additionalRecipes.any((r) => r.id == recipe.id)) {
        setState(() => _additionalRecipes.add(recipe));
      }
    } else if (type == 'simple') {
      setState(() => _simpleSides.add(result));
    }
  }

  String _resolveSideName(Map<String, dynamic> side) {
    final ingredientId = side['ingredientId'] as String?;
    if (ingredientId != null) {
      final ingredient = widget.availableIngredients
          .where((i) => i.id == ingredientId)
          .firstOrNull;
      return ingredient?.name ?? side['customName'] as String? ?? '?';
    }
    return side['customName'] as String? ?? '?';
  }

  void _handleRemoveTap() async {
    if (widget.initialMealCooked) {
      final l10n = AppLocalizations.of(context)!;
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(l10n.removeFromPlan),
          content: Text(l10n.removeCookedMealWarning),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(l10n.cancel),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(ctx).colorScheme.error,
              ),
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(l10n.remove),
            ),
          ],
        ),
      );
      if (confirmed == true && mounted) {
        Navigator.pop(context, {'action': 'remove'});
      }
    } else {
      Navigator.pop(context, {'action': 'remove'});
    }
  }

  void _handleRecipeSelection(Recipe recipe) {
    setState(() {
      _selectedRecipe = recipe;
      _showingMenu = true;
      _plannedServings = recipe.servings;
    });
  }
}
