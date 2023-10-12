local curl = require("npigeon.plenary.curl")

local baseURL = "https://api-free.deepl.com"

--- @params path string
--- @return string
local endpoint = function(path)
    return baseURL .. "/" .. path
end

---@class DeepLAPIClient
---@field apikey string
local DeepLAPIClient = {}

--- @param apikey string
--- @return DeepLAPIClient
DeepLAPIClient.new = function(apikey)
    local obj = { apikey = apikey, }
    return setmetatable(obj, { __index = DeepLAPIClient })
end

--- @param api DeepLAPIClient
--- @return table
local header = function(api)
    return {
        Authorization = string.format("DeepL-Auth-Key %s", api.apikey),
        ["Content-Type"] = "application/json",
    }
end

---@class DeepLAPIClientRequestTranslate
---@field text string
---@field source_lang string
---@field target_lang string

---@class DeepLAPIClientResponseTranslateInner
---@field detected_source_language string
---@field text string

---@class DeepLAPIClientResponseTranslate
---@field translations DeepLAPIClientResponseTranslateInner[]

---@ref: https://www.deepl.com/ja/docs-api/translate-text/translate-text
---@param params DeepLAPIClientRequestTranslate
---@return PlenaryCurlResponse
function DeepLAPIClient:translate(params)
    local url = endpoint("v2/translate")
    local rs = curl.post(url, {
        headers = header(self),
        body = vim.fn.json_encode(params),
    })
    return rs
end

---@return string[]
DeepLAPIClient.source_langs = function()
    return {
        "BG", -- Bulgarian
        "CS", -- Czech
        "DA", -- Danish
        "DE", -- German
        "EL", -- Greek
        "EN", -- English
        "ES", -- Spanish
        "ET", -- Estonian
        "FI", -- Finnish
        "FR", -- French
        "HU", -- Hungarian
        "ID", -- Indonesian
        "IT", -- Italian
        "JA", -- Japanese
        "KO", -- Korean
        "LT", -- Lithuanian
        "LV", -- Latvian
        "NB", -- Norwegian (Bokmål)
        "NL", -- Dutch
        "PL", -- Polish
        "PT", -- Portuguese (all Portuguese varieties mixed)
        "RO", -- Romanian
        "RU", -- Russian
        "SK", -- Slovak
        "SL", -- Slovenian
        "SV", -- Swedish
        "TR", -- Turkish
        "UK", -- Ukrainian
        "ZH", -- Chinese
    }
end

---@return string[]
DeepLAPIClient.target_langs = function()
    return {
        "BG",    -- Bulgarian
        "CS",    -- Czech
        "DA",    -- Danish
        "DE",    -- German
        "EL",    -- Greek
        "EN",    -- English (unspecified variant for backward compatibility; please select EN-GB or EN-US instead)
        "EN-GB", -- English (British)
        "EN-US", -- English (American)
        "ES",    -- Spanish
        "ET",    -- Estonian
        "FI",    -- Finnish
        "FR",    -- French
        "HU",    -- Hungarian
        "ID",    -- Indonesian
        "IT",    -- Italian
        "JA",    -- Japanese
        "KO",    -- Korean
        "LT",    -- Lithuanian
        "LV",    -- Latvian
        "NB",    -- Norwegian (Bokmål)
        "NL",    -- Dutch
        "PL",    -- Polish
        "PT",    -- Portuguese (unspecified variant for backward compatibility; please select PT-BR or PT-PT instead)
        "PT-BR", -- Portuguese (Brazilian)
        "PT-PT", -- Portuguese (all Portuguese varieties excluding Brazilian Portuguese)
        "RO",    -- Romanian
        "RU",    -- Russian
        "SK",    -- Slovak
        "SL",    -- Slovenian
        "SV",    -- Swedish
        "TR",    -- Turkish
        "UK",    -- Ukrainian
        "ZH",    -- Chinese (simplified)
    }
end

return DeepLAPIClient
