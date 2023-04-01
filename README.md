# CommandPromt.nvim - Neovim Plugin for a simple command picker

This is a plugin for Neovim that allows you to easily pick and execute commands
using Telescope.

## Installation

To use this plugin, you need to have
[Telescope](https://github.com/nvim-telescope/telescope.nvim) installed.

You can install this plugin using your favorite plugin manager. For example,
using [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'renerocksai/CommandPrompt.nvim'
```

## Usage

This plugin defines a list of default commands that you can execute using the
command picker. You can also define your own commands by passing them to the
`setup` function:


```lua
require('commandprompt').setup({
  {
    description = "Summarize",
    cmd = ':ChatGPTRun turbo-sum',
  }
  ,{
    description = "Make it sound more professional",
    cmd = ':ChatGPTRun en-professional',
  }
})
-- Add a keymapping to open the command picker
vim.api.nvim_set_keymap('n', '<Leader>g', ':lua require("gptcommands").command_picker()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Leader>g', ':lua require("gptcommands").command_picker()<CR>', { noremap = true, silent = true })
```

To open the command picker, press `<Leader>g` in normal mode or `<Leader>g` in
visual mode.

## Customization

You can customize the behavior of the command picker by passing options to the
`command_picker` function. For example:

```lua
require('gptcommands').command_picker({
  prompt_title = "My Commands",
  sorter = require('telescope.sorters').get_fzy_sorter(),
})
```

For more information on the available options, see the [Telescope documentation](https://github.com/nvim-telescope/telescope.nvim#pickers).

## License

This plugin is licensed under the MIT License. See the [LICENSE](LICENSE) file
for details.

