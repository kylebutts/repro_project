# Main analysis script


This is an example script that will be run by `render_file` and logged
in the logbook.

> [!NOTE]
>
> Note that there are five types of callouts, including: `note`,
> `warning`, `important`, `tip`, and `caution`.

``` r
library(tidyverse, warn.conflicts = FALSE)
library(fixest)
library(tinytable)
```

``` r
1 + 1
mean(rnorm(1000))
```

    [1] 2
    [1] 0.05055768

## Plots

``` r
plot(mtcars$mpg, mtcars$hp)
```

<img src="index_files/figure-html/unnamed-chunk-2-1.png" width="672" />

## Tables

``` r
tinytable::tt(
  mtcars[1:5, ], 
  caption = "First five rows of `mtcars`"
)
```

<!DOCTYPE html> 
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>tinytable_p86rqmxooqi68ha1gpkn</title>
    <style>
.table td.tinytable_css_1300edpbpfziwn9pz3wl, .table th.tinytable_css_1300edpbpfziwn9pz3wl {    border-bottom: solid 0.1em #d3d8dc; }
    </style>
    <script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
    <script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
    <script>
    MathJax = {
      tex: {
        inlineMath: [['$', '$'], ['\\(', '\\)']]
      },
      svg: {
        fontCache: 'global'
      }
    };
    </script>
  </head>
&#10;  <body>
    <div class="container">
      <table class="table table-borderless" id="tinytable_p86rqmxooqi68ha1gpkn" style="width: auto; margin-left: auto; margin-right: auto;" data-quarto-disable-processing='true'>
        <thead>
        <caption>First five rows of `mtcars`</caption>
              <tr>
                <th scope="col">mpg</th>
                <th scope="col">cyl</th>
                <th scope="col">disp</th>
                <th scope="col">hp</th>
                <th scope="col">drat</th>
                <th scope="col">wt</th>
                <th scope="col">qsec</th>
                <th scope="col">vs</th>
                <th scope="col">am</th>
                <th scope="col">gear</th>
                <th scope="col">carb</th>
              </tr>
        </thead>
        &#10;        <tbody>
                <tr>
                  <td>21.0</td>
                  <td>6</td>
                  <td>160</td>
                  <td>110</td>
                  <td>3.90</td>
                  <td>2.620</td>
                  <td>16.46</td>
                  <td>0</td>
                  <td>1</td>
                  <td>4</td>
                  <td>4</td>
                </tr>
                <tr>
                  <td>21.0</td>
                  <td>6</td>
                  <td>160</td>
                  <td>110</td>
                  <td>3.90</td>
                  <td>2.875</td>
                  <td>17.02</td>
                  <td>0</td>
                  <td>1</td>
                  <td>4</td>
                  <td>4</td>
                </tr>
                <tr>
                  <td>22.8</td>
                  <td>4</td>
                  <td>108</td>
                  <td> 93</td>
                  <td>3.85</td>
                  <td>2.320</td>
                  <td>18.61</td>
                  <td>1</td>
                  <td>1</td>
                  <td>4</td>
                  <td>1</td>
                </tr>
                <tr>
                  <td>21.4</td>
                  <td>6</td>
                  <td>258</td>
                  <td>110</td>
                  <td>3.08</td>
                  <td>3.215</td>
                  <td>19.44</td>
                  <td>1</td>
                  <td>0</td>
                  <td>3</td>
                  <td>1</td>
                </tr>
                <tr>
                  <td>18.7</td>
                  <td>8</td>
                  <td>360</td>
                  <td>175</td>
                  <td>3.15</td>
                  <td>3.440</td>
                  <td>17.02</td>
                  <td>0</td>
                  <td>0</td>
                  <td>3</td>
                  <td>2</td>
                </tr>
        </tbody>
      </table>
    </div>
&#10;    <script>
      function styleCell_tinytable_vjqwkvv2oslcd1txwfyx(i, j, css_id) {
        var table = document.getElementById("tinytable_p86rqmxooqi68ha1gpkn");
        table.rows[i].cells[j].classList.add(css_id);
      }
      function insertSpanRow(i, colspan, content) {
        var table = document.getElementById('tinytable_p86rqmxooqi68ha1gpkn');
        var newRow = table.insertRow(i);
        var newCell = newRow.insertCell(0);
        newCell.setAttribute("colspan", colspan);
        // newCell.innerText = content;
        // this may be unsafe, but innerText does not interpret <br>
        newCell.innerHTML = content;
      }
      function spanCell_tinytable_vjqwkvv2oslcd1txwfyx(i, j, rowspan, colspan) {
        var table = document.getElementById("tinytable_p86rqmxooqi68ha1gpkn");
        const targetRow = table.rows[i];
        const targetCell = targetRow.cells[j];
        for (let r = 0; r < rowspan; r++) {
          // Only start deleting cells to the right for the first row (r == 0)
          if (r === 0) {
            // Delete cells to the right of the target cell in the first row
            for (let c = colspan - 1; c > 0; c--) {
              if (table.rows[i + r].cells[j + c]) {
                table.rows[i + r].deleteCell(j + c);
              }
            }
          }
          // For rows below the first, delete starting from the target column
          if (r > 0) {
            for (let c = colspan - 1; c >= 0; c--) {
              if (table.rows[i + r] && table.rows[i + r].cells[j]) {
                table.rows[i + r].deleteCell(j);
              }
            }
          }
        }
        // Set rowspan and colspan of the target cell
        targetCell.rowSpan = rowspan;
        targetCell.colSpan = colspan;
      }
&#10;window.addEventListener('load', function () { styleCell_tinytable_vjqwkvv2oslcd1txwfyx(0, 0, 'tinytable_css_1300edpbpfziwn9pz3wl') })
window.addEventListener('load', function () { styleCell_tinytable_vjqwkvv2oslcd1txwfyx(0, 1, 'tinytable_css_1300edpbpfziwn9pz3wl') })
window.addEventListener('load', function () { styleCell_tinytable_vjqwkvv2oslcd1txwfyx(0, 2, 'tinytable_css_1300edpbpfziwn9pz3wl') })
window.addEventListener('load', function () { styleCell_tinytable_vjqwkvv2oslcd1txwfyx(0, 3, 'tinytable_css_1300edpbpfziwn9pz3wl') })
window.addEventListener('load', function () { styleCell_tinytable_vjqwkvv2oslcd1txwfyx(0, 4, 'tinytable_css_1300edpbpfziwn9pz3wl') })
window.addEventListener('load', function () { styleCell_tinytable_vjqwkvv2oslcd1txwfyx(0, 5, 'tinytable_css_1300edpbpfziwn9pz3wl') })
window.addEventListener('load', function () { styleCell_tinytable_vjqwkvv2oslcd1txwfyx(0, 6, 'tinytable_css_1300edpbpfziwn9pz3wl') })
window.addEventListener('load', function () { styleCell_tinytable_vjqwkvv2oslcd1txwfyx(0, 7, 'tinytable_css_1300edpbpfziwn9pz3wl') })
window.addEventListener('load', function () { styleCell_tinytable_vjqwkvv2oslcd1txwfyx(0, 8, 'tinytable_css_1300edpbpfziwn9pz3wl') })
window.addEventListener('load', function () { styleCell_tinytable_vjqwkvv2oslcd1txwfyx(0, 9, 'tinytable_css_1300edpbpfziwn9pz3wl') })
window.addEventListener('load', function () { styleCell_tinytable_vjqwkvv2oslcd1txwfyx(0, 10, 'tinytable_css_1300edpbpfziwn9pz3wl') })
    </script>
&#10;  </body>
&#10;</html>

## Regression

``` r
est = feols(mpg ~ hp | cyl, mtcars)
esttable(est)
```

                                 est
    Dependent Var.:              mpg
                                    
    hp              -0.0240 (0.0153)
    Fixed-Effects:  ----------------
    cyl                          Yes
    _______________ ________________
    S.E.: Clustered          by: cyl
    Observations                  32
    R2                       0.75386
    Within R2                0.07998
    ---
    Signif. codes: 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
