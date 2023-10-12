command! -nargs=* DeepLTranslate call DeepLTranslate(<f-args>)

function! DeepLTranslate(source, target)
     lua print(vim.api.nvim_eval("a:source"), vim.api.nvim_eval("a:target"))
     lua require("deepl").translate( vim.api.nvim_eval("a:source"), vim.api.nvim_eval("a:target"))
endfunction
