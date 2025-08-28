--// Note: This is WindUI, not a custom gui library by phantom flux.

local Library = {}
Library.__index = Library
Library.Core = loadstring(game:HttpGet("https://raw.githubusercontent.com/RealVitorzz07/VoltzHub/refs/heads/main/Main.lua"))()

local MainWindow = nil

-- Função de notificação padrão (caso WindUI não disponibilize)
function Library:Notify(opts)
    if self.Core.Notify then
        self.Core:Notify(opts)
    else
        print(("[Library Notify] %s: %s"):format(opts.Title or "Info", opts.Content or ""))
    end
end

function Library:Setup()
    local version = LRM_ScriptVersion and "v" .. table.concat(LRM_ScriptVersion:split(""), ".") or "Dev Version"

    MainWindow = Library.Core:CreateWindow({
        Title = "Voltz Hub",
        Icon = "star", -- ícone seguro
        Author = (premium and "FreePremium" or "Cultive um Graden") .. " | " .. version,
        Folder = "VoltzHub",
        Size = UDim2.fromOffset(580, 460),
        Transparent = true,
        Theme = "Orange",
        Resizable = true,
        SideBarWidth = 200,
        Background = nil, -- evita string vazia
        BackgroundImageTransparency = 0.42,
        HideSearchBar = true,
        ScrollBarEnabled = false,
        User = {
            Enabled = true,
            Anonymous = false,
            Callback = function()
                print("User icon clicked")
            end,
        },
    })

    return MainWindow
end

function Library:GetWindow()
    if not MainWindow then
        return self:Setup()
    end
    return MainWindow
end

function Library:CreateTab(Name, Icon)
    local window = self:GetWindow()
    return window:Tab({
        Title = Name,
        Icon = Icon,
        Locked = false,
    })
end

function Library:CreateSection(Tab, Title, Size)
    return Tab:Section({
        Title = Title,
        TextXAlignment = "Left",
        TextSize = Size or 17,
    })
end

function Library:CreateToggle(Tab, opts) return Tab:Toggle(opts) end
function Library:CreateButton(Tab, opts) return Tab:Button(opts) end
function Library:CreateSlider(Tab, opts) return Tab:Slider(opts) end
function Library:CreateDropdown(Tab, opts) return Tab:Dropdown(opts) end
function Library:CreateInput(Tab, opts) return Tab:Input(opts) end

-- Setup da seção “About Us”
function Library:SetupAboutUs(AboutUsSection)
    local window = self:GetWindow()

    AboutUsSection:Paragraph({
        Title = "Discord Convites",
        Icon = "discord",
        Desc = "Junte-se às nossas comunidades para atualizações e suporte!",
    })

    AboutUsSection:Button({
        Title = "Link do Discord (clique para copiar)",
        Icon = "link",
        Callback = function()
            setclipboard("https://discord.gg/ujHdTKgZ")
            Library:Notify({ Title = "Copiado!", Content = "Link do Discord copiado!", Duration = 3 })
        end,
    })
end

return Library
