---@diagnostic disable: undefined-global

local colors = require("matteblack.colors")

local M = {}

local function set(group, spec)
  vim.api.nvim_set_hl(0, group, spec)
end

function M.apply()
  local p = colors.palette

  local highlights = {
    -- Comments
    ["@comment"] = { fg = p.comment, italic = true },
    ["@comment.documentation"] = { fg = p.comment, italic = true },
    ["@comment.error"] = { fg = p.crimson, italic = true },
    ["@comment.warning"] = { fg = p.yellow, italic = true },
    ["@comment.todo"] = { fg = p.yellow, italic = true },
    ["@comment.note"] = { fg = p.comment, italic = true },
    ["@comment.hint"] = { fg = p.comment, italic = true },
    ["@comment.hack"] = { fg = p.yellow, italic = true },
    ["@comment.fixme"] = { fg = p.crimson, bold = true },
    ["@comment.xxx"] = { fg = p.purple, bold = true },

    -- Constants (amber's actual home now — nowhere else)
    ["@constant"] = { fg = p.amber },
    ["@constant.builtin"] = { fg = p.amber },
    ["@constant.macro"] = { fg = p.yellow },

    -- Strings
    ["@string"] = { fg = p.green },
    ["@string.documentation"] = { fg = p.green },
    ["@string.regex"] = { fg = p.magenta },
    ["@string.escape"] = { fg = p.gold },
    ["@string.special"] = { fg = p.gold },
    ["@string.special.symbol"] = { fg = p.gold },
    ["@string.special.path"] = { fg = p.gold },
    ["@string.special.url"] = { fg = p.orange, italic = true },

    -- Characters & numbers
    ["@character"] = { fg = p.gold },
    ["@character.special"] = { fg = p.gold },
    ["@number"] = { fg = p.gold },
    ["@number.float"] = { fg = p.gold },
    ["@boolean"] = { fg = p.teal },

    -- Functions (own hue — pink — separate from constants/builtins)
    ["@function"] = { fg = p.pink },
    ["@function.builtin"] = { fg = p.amber },
    ["@function.call"] = { fg = p.pink },
    ["@function.macro"] = { fg = p.yellow },
    ["@function.method"] = { fg = p.pink },
    ["@function.method.call"] = { fg = p.pink },
    ["@function.decorator"] = { fg = p.amber },
    ["@constructor"] = { fg = p.yellow },

    -- Variables (kept neutral so they never compete with keywords/functions)
    ["@variable"] = { fg = p.fg2 },
    ["@variable.builtin"] = { fg = p.blue },
    ["@variable.parameter"] = { fg = p.fg2 },
    ["@variable.member"] = { fg = p.fg1 },
    ["@variable.global"] = { fg = p.fg2 },
    ["@variable.special"] = { fg = p.blue, italic = true },

    -- Fields & properties (own slot — ochre, was previously unused)
    ["@field"] = { fg = p.ochre },
    ["@property"] = { fg = p.ochre },
    ["@label"] = { fg = p.purple },

    -- Types & namespaces
    ["@type"] = { fg = p.cyan },
    ["@type.builtin"] = { fg = p.cyan, italic = true },
    ["@type.definition"] = { fg = p.cyan },
    ["@type.qualifier"] = { fg = p.purple, italic = true },
    ["@type.interface"] = { fg = p.cyan, italic = true },
    ["@type.parameter"] = { fg = p.cyan, italic = true },
    ["@namespace"] = { fg = p.gray1, italic = true },
    ["@module"] = { fg = p.gray1, italic = true },

    -- Keywords & operators (all one consistent hue — purple)
    ["@keyword"] = { fg = p.purple },
    ["@keyword.function"] = { fg = p.purple },
    ["@keyword.operator"] = { fg = p.fg2 },
    ["@keyword.return"] = { fg = p.purple },
    ["@keyword.import"] = { fg = p.purple },
    ["@keyword.conditional"] = { fg = p.purple },
    ["@keyword.repeat"] = { fg = p.purple },
    ["@keyword.exception"] = { fg = p.purple },
    ["@keyword.directive"] = { fg = p.blue },
    ["@keyword.directive.define"] = { fg = p.blue },
    ["@keyword.modifier"] = { fg = p.purple },
    ["@operator"] = { fg = p.fg2 },

    -- Punctuation
    ["@punctuation"] = { fg = p.fg3 },
    ["@punctuation.delimiter"] = { fg = p.fg3 },
    ["@punctuation.bracket"] = { fg = p.fg3 },
    ["@punctuation.special"] = { fg = p.orange },
    ["@punctuation.special.symbol"] = { fg = p.orange },

    -- Decorators & attributes (amber — metadata, matches constants family)
    ["@attribute"] = { fg = p.amber, italic = true },
    ["@decorator"] = { fg = p.amber },

    -- Tags
    ["@tag"] = { fg = p.crimson },
    ["@tag.attribute"] = { fg = p.amber, italic = true },
    ["@tag.delimiter"] = { fg = p.fg2 },

    -- Markup
    ["@markup.strong"] = { fg = p.fg1, bold = true },
    ["@markup.italic"] = { fg = p.fg1, italic = true },
    ["@markup.heading"] = { fg = p.amber, bold = true },
    ["@markup.link"] = { fg = p.orange, underline = true },
    ["@markup.link.url"] = { fg = p.orange, underline = true },
    ["@markup.link.label"] = { fg = p.orange },
    ["@markup.list"] = { fg = p.orange },
    ["@markup.list.checked"] = { fg = p.teal },
    ["@markup.list.unchecked"] = { fg = p.orange },
    ["@markup.quote"] = { fg = p.fg3, italic = true },
    ["@markup.raw"] = { fg = p.fg1 },
    ["@markup.raw.block"] = { fg = p.fg1 },
    ["@markup.math"] = { fg = p.gold },
    ["@markup.underline"] = { fg = p.orange, underline = true },

    -- Diff / SCM
    ["@diff.plus"] = { fg = p.teal },
    ["@diff.minus"] = { fg = p.crimson },
    ["@diff.delta"] = { fg = p.orange },

    -- Preprocessor
    ["@preproc"] = { fg = p.blue },
    ["@include"] = { fg = p.blue },
    ["@define"] = { fg = p.blue },
    ["@conditional"] = { fg = p.purple },
    ["@repeat"] = { fg = p.purple },
    ["@exception"] = { fg = p.purple },

    -- Special cases
    ["@character.printf"] = { fg = p.gold },
  }

  for group, spec in pairs(highlights) do
    set(group, spec)
  end

  -- Language specific overrides
  set("@function.builtin.lua", { fg = p.amber })
  set("@variable.builtin.lua", { fg = p.blue, italic = true })
  set("@function.builtin.python", { fg = p.amber })
  set("@variable.builtin.python", { fg = p.blue, italic = true })
  set("@function.builtin.javascript", { fg = p.amber })
  set("@variable.builtin.javascript", { fg = p.blue, italic = true })
end

return M
