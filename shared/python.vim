set shiftwidth=4     " Set indentation level as 4 spaces
set tabstop=8        " Number of spaces a <Tab> in the file counts for
set softtabstop=4    " Number of spaces a <Tab> counts for while performing editing operations like inserting a <Tab> or using <BS> 
set expandtab        " In Insert mode, use the appropriate number of spaces to insert a <Tab> 
set autoindent smartindent
set colorcolumn=80
set number

setlocal wildignore=*/__pycache__/*,*.pyc
setlocal include=^\\s*import
setlocal define=^\\s*\\<\\(def\\\|class\\)\\>

" Set the values of registers
let @a = 'oimport pdb; pdb.set_trace()' " Save import pdb; pdb.set_trace() to register a
