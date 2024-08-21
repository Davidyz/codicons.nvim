return {
  register_cmp = function()
    local source = {}
    local icon_table = require('codicons.table')
    ---@param params cmp.SourceCompletionApiParams
    ---@param callback fun(response: lsp.CompletionResponse|nil)
    function source:complete(params, callback)
      ---@type lsp.CompletionItem[]
      local items = {}
      for k, v in pairs(icon_table) do
        if type(k) == 'string' then
          local icon = require('codicons').get(k, 'icon')
          vim.list_extend(items, {
            {
              label = k,
              documentation = string.format('codicon `%s`: `%s`', k, icon),
              insertText = icon,
              kind = require('cmp.types.lsp').CompletionItemKind.EnumMember,
            },
          })
        end
      end
      return callback(items)
    end

    ---@param completion_item lsp.CompletionItem
    ---@param callback fun(completion_item: lsp.CompletionItem|nil)
    function source:resolve(completion_item, callback)
      return callback(completion_item)
    end

    ---@param completion_item lsp.CompletionItem
    ---@param callback fun(completion_item: lsp.CompletionItem|nil)
    function source:execute(completion_item, callback)
      return callback(completion_item)
    end

    function source:get_trigger_characters()
      return { '.' }
    end

    require('cmp').register_source('codicons', source)
  end,
}
