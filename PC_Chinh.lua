-- DOCUMENTATION: https://ic3w0lf22.gitbook.io/roblox-account-manager/

local Account = {} Account.__index = Account

local WebserverSettings = {
    Port = '7963',
    Password = ''
}

function WebserverSettings:SetPort(Port) self.Port = Port end
function WebserverSettings:SetPassword(Password) self.Password = Password end

local HttpService = game:GetService'HttpService'
local Request = (syn and syn.request) or request or (http and http.request) or http_request

-- helper log that uses rconsoleprint if available otherwise warn/print
local function log(...)
    local msg = table.concat({...}, " ")
    if rconsoleprint then
        pcall(rconsoleprint, msg .. "\n")
    else
        warn(msg)
    end
end

-- safeRequest wraps Request in pcall and normalizes return value
local function safeRequest(opts)
    if not Request then
        log("[HTTP][ERROR] No HTTP request function found in this executor (Request is nil).")
        return nil, "NoRequestFunction"
    end
    local ok, res = pcall(function() return Request(opts) end)
    if not ok then
        log("[HTTP][ERROR] Request threw error:", tostring(res))
        return nil, res
    end
    if res == nil then
        log("[HTTP][ERROR] Request returned nil (no response). Options:", HttpService:JSONEncode(opts))
        return nil, "NilResponse"
    end
    return res, nil
end

local function buildBaseUrl(Method, Account)
    return 'http://192.168.1.11:' .. WebserverSettings.Port .. '/' .. Method .. '?Account=' .. tostring(Account)
end

local function GET(Method, Account, ...)
    local Arguments = {...}
    local Url = buildBaseUrl(Method, Account)

    for Index, Parameter in pairs(Arguments) do
        if typeof(Parameter) == 'boolean' then
            -- skip boolean flags (they will be handled when appended as flag strings)
        else
            Url = Url .. '&' .. tostring(Parameter)
        end
    end

    if WebserverSettings.Password and #WebserverSettings.Password >= 6 then
        Url = Url .. '&Password=' .. HttpService:UrlEncode(WebserverSettings.Password)
    end

    log("[GET] Requesting:", Url)

    local Response, err = safeRequest({
        Method = 'GET',
        Url = Url
    })

    if not Response then
        log("[GET][FAIL] No response from request. err:", tostring(err))
        return false
    end

    -- try to get StatusCode in a safe way (some executors use .Status or .status)
    local status = Response.StatusCode or Response.Status or Response.status
    if not status then
        -- try to stringify the response for debugging
        local okEnc, enc = pcall(function() return HttpService:JSONEncode(Response) end)
        log("[GET][FAIL] Response missing status code. RawResponse:", okEnc and enc or tostring(Response))
        return false
    end

    if tonumber(status) ~= 200 then
        local body = Response.Body or Response.body or "(no body)"
        log("[GET][FAIL] Non-200 status:", tostring(status), "Body:", tostring(body))
        return false
    end

    local body = Response.Body or Response.body
    if body == nil then
        log("[GET][WARN] Response status 200 but body is nil. URL:", Url)
        return false
    end

    log("[GET][OK] URL:", Url, "Status:", tostring(status), "BodyLen:", tostring(#tostring(body)))
    return body
end

local function POST(Method, Account, Body, ...)
    local Arguments = {...}
    local Url = buildBaseUrl(Method, Account)

    for Index, Parameter in pairs(Arguments) do
        if typeof(Parameter) == 'boolean' then
            -- boolean flags (handled below if needed)
        else
            Url = Url .. '&' .. tostring(Parameter)
        end
    end

    if WebserverSettings.Password and #WebserverSettings.Password >= 6 then
        Url = Url .. '&Password=' .. HttpService:UrlEncode(WebserverSettings.Password)
    end

    log("[POST] Requesting:", Url, "BodyLen:", tostring(Body and #tostring(Body) or 0))

    local Response, err = safeRequest({
        Method = 'POST',
        Url = Url,
        Body = Body
    })

    if not Response then
        log("[POST][FAIL] No response from request. err:", tostring(err))
        return false
    end

    local status = Response.StatusCode or Response.Status or Response.status
    if not status then
        local okEnc, enc = pcall(function() return HttpService:JSONEncode(Response) end)
        log("[POST][FAIL] Response missing status code. RawResponse:", okEnc and enc or tostring(Response))
        return false
    end

    if tonumber(status) ~= 200 then
        local body = Response.Body or Response.body or "(no body)"
        log("[POST][FAIL] Non-200 status:", tostring(status), "Body:", tostring(body))
        return false
    end

    local body = Response.Body or Response.body
    if body == nil then
        log("[POST][WARN] Response status 200 but body is nil. URL:", Url)
        return false
    end

    log("[POST][OK] URL:", Url, "Status:", tostring(status), "BodyLen:", tostring(#tostring(body)))
    return body
end

function Account.new(Username, SkipValidation)
    local self = {} setmetatable(self, Account)

    -- debug: in ra Username + SkipValidation
    log("[Account.new] Username:", tostring(Username), "SkipValidation:", tostring(SkipValidation))

    local IsValid = SkipValidation or GET('GetCSRFToken', Username)

    -- log kết quả IsValid (có thể là string, false, nil)
    log("[Account.new] GetCSRFToken result:", tostring(IsValid))

    if not IsValid or IsValid == 'Invalid Account' then
        log("[Account.new][FAIL] Account invalid or GetCSRFToken failed for:", tostring(Username))
        return false
    end

    self.Username = Username

    log("[Account.new][OK] Created Account object for:", tostring(Username))
    return self
end

function Account:GetCSRFToken() 
    log("[Account:GetCSRFToken] for", tostring(self and self.Username))
    return GET('GetCSRFToken', self.Username) 
end

function Account:BlockUser(Argument)
    if typeof(Argument) == 'string' then
        return GET('BlockUser', self.Username, 'UserId=' .. Argument)
    elseif typeof(Argument) == 'Instance' and Argument:IsA'Player' then
        return self:BlockUser(tostring(Argument.UserId))
    elseif typeof(Argument) == 'number' then
        return self:BlockUser(tostring(Argument))
    else
        log("[BlockUser][WARN] Unsupported argument type:", typeof(Argument))
    end
end
function Account:UnblockUser(Argument)
    if typeof(Argument) == 'string' then
        return GET('UnblockUser', self.Username, 'UserId=' .. Argument)
    elseif typeof(Argument) == 'Instance' and Argument:IsA'Player' then
        return self:BlockUser(tostring(Argument.UserId))
    elseif typeof(Argument) == 'number' then
        return self:BlockUser(tostring(Argument))
    else
        log("[UnblockUser][WARN] Unsupported argument type:", typeof(Argument))
    end
end
function Account:GetBlockedList() 
    log("[GetBlockedList] for", tostring(self.Username))
    return GET('GetBlockedList', self.Username) 
end
function Account:UnblockEveryone() 
    log("[UnblockEveryone] for", tostring(self.Username))
    return GET('UnblockEveryone', self.Username) 
end

function Account:GetAlias() return GET('GetAlias', self.Username) end
function Account:GetDescription() return GET('GetDescription', self.Username) end
function Account:SetAlias(Alias) 
    log("[SetAlias] for", tostring(self.Username), "AliasLen:", tostring(Alias and #tostring(Alias) or 0))
    return POST('SetAlias', self.Username, Alias) 
end
function Account:SetDescription(Description) 
    log("[SetDescription] for", tostring(self.Username), "DescLen:", tostring(Description and #tostring(Description) or 0))
    return POST('SetDescription', self.Username, Description) 
end
function Account:AppendDescription(Description) return POST('AppendDescription', self.Username, Description) end

function Account:GetField(Field) return GET('GetField', self.Username, 'Field=' .. HttpService:UrlEncode(Field)) end
function Account:SetField(Field, Value) return GET('SetField', self.Username, 'Field=' .. HttpService:UrlEncode(Field), 'Value=' .. HttpService:UrlEncode(tostring(Value))) end
function Account:RemoveField(Field) return GET('RemoveField', self.Username, 'Field=' .. HttpService:UrlEncode(Field)) end

function Account:SetServer(PlaceId, JobId) return GET('SetServer', self.Username, 'PlaceId=' .. PlaceId, 'JobId=' .. JobId) end
function Account:SetRecommendedServer(PlaceId) return GET('SetServer', self.Username, 'PlaceId=' .. PlaceId) end

function Account:ImportCookie(Token) 
    log("[ImportCookie] TokenLen:", tostring(Token and #tostring(Token) or 0))
    return GET('ImportCookie', 'Cookie=' .. Token) 
end
function Account:GetCookie() return GET('GetCookie', self.Username) end
function Account:LaunchAccount(PlaceId, JobId, FollowUser, JoinVip) -- if you want to follow someone, PlaceId must be their user id
    return GET('LaunchAccount', self.Username, 'PlaceId=' .. PlaceId, JobId and ('JobId=' .. JobId), FollowUser and 'FollowUser=true', JoinVip and 'JoinVIP=true')
end

return Account, WebserverSettings
