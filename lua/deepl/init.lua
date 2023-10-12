local xtable = require("pigeon.table")
local xvim = require("npigeon.vim")
local config = require("deepl.config")

--- @param opt DeepLOption
--- @return DeepLAPIClient
function M.setup(opt)
    config.cache(opt)
    return M
end

--- @param source_lang string
--- @param target_lang string
function M.translate(source_lang, target_lang)
    local text = xvim.get_visual_selection()
    local body = {
        text = text,
        source_lang = source_lang,
        target_lang = target_lang
    }
    local rs = config.api:translate(body)

    if rs:ok() then
        ---@type DeepLAPIClientResponseTranslate
        local json = rs:json()

        local contents = {}
        for _, line in pairs(json.translations) do
            table.insert(contents, line.text)
        end

        local t = xtable.wrap({
                string.format(
                    "%s => %s",
                    source_lang,
                    target_lang
                ),
            })
            :concat(text)
            :concat(contents)
            :iter()
            :map(function(line) return { line .. "\n" } end)
            :totable()

        vim.api.nvim_echo(t, true, {})
    else
        print(rs.status, rs.body)
    end
end

--- @return DeepLAPIClient
function M.api()
    return config.api
end

return M
