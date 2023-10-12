local xtable = require("pigeon.table")
local xvim = require("npigeon.vim")
local config = require("deepl.config")

--- @param opt DeepLOption
--- @return DeepLAPIClient
function M.setup(opt)
    config.cache(opt)
    return M
end

---@params source string
---@params target string
---@params text  string
---@params json  DeepLAPIClientResponseTranslate
local display = function(source, target, text, json)
    local contents = {}
    for _, line in ipairs(json.translations) do
        table.insert(contents, line.text)
    end

    local t = xtable.wrap({
            string.format(
                "%s => %s",
                source,
                target
            ),
        })
        :concat(text)
        :concat(contents)
        :iter()
        :map(function(line) return { line .. "\n" } end)
        :totable()

    vim.api.nvim_echo(t, true, {})
end

--- @param source_lang string
--- @param target_lang string
--- @param line string
function M.translate(source_lang, target_lang, line)
    local text = { line }
    local body = {
        text = text,
        source_lang = source_lang,
        target_lang = target_lang
    }
    local rs = config.api:translate(body)

    if rs:ok() then
        display(source_lang, target_lang, text, rs:json())
    else
        print(rs.status, rs.body)
    end
end

--- @param source_lang string
--- @param target_lang string
function M.translate_selected(source_lang, target_lang)
    local text = xvim.get_visual_selection()
    local body = {
        text = text,
        source_lang = source_lang,
        target_lang = target_lang
    }
    local rs = config.api:translate(body)

    if rs:ok() then
        display(source_lang, target_lang, text, rs:json())
    else
        print(rs.status, rs.body)
    end
end

--- @return DeepLAPIClient
function M.api()
    return config.api
end

return M
