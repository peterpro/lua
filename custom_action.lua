-- lua5.3 custom_action.lua

-- СЕКЦИЯ КОДА, КОТОРЫЙ ВКЛЮЧЁН НА УРОВНЕ ФРЕЙМВОРКА
-- В ДАННОМ ПРИМЕРЕ ПРИВЕДЕН ДЛЯ РАБОТОСПОСОБНОСТИ

local http = require("socket.http")
local ltn12 = require("ltn12")

-- На уровне фреймворка данная переменная инициализируется при создании события
-- в данном примере инициализируется для работоспособности кода
event = {name = "Issue", message = "Issue created"}

-- На уровне фреймворка данная переменная является внешней (задаваемой пользователем в интерфейсе)
-- в данном примере инициализируется для работоспособности кода
secretToken = 'cX6uXF9kVDd_.H/B-very-secret'

-----------------------
-- Пользовательский код

function sendReport(name, message, token)
    -- роут SMS-гейта заменён на mock-server
    local path = "https://jsonplaceholder.typicode.com/posts"
    local payload =  '{"title": "' .. name .. '","body":"' .. message .. '"}'
    local response_body = { }

    local res, code, response_headers, status = http.request
    {
        url = path,
        method = "POST",
        headers =
        {
            ["Authorization"] = token,
            ["Content-Type"] = "application/json",
            ["Content-Length"] = payload:len()
        },
        source = ltn12.source.string(payload),
        sink = ltn12.sink.table(response_body)
    }
    print(table.concat(response_body));
end

sendReport(event.name, event.message, secretToken);