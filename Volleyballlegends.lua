--[[
    Скрипт для Volleyball Legends с интерфейсом Rayfield
    Вставь этот код в свой executor (Krnl, Synapse, etc.)
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Создание главного окна
local Window = Rayfield:CreateWindow({
    Name = "Volleyball Legends Hub",
    LoadingTitle = "Volleyball Legends",
    LoadingSubtitle = "by YourName",
    Theme = "Amethyst", -- Можно сменить на Default, Green, DarkBlue
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,

    ConfigurationSaving = {
        Enabled = true,
        FolderName = "VolleyballHub",
        FileName = "Settings"
    },

    KeySystem = false, -- Отключаем систему ключей для простоты
})

-- Создание вкладки "Фарм"
local FarmTab = Window:CreateTab("🏐 Фарм", 4483362458)
local FarmSection = FarmTab:CreateSection("Автоматизация")

-- Переменные для управления циклами
local AutoFarmEnabled = false
local AutoSpinEnabled = false
local AutoPlayEnabled = false

-- Функция для авто-фарма (пример)
local function startAutoFarm()
    while AutoFarmEnabled do
        task.wait(0.5)
        -- Здесь должна быть логика для авто-фарма
        -- Например, поиск мяча или взаимодействие с воротами
        print("[AutoFarm] Работает...")
        
        -- Пример поиска объектов (замени на актуальные для игры)
        local ball = workspace:FindFirstChild("Ball") -- Пример, нужно уточнить название
        if ball then
            -- Логика подхода к мячу
            local player = game.Players.LocalPlayer
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = ball.CFrame * CFrame.new(0, 0, -5)
            end
        end
    end
end

-- Кнопка для авто-фарма
local AutoFarmToggle = FarmTab:CreateToggle({
    Name = "Авто-фарм",
    CurrentValue = false,
    Flag = "AutoFarm",
    Callback = function(Value)
        AutoFarmEnabled = Value
        if Value then
            Rayfield:Notify({
                Title = "Фарм",
                Content = "Авто-фарм запущен",
                Duration = 3
            })
            coroutine.wrap(startAutoFarm)()
        else
            Rayfield:Notify({
                Title = "Фарм",
                Content = "Авто-фарм остановлен",
                Duration = 3
            })
        end
    end
})

-- Кнопка для авто-спина (круток)
local AutoSpinToggle = FarmTab:CreateToggle({
    Name = "Авто-спин (бесконечные крутки)",
    CurrentValue = false,
    Flag = "AutoSpin",
    Callback = function(Value)
        AutoSpinEnabled = Value
        if Value then
            Rayfield:Notify({
                Title = "Спин",
                Content = "Авто-спин активирован",
                Duration = 3
            })
            -- Здесь должен быть код для авто-спина
            -- Например, поиск кнопки "Spin" и её активация
        end
    end
})

-- Кнопка для авто-игры (AI)
local AutoPlayToggle = FarmTab:CreateToggle({
    Name = "Авто-игра (AI)",
    CurrentValue = false,
    Flag = "AutoPlay",
    Callback = function(Value)
        AutoPlayEnabled = Value
        if Value then
            Rayfield:Notify({
                Title = "AI",
                Content = "Авто-игра запущена",
                Duration = 3
            })
            -- Здесь должен быть более сложный AI для игры
        end
    end
})

-- Вкладка "Игрок"
local PlayerTab = Window:CreateTab("👤 Игрок", 4483362458)
local PlayerSection = PlayerTab:CreateSection("Настройки персонажа")

-- Слайдер для скорости
local WalkSpeedSlider = PlayerTab:CreateSlider({
    Name = "Скорость бега",
    Range = {16, 120},
    Increment = 1,
    Suffix = " Speed",
    CurrentValue = 16,
    Flag = "Walkspeed",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.WalkSpeed = Value
        end
    end
})

-- Слайдер для силы прыжка
local JumpPowerSlider = PlayerTab:CreateSlider({
    Name = "Сила прыжка",
    Range = {50, 200},
    Increment = 1,
    Suffix = " Power",
    CurrentValue = 50,
    Flag = "JumpPower",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.JumpPower = Value
        end
    end
})

-- Кнопка для бесконечного прыжка
local InfiniteJumpEnabled = false
local InfiniteJumpToggle = PlayerTab:CreateToggle({
    Name = "Бесконечный прыжок",
    CurrentValue = false,
    Flag = "InfiniteJump",
    Callback = function(Value)
        InfiniteJumpEnabled = Value
        if Value then
            Rayfield:Notify({
                Title = "Прыжок",
                Content = "Бесконечный прыжок активирован (нажимай пробел много раз)",
                Duration = 3
            })
            -- Логика бесконечного прыжка
            game:GetService("UserInputService").JumpRequest:Connect(function()
                if InfiniteJumpEnabled then
                    local player = game.Players.LocalPlayer
                    local character = player.Character
                    if character and character:FindFirstChild("Humanoid") then
                        character.Humanoid:ChangeState("Jumping")
                    end
                end
            end)
        end
    end
})

-- Вкладка "Телепорты"
local TeleportTab = Window:CreateTab("🌍 Телепорты", 4483362458)
local TeleportSection = TeleportTab:CreateSection("Быстрое перемещение")

-- Функция телепортации
local function teleportTo(position)
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

-- Кнопки телепортации (примеры, замени на актуальные координаты)
local TeleportToCourt = TeleportTab:CreateButton({
    Name = "На корт",
    Callback = function()
        teleportTo(Vector3.new(0, 10, 0)) -- Пример координат
    end
})

local TeleportToLobby = TeleportTab:CreateButton({
    Name = "В лобби",
    Callback = function()
        teleportTo(Vector3.new(50, 10, 50)) -- Пример координат
    end
})

-- Уведомление о загрузке
Rayfield:Notify({
    Title = "Volleyball Legends Hub",
    Content = "Скрипт успешно загружен!",
    Duration = 5,
})
