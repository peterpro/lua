-- lua5.3 synthetic_trigger.lua

-- На уровне фреймворка данная переменная инициализируется при создании события
-- в данном примере инициализируется для работоспособности кода
event = {name = "Event", message = 1, meta = {}}

-- На уровне фреймворка данный объект является cистемным (создаётся в рамках работы триггера)
-- в данном примере инициализируется для работоспособности кода
trigger = {id = 777, title = "Custom trigger #3", meta = "Some info about trigger", status = 0}

function trigger.fire (status)
    trigger.status = status;
end

function trigger.calm ()
    trigger.status = 0;
end

-- На уровне фреймворка данный метод служит для вызова пользовательских скриптов
-- в данном примере инициализируется для работоспособности кода
function userAction(id, params)
    -- в фреймворке здесь содержится код, который загружает пользовательский скрипт из библиотеки
    print(id, params.id, params.status)
end

-----------------------------------------------
-- Пользовательский код синтетического триггера

if(event.message ~= 0 and trigger.status == 0) then
    trigger.fire(event.message);
    userAction('triggerActivated', {id = trigger.id, status = event.message})
    print("Trigger is firing!");
elseif (event.message == 0 and trigger.status ~= 0)  then
    trigger.calm();
    userAction('triggerDeactivated', {id = trigger.id, status = event.message})
    print("Trigger just stopped.");
elseif (event.message ~= 0 and trigger.status ~= 0 and event.message ~= trigger.status) then
    if(event.meta.source == 'Zabbix') then
        userAction('someCustomZabbixAction', {id = trigger.id, status = event.message})
    else
        print("Status just changed");
    end
else
    print("Event didnt changed trigger status");
end