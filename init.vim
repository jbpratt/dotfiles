set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua <<EOF
require('go').setup({
  go = "go1.18beta1",           -- set to go1.18beta1 if necessary
  goimport = "gofumports",      -- goimport command
  gofmt = "gofumpt",            -- gofmt cmd
  max_line_len = 120,           -- max line length in goline format
  tag_transform = false,        -- tag_transfer check gomodifytags for details
  verbose = true,               -- output loginf in messages
  log_path = "/tmp/gonvim.log", -- log file
  lsp_cfg = true,               -- true: apply go.nvim non-default gopls setup
  lsp_gofumpt = true,           -- true: set default gofmt in gopls format to gofumpt
  lsp_on_attach = true,         -- if a on_attach function provided:  attach on_attach function to gopls

  lsp_codelens = true,
  -- gopls_remote_auto = true,  -- set to false is you do not want to pass -remote=auto to gopls(enable share)
  -- gopls_cmd = nil,
  -- if you need to specify gopls path and cmd, e.g {"/home/user/lsp/gopls", "-logfile", "/var/log/gopls.log" }
  lsp_diag_hdlr = true,         -- hook lsp diag handler
  dap_debug = true,             -- set to true to enable dap
  dap_debug_keymap = true,      -- set keymaps for debugger
  dap_debug_gui = true,         -- set to true to enable dap gui, highly recommand
  dap_debug_vt = true,          -- set to true to enable dap virtual text

  test_runner = 'dlv',          -- richgo, go test, richgo, dlv, ginkgo
  run_in_floaterm = true        -- set to true to run in float window.
})
EOF
