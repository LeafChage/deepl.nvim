command! -nargs=* DeepLTranslateInVisual call DeepLTranslateInVisual(<f-args>)
command! -nargs=* DeepLTranslate call DeepLTranslate(<f-args>)

function! DeepLTranslateInVisual(source, target)
     lua require("deepl").translate_selected(vim.api.nvim_eval("a:source"), vim.api.nvim_eval("a:target"))
endfunction

function! DeepLTranslate(source, target, ...)
    lua require("deepl").translate(vim.api.nvim_eval("a:source"), vim.api.nvim_eval("a:target"), vim.api.nvim_eval("join(a:000)"))
endfunction
