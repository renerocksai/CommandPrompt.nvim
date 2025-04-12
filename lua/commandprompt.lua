-- Neovim Plugin for command picker

local M = {}

-- Define the default commands list
local default_commands = {
  {
    description = "Search for pattern",
    cmd = ':vimgrep /%s/ **/*',
    args = {"pattern"}
  },
  {
    description = "Show Git log for file",
    cmd = ':Git log -- %s',
    args = {"file"}
  },
}

-- Create the Telescope picker
local telescope = require('telescope')
local actions = require('telescope.actions')
local action_state = require("telescope.actions.state")
local sorters = require('telescope.sorters')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')

local make_command_entry = function(command)
  local args = ""
  if command.args then
    args = " " .. table.concat(command.args, " ")
  end

  return {
    value = command.cmd,
    display = command.description .. " (" .. command.cmd .. args .. ")",
    ordinal = command.description,
    cmd = command.cmd,
    args = command.args,
  }
end

local command_picker = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "Commands",
    finder = finders.new_table({
      results = M.commands or default_commands,
      entry_maker = make_command_entry,
    }),
    sorter = sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            local args = {}
            for _, arg in ipairs(selection.args or {}) do
              local input = vim.fn.inputdialog(arg .. ":")
              if input ~= "" then
                table.insert(args, input)
              end
            end
            local command = string.format(selection.cmd, unpack(args))
            vim.cmd(command)
        end)
        return true
    end,
  }):find()
end


function M.setup(user_commands)
  -- Override the default commands list with user-provided commands
  user_commands = user_commands or default_commands
  if user_commands then
    M.commands = user_commands
  end

  vim.print("CommandPrompt set up with these commands:")
  vim.print(vim.inspect(M.commands))
end

function M.command_picker()
  -- Open the command picker
  command_picker({})
end

return M

