# Symbols
Macro to replace symbols and strings in the code files during loading

Example can be found under `/example`.

## How it works
Load files with non-ascii characters via `#insert #run loadex(filename [, replacement_filename, debug=false])` instead of `#load filename`.
- The first argument `filename : string` is the source file you want to load.
- The second argument `replacement_filename : string` is the file that contains a table of replacements in the style of `original : replacement`. By default, it will load `replacements.txt` of the module. It contains a standard list of Greek symbols and a few math symbols.
- The last argument `debug: bool = false` is symply to print out debug information during the replacement process. Default is `false`;

<!> Make sure, you don't have empty lines in the replacement file and only one `original : replacement` pair on every line, see `replacements.txt`.