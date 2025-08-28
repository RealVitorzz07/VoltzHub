--// Note: This is WindUI, not a custom gui library by phantom flux.

local Library = {}
Library.__index = Library
Library.Core = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local MainWindow = nil -- Mantém a janela principal

function Library:Setup()
	local version = LRM_ScriptVersion and "v" .. table.concat(LRM_ScriptVersion:split(""), ".") or "Dev Version"

	MainWindow = Library.Core:CreateWindow({
		Title = "Voltz Hub",
		Icon = "🔥",
		Author = (premium and "FreePremium" or "Cultive um Graden") .. " | " .. version,
		Folder = "VoltzHub",
		Size = UDim2.fromOffset(580, 460),
		Transparent = true,
		Theme = "Dark",
		Resizable = true,
		SideBarWidth = 200,
		Background = "",
		BackgroundImageTransparency = 0.42,
		HideSearchBar = true,
		ScrollBarEnabled = false,
		User = {
			Enabled = true,
			Anonymous = false,
			Callback = function()
				print("clicked")
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
	local Window = self:GetWindow()

	return Window:Tab({
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

function Library:CreateToggle(Tab, Table)
	return Tab:Toggle(Table)
end

function Library:CreateButton(Tab, Table)
	return Tab:Button(Table)
end

function Library:CreateSlider(Tab, Table)
	return Tab:Slider(Table)
end

function Library:CreateDropdown(Tab, Table)
	return Tab:Dropdown(Table)
end

function Library:CreateInput(Tab, Table)
	return Tab:Input(Table)
end

--// Special Setups
function Library:SetupAboutUs(AboutUs)
	local Window = self:GetWindow()

	-- Exemplo de parágrafo comentado
	-- AboutUs:Paragraph({
	-- 	Title = "Quem somos nós?",
	-- 	Icon = "user-circle",
	-- 	Desc = "Voltz é um hub de script flexível e poderoso para Roblox, projetado para aprimorar sua experiência de jogo com uma variedade de recursos e ferramentas.",
	-- })

	AboutUs:Paragraph({
		Title = "Discord Convites",
		Icon = "discord",
		Desc = "Junte-se às nossas comunidades para atualizações e suporte!",
	})

	AboutUs:Button({
		Title = "Link do Discord (clique para copiar)",
		Icon = "link",
		Callback = function()
			setclipboard("https://discord.gg/ujHdTKgZ")
			if Library.Notify then
				Library:Notify({ Title = "Copiado!", Content = "Link do Discord copiado!", Duration = 3 })
			else
				print("[Library]: Copiado para a área de transferência!")
			end
		end,
	})
end

return Library
