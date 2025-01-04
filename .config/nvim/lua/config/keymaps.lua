local m = vim.keymap.set
local util = require("util")

local E = { expr = true }
local R = { remap = true }
local S = { silent = true }
local ER = { expr = true, remap = true }

local function relpath()
  local path = vim.fn.expand("%:~:.:h")
  if path == "" or path == "." then
    return ""
  else
    return path .. "/"
  end
end

vim.g.maplocalleader = "<Space>"
m("n", "<Space>", "<Nop>")

m("n", "t", "<Nop>")
m("n", "<C-g>", "<Nop>")
m("n", "<C-g><C-g>", "<C-g>")

m("n", "ZQ", "<Nop>")
m("n", "ZZ", "<Nop>")

m({ "n", "x" }, "j", "gj")
m({ "n", "x" }, "k", "gk")
m({ "n", "x" }, "gj", "j")
m({ "n", "x" }, "gk", "k")

m("n", "*", "*<Cmd>set hlsearch<CR>", S)
m("n", "#", "#<Cmd>set hlsearch<CR>", S)
m("n", "g*", "g*<Cmd>set hlsearch<CR>", S)
m("n", "g#", "g#<Cmd>set hlsearch<CR>", S)
m("x", "*", 'y/\\V<C-R>"<CR><Cmd>set hlsearch<CR>', S)
m("x", "#", 'y?\\V<C-R>"<CR><Cmd>set hlsearch<CR>', S)
m("n", "<Esc><Esc>", "<Cmd>set nohlsearch<CR>", S)

m("n", "<C-n>", "gt")
m("n", "<C-p>", "gT")
m("n", "g<C-n>", "<Cmd>tablast<CR>", S)
m("n", "g<C-p>", "<Cmd>tabfirst<CR>", S)
m("n", "<C-g><C-n>", "g<C-n>", R)
m("n", "<C-g><C-p>", "g<C-p>", R)

m("n", "ta", "<Cmd>tabs<CR>", S)

m("n", "tb", "<Cmd>call tabutil#buffer(v:count1)<CR>", S)
m("n", "tn", "<Cmd>call tabutil#bnext(v:count1)<CR>", S)
m("n", "tp", "<Cmd>call tabutil#bprevious(v:count1)<CR>", S)
m("n", "tx", "<Cmd>quit<CR>", S)
m("n", "tD", "<Cmd>bdelete<CR>", S)
m("n", "tg", "tb", R)

m("n", "tl", "<Cmd>call tabutil#move(v:count1)<CR>", S)
m("n", "th", "<Cmd>call tabutil#move(-v:count1)<CR>", S)
m("n", "tL", "<Cmd>tabmove<CR>", S)
m("n", "tH", "<Cmd>tabmove 0<CR>", S)
m("n", "tM", '":\\<C-u>tabmove " . v:count . "\\<CR>"', E)

local function relopen(s)
  return function()
    return s .. relpath()
  end
end

m("n", "to", ":<C-u>Edit<Space>")
m("n", "tt", ":<C-u>Tabedit<Space>")
m("n", "ts", ":<C-u>Split<Space>")
m("n", "tv", ":<C-u>Vsplit<Space>")
m("n", "tO", relopen("to"), ER)
m("n", "tT", relopen("tt"), ER)
m("n", "tS", relopen("ts"), ER)
m("n", "tV", relopen("tv"), ER)

m("n", "td", "<Cmd>call tabutil#close()<CR>", S)
m("n", "tq", "<Cmd>call tabutil#only()<CR>", S)
m("n", "tu", "<Cmd>call tabutil#undo()<CR>", S)
m("n", "tU", "<Cmd>call tabutil#undoall()<CR>", S)

m("n", "t<C-t>", "<Cmd>call tabutil#split()<CR>", S)
m("n", "t<C-s>", "<Cmd>call tabutil#wsplit()<CR>", S)
m("n", "t<C-v>", "<Cmd>call tabutil#vsplit()<CR>", S)
m("n", "tm", "t<C-t>", R)

m("n", "tr", "<Cmd>call tabutil#reorganize()<CR>", S)
m("n", "tR", "<Cmd>call tabutil#reorganize1()<CR>", S)

m("n", "t]", "<Cmd>tab tag <C-r><C-w><CR>", S)
m("n", "t;", "<Cmd>tab tjump <C-r><C-w><CR>", S)
m("n", "t<CR>", "<Cmd>tab wincmd <C-v><CR><CR>", S)
m("n", "tf", "<C-w>gf")
m("n", "tF", "<C-w>gF")

m("n", "tc", "<C-w>c")
m("n", "<Esc>h", "<C-w>h")
m("n", "<Esc>j", "<C-w>j")
m("n", "<Esc>k", "<C-w>k")
m("n", "<Esc>l", "<C-w>l")

m("n", "Q", "q")
m("n", "q", "<Nop>")

m("n", "q:", "q:")
m("n", "q/", "q/")
m("n", "q?", "q?")

-- Quickfix
m("n", "q\\", "<Cmd>call qfutil#toggle()<CR>", S)

m("n", "g<C-j>", "<Cmd>call qfutil#last(v:count)<CR>", S)
m("n", "g<C-k>", "<Cmd>call qfutil#first(v:count)<CR>", S)
m("n", "<C-g><C-j>", "g<C-j>", R)
m("n", "<C-g><C-k>", "g<C-k>", R)

m("n", "q.", "<Cmd>call qfutil#toggle_window()<CR>", S)
m("n", "qq", "<Cmd>call qfutil#qq(v:count)<CR>", S)
m("n", "qn", "<Cmd>call qfutil#nfile(v:count)<CR>", S)
m("n", "qp", "<Cmd>call qfutil#pfile(v:count)<CR>", S)
m("n", "qa", "<Cmd>call qfutil#list()<CR>", S)
m("n", "qo", "<Cmd>call qfutil#older(v:count)<CR>", S)
m("n", "qi", "<Cmd>call qfutil#newer(v:count)<CR>", S)

m("n", "qM", "qfutil#make()", R)
m("n", "qm", ":<C-u>QFMake<Space>")
m("n", "qg", ":<C-u>QFGrep<Space>")

m("n", "q]", "<Cmd>call qfutil#ltag()<CR>")

m("n", "+", "zr", S)
m("n", "-", "zm", S)

m("n", "<C-c>", function()
  vim.fn.setreg("+", vim.fn.getreg("@"):gsub("\n$", ""))
end, S)

m("n", "<Space>s", [[<Cmd>let &opfunc="{_ -> execute(\"'[,']sort\")}"<CR>g@]])
m("n", "<Space>S", [[<Cmd>let &opfunc="{_ -> execute(\"'[,']sort!\")}"<CR>g@]])
m("x", "<Space>s", ":sort<CR>")
m("x", "<Space>S", ":sort!<CR>")

m("n", "<Space>/", "<Cmd>set hlsearch! hlsearch?<CR>", S)
m("n", "<Space>z", "<Cmd>setlocal spell! | let b:spell = &l:spell | setlocal spell?<CR>", S)
m("n", "<Space>Z", "<Cmd>let b:spell = -1<CR>", S)
m("n", "<Space>c", "<Cmd>let &l:cc = &l:cc != 0 ? 0 : 81<CR>", S)
m("n", "<Space><Tab>", "<Cmd>HlAnnoyingSpaceToggle<CR>", S)
m("n", "<Space>=", "`[=`]")

local function ctrl_w()
  local line = vim.api.nvim_get_current_line()
  local pos = vim.api.nvim_win_get_cursor(0)
  if line:sub(pos[2] - 1, pos[2]):find("%s%s") then
    return "<C-g>u<C-o>:let &sts=&ts<CR><BS><C-o>:let &sts=0<CR>"
  end
  return "<C-g>u<C-w>"
end

m("i", "<C-w>", ctrl_w, E)

m("i", "<C-g><C-l>", "<C-o>b<C-o>g~w<C-o>w<Right>")
m("i", "<C-g>L", "<C-o>b<C-o>gUw<C-o>w<Right>")
m("i", "<C-g>l", "<C-o>b<C-o>guw<C-o>w<Right>")

m("i", "<C-g>d", function()
  return os.date("%Y-%m-%d")
end, E)

local function border_line(char)
  local prevline_nr = vim.api.nvim_win_get_cursor(0)[1] - 1
  if prevline_nr == 0 then
    return ""
  end
  local prevline = vim.api.nvim_buf_get_lines(0, prevline_nr - 1, prevline_nr, false)
  return string.rep(char, vim.fn.strdisplaywidth(prevline[1]))
end

m("i", "<C-g>=", util.curry(border_line, "="), E)
m("i", "<C-g>-", util.curry(border_line, "-"), E)
m("i", "<C-g>~", util.curry(border_line, "~"), E)
m("i", "<C-g>^", util.curry(border_line, "^"), E)
m("i", '<C-g>"', util.curry(border_line, '"'), E)

m({ "c", "i" }, "<C-a>", "<Home>")
m({ "c", "i" }, "<C-e>", "<End>")
m({ "c", "i" }, "<C-b>", "<Left>")
m({ "c", "i" }, "<C-f>", "<Right>")

m("c", "<CR>", function()
  local cmdtype = vim.fn.getcmdtype()
  if cmdtype == "/" or cmdtype == "?" then
    vim.opt.hlsearch = true
  end
  return "<CR>"
end, E)
--m("c", '<C-g>', "<C-r>=<SID>kill_arg()<CR>")
m("c", "<C-_>", util.curry(relpath), E)
m("c", "<C-r><C-_>", util.curry(relpath), E)

m("c", "<C-j>", function()
  if vim.fn.wildmenumode() == 1 then
    return "<C-n>"
  else
    return "<C-j>"
  end
end, E)
m("c", "<C-k>", function()
  if vim.fn.wildmenumode() == 1 then
    return "<C-p>"
  else
    return "<C-k>"
  end
end, E)

local function increment_dates(s, days)
  return s:gsub("(%d%d%d%d)%-(%d%d)%-(%d%d)", function(year, month, day)
    local parsed_date = os.time({ year = year, month = month, day = day })
    return os.date("%Y-%m-%d", parsed_date + 86400 * days)
  end)
end

m({ "n", "x" }, "<Space>d", util.curry(util.filterfunc, util.curry2(increment_dates, 1)), E)
m({ "n", "x" }, "<Space>-d", util.curry(util.filterfunc, util.curry2(increment_dates, -1)), E)

m("x", "<Space>D", util.curry(util.Filterfunc, util.curry2(increment_dates, 1)), E)
m("x", "<Space>-D", util.curry(util.Filterfunc, util.curry2(increment_dates, -1)), E)

m("n", "<Space>dd", "<Space>d_", R)
m("n", "<Space>-dd", "<Space>-d_", R)
m("n", "<Space>D", "<Space>d$", R)
m("n", "<Space>-D", "<Space>-d$", R)

m({ "n", "x" }, "<Space><C-d>", "<Space>-d", R)
m("n", "<Space><C-d><C-d>", "<Space><C-d>_", R)
