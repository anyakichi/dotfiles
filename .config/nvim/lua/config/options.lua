-- Encodings
vim.opt.fileencodings = "ucs-bom,utf-8,euc-jp,cp932,iso-2022-jp,utf-16,ucs-2le,ucs-2"

-- Colors
if os.getenv("COLORTERM") == "truecolor" then
  vim.opt.termguicolors = true
end
vim.opt.pumblend = 20
vim.opt.winblend = 20

-- Indentation
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cinoptions = ">2s,e0,n0,f0,{0,}0,^0,:0,=2s,l1,b0,g2s,h2s,p2s,t0,i2s,"
  .. "+1s,c1s,C0,/0,(0,u0,U0,w1,W0,m1,j1,)20,*30"
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 0
vim.opt.tabstop = 8

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false

-- Formatting
vim.opt.formatoptions:append("rolmB")
vim.opt.textwidth = 78

-- Completion
vim.opt.complete = ".,w,b,u"
vim.opt.completeopt = "menuone,preview"
vim.opt.pumheight = 10

-- Appearance
vim.opt.cursorline = true
vim.opt.laststatus = 3
vim.opt.number = true
vim.opt.signcolumn = "number"

-- Diff
vim.opt.diffopt:append({ "vertical", "indent-heuristic", "algorithm:histogram" })

-- Folding
vim.opt.foldenable = false

-- Command line
vim.opt.wildmode = "longest,list,full"

-- Visual mode
vim.opt.virtualedit = "block"

-- Window
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.winminheight = 0

-- Backup and swap
vim.opt.undofile = true

-- Mappings
vim.opt.cedit = "<C-x>"

-- Spell checking
vim.opt.spelllang = "en_us,cjk"
