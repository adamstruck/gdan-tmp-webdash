# Reformat crete group files as of 4/5/20


1. Fix feature set matrices format `wrapper_ftset.sh`

2. Fix prediction matrices format `wrapper_preds.sh`

3. Move these into `../data/feature-sets/` and `../data/predictions`

# Best so far

```
fix attempt 2 >fix attempt3
```

# Notes on different fixes

**Fix attempt 3**
```
################
# OUTPUT MESSAGE:
#  Warning: Factor `model_occurence` contains implicit NA, consider using `forcats::fct_explicit_na
#  Warning: Factor `actual_value` contains implicit NA, consider using `forcats::fct_explicit_na`
# shiny    | Warning: Removed 1 rows containing non-finite values (stat_boxplot).
# shiny    | Warning: Error in fix.by: 'by' must specify uniquely valid columns
# shiny    |   114: stop
# shiny    |   113: fix.by
# shiny    |   112: merge.data.frame
# shiny    |   108: to_basic.GeomBoxplot
# shiny    |   106: layers2traces
# shiny    |   105: gg2list
# shiny    |   104: ggplotly.ggplot
# shiny    |    99: renderPlotly [/srv/shiny-server/GDAN-TMP/server.R#234]
# shiny    |    98: func
# shiny    |    95: func
# shiny    |    82: origRenderFunc
# shiny    |    81: output$performanceBox
# shiny    |     1: shiny::runApp
################
```
