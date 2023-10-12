local api = require("deepl.api")

---@class DeepLOption
---@field apikey string

---@class DeepLConfig
---@field api DeepLAPIClient
local DeepLConfig = {}

---@param opt DeepLOption
function DeepLConfig.cache(opt)
    DeepLConfig.api = api.new(opt.apikey)
end

return DeepLConfig
