local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  -- b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettierd,
  -- b.diagnostics.stylelint.with { filetypes = { "vue", "css", "scss", "less", "sass" } },

  -- python
  b.formatting.black,
  b.formatting.isort,

  -- c/c++
  b.formatting.clang_format,

  -- golang
  b.formatting.goimports_reviser,
  b.formatting.gofumpt,

  -- Lua
  b.formatting.stylua,

  -- Shell
  b.formatting.shfmt,
  b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

  -- yaml
  b.formatting.yamlfmt,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
