return {
  'lervag/vimtex',
  init = function()
    -- Use init for configuration, don't use the more common "config".
    vim.g.vimtex_compiler_method = 'latexmk'
  end,
}
