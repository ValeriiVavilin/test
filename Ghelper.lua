require "lib.moonloader" -- ����������� ����������
local dlstatus = require('moonloader').download_statuslocal 
local keys = require "vkeys"
local imgui = require 'imgui'
local encoding = require 'encoding'
local se = require 'lib.samp.events'
local ids = -1
encoding.default = 'CP1251'
u8 = encoding.UTF8

local tag = "[My First Script]:" -- ��������� ����������
local label = 0
local main_color = 0x5A90CE
local main_color_text = "{5A90CE}"
local white_color = "{FFFFFF}"
local arr_cheat = {"30 Aimbot", "30 WallHack", "10 Spread", "15 auto+c", "30 Saim", "30 DMG", "10 ews", "10 Provo na SK", "10 Fly", "20 AirBreak", "15 Flycar", "10 Speedhack"}

local main_window_state = imgui.ImBool(false)
local secondary_window_state = imgui.ImBool(false)

local text_buffer = imgui.ImBuffer(256)





-- ��������
    local checked_NakNumber        = imgui.ImInt(1)
--

-- �����������
    local checked_band        = imgui.ImInt(1)
    local checked_jail        = imgui.ImInt(1)
--

--����������
    local combo_select         =imgui.ImInt(0)
--

local sw, sh = getScreenResolution()

function SetStyle()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    imgui.GetStyle().WindowPadding = imgui.ImVec2(8, 8)
    imgui.GetStyle().WindowRounding = 0.5
    imgui.GetStyle().FramePadding = imgui.ImVec2(5, 3)
    imgui.GetStyle().ItemSpacing = imgui.ImVec2(4, 4)
    imgui.GetStyle().ItemInnerSpacing = imgui.ImVec2(5, 5)
    imgui.GetStyle().IndentSpacing = 9.0
    imgui.GetStyle().ScrollbarSize = 17.0
    imgui.GetStyle().ScrollbarRounding = 16.0
    imgui.GetStyle().GrabMinSize = 7.0
    imgui.GetStyle().GrabRounding = 15.0
    imgui.GetStyle().ChildWindowRounding = 10.0
    imgui.GetStyle().FrameRounding = 7.0

    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Button]                 = ImVec4(0.26, 0.59, 0.98, 0.40)
    colors[clr.ButtonHovered]          = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.06, 0.53, 0.98, 1.00)
    colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.16, 0.29, 0.48, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)-- (0.1, 0.9, 0.1, 1.0)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.FrameBg]                = ImVec4(0.16, 0.29, 0.48, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.59, 0.98, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CheckMark]              = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.Header]                 = ImVec4(0.26, 0.59, 0.98, 0.31)
    colors[clr.HeaderHovered]          = ImVec4(0.26, 0.59, 0.98, 0.80)
    colors[clr.HeaderActive]           = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.24, 0.52, 0.88, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.59, 0.98, 1.00)
end
SetStyle()

function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end

    sampRegisterChatCommand("update", cmd_update)
    sampRegisterChatCommand("imgui", cmd_imgui)
    sampRegisterChatCommand("imgui2", cmd_imgui2)
    sampRegisterChatCommand("1", cmd_1)
	sampRegisterChatCommand("2", cmd_2)
	sampRegisterChatCommand("3", cmd_3)
	sampRegisterChatCommand("clans", cmd_clans)
    sampRegisterChatCommand("grul", cmd_grul)
    sampRegisterChatCommand('testo222', cmd_testo222)
    autoupdate("https://raw.githubusercontent.com/ValeriiVavilin/test/main/update.json", '['..string.upper(thisScript().name)..']: ', "http://vk.com/alkoigel")
    thread = lua_thread.create_suspended(thread_ghetto)

    _, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
    nick = sampGetPlayerNickname(rid)

    imgui.Process = false
    --sampAddChatMessage("������ imgui ������������", -1)

    while true do
        wait(0)

        if isKeyJustPressed(VK_F3) then
            cmd_imgui()
        end
        if isKeyJustPressed(VK_F4) then
            cmd_imgui2()
        end

        if main_window_state.v == false then
            imgui.Process = false
        end
        -- ���� ������������� ���������� (���� ���� �������)

    end
end

function cmd_testo222(arg)
    sampAddChatMessage("����������", -1)
end
function se.onTogglePlayerSpectating(state)
    if state then
        specc = true
    else
        specc = false
    end
end

function se.onSpectatePlayer(id, type)
    if specc then
        ids = id
    end
end

function cmd_imgui(arg)
    main_window_state.v = not main_window_state.v
    imgui.Process = main_window_state.v
end

function cmd_imgui2(arg)
	secondary_window_state.v = not secondary_window_state.v
	imgui.Process = secondary_window_state.v
end

function imgui.OnDrawFrame()
    imgui.SwitchContext()
    local colors = imgui.GetStyle().Colors;
    local icol = imgui.Col
    local ImVec4 = imgui.ImVec4

    imgui.GetStyle().WindowPadding = imgui.ImVec2(10, 10)
    imgui.GetStyle().WindowRounding = 10.0
    imgui.GetStyle().FramePadding = imgui.ImVec2(5, 4)
    imgui.GetStyle().ItemSpacing = imgui.ImVec2(4, 4)
    imgui.GetStyle().ItemInnerSpacing = imgui.ImVec2(5, 5)
    imgui.GetStyle().IndentSpacing = 9.0
    imgui.GetStyle().ScrollbarSize = 17.0
    imgui.GetStyle().ScrollbarRounding = 20.0
    imgui.GetStyle().GrabMinSize = 7.0
    imgui.GetStyle().GrabRounding = 20.0
    imgui.GetStyle().ChildWindowRounding = 6.0
    imgui.GetStyle().FrameRounding = 20.0

    colors[icol.Text]                   = ImVec4(0.11, 0.11, 0.11, 1.00);
    colors[icol.TextDisabled]           = ImVec4(0.60, 0.60, 0.60, 1.00);
    colors[icol.WindowBg]               = ImVec4(0.90, 0.90, 0.90, 1.00);
    colors[icol.ChildWindowBg]          = ImVec4(0.13, 0.13, 0.13, 1.00);
    colors[icol.PopupBg]                = ImVec4(0.26, 0.46, 0.82, 1.00);
    colors[icol.Border]                 = ImVec4(0.26, 0.46, 0.82, 1.00);
    colors[icol.BorderShadow]           = ImVec4(0.26, 0.46, 0.82, 1.00);
    colors[icol.FrameBg]                = ImVec4(0.26, 0.46, 0.82, 0.59);
    colors[icol.FrameBgHovered]         = ImVec4(0.26, 0.46, 0.82, 0.88);
    colors[icol.FrameBgActive]          = ImVec4(0.28, 0.53, 1.00, 1.00);
    colors[icol.TitleBg]                = ImVec4(0.26, 0.46, 0.82, 1.00);
    colors[icol.TitleBgActive]          = ImVec4(0.26, 0.46, 0.82, 1.00);
    colors[icol.TitleBgCollapsed]       = ImVec4(0.26, 0.46, 0.82, 1.00);
    colors[icol.MenuBarBg]              = ImVec4(0.26, 0.46, 0.82, 0.75);
    colors[icol.ScrollbarBg]            = ImVec4(0.11, 0.11, 0.11, 1.00);
    colors[icol.ScrollbarGrab]          = ImVec4(0.26, 0.46, 0.82, 0.68);
    colors[icol.ScrollbarGrabHovered]   = ImVec4(0.26, 0.46, 0.82, 1.00);
    colors[icol.ScrollbarGrabActive]    = ImVec4(0.26, 0.46, 0.82, 1.00);
    colors[icol.ComboBg]                = ImVec4(0.26, 0.46, 0.82, 0.79);
    colors[icol.CheckMark]              = ImVec4(0.000, 0.000, 0.000, 1.000)
    colors[icol.SliderGrab]             = ImVec4(0.263, 0.459, 0.824, 1.000)
    colors[icol.SliderGrabActive]       = ImVec4(0.20, 0.20, 0.20, 1.00);
    colors[icol.Button]                 = ImVec4(0.26, 0.46, 0.82, 1.00);
    colors[icol.ButtonHovered]          = ImVec4(0.26, 0.46, 0.82, 0.59);
    colors[icol.ButtonActive]           = ImVec4(0.26, 0.46, 0.82, 1.00);
    colors[icol.Header]                 = ImVec4(0.26, 0.46, 0.82, 1.00);
    colors[icol.HeaderHovered]          = ImVec4(0.26, 0.46, 0.82, 0.74);
    colors[icol.HeaderActive]           = ImVec4(0.26, 0.46, 0.82, 1.00);
    colors[icol.Separator]              = ImVec4(0.37, 0.37, 0.37, 1.00);
    colors[icol.SeparatorHovered]       = ImVec4(0.60, 0.60, 0.70, 1.00);
    colors[icol.SeparatorActive]        = ImVec4(0.70, 0.70, 0.90, 1.00);
    colors[icol.ResizeGrip]             = ImVec4(1.00, 1.00, 1.00, 0.30);
    colors[icol.ResizeGripHovered]      = ImVec4(1.00, 1.00, 1.00, 0.60);
    colors[icol.ResizeGripActive]       = ImVec4(1.00, 1.00, 1.00, 0.90);
    colors[icol.CloseButton]            = ImVec4(0.90, 0.90, 0.90, 1.00);
    colors[icol.CloseButtonHovered]     = ImVec4(0.50, 0.50, 0.50, 0.60);
    colors[icol.CloseButtonActive]      = ImVec4(0.35, 0.35, 0.35, 1.00);
    colors[icol.PlotLines]              = ImVec4(1.00, 1.00, 1.00, 1.00);
    colors[icol.PlotLinesHovered]       = ImVec4(0.90, 0.70, 0.00, 1.00);
    colors[icol.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00);
    colors[icol.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00);
    colors[icol.TextSelectedBg]         = ImVec4(0.00, 0.00, 1.00, 0.35);
    colors[icol.ModalWindowDarkening]   = ImVec4(0.20, 0.20, 0.20, 0.35);
    if not main_window_state.v and not secondary_window_state.v then
		imgui.Process = false
	end
    
    if main_window_state.v then
        imgui.SetNextWindowSize(imgui.ImVec2(500, 320), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowPos(imgui.ImVec2((sw / 2), sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))

        imgui.Begin("Ghetto Helper", main_window_state) -- �������� ����

        imgui.RadioButton(u8"����", checked_band, 2)            -- �������� �����, ����������,
        imgui.SameLine()
        imgui.RadioButton(u8"������", checked_band, 3)            -- �������� �����, ����������,
        imgui.SameLine()
        imgui.RadioButton(u8"�����", checked_band, 4)            -- �������� �����, ����������,
        imgui.SameLine()
        imgui.RadioButton(u8"�����", checked_band, 5)            -- �������� �����, ����������,

        imgui.Separator()

        imgui.RadioButton(u8"��������� 1/3", checked_NakNumber, 2)            -- �������� ��������, ����������.
        imgui.RadioButton(u8"��������� 2/3", checked_NakNumber, 3)            -- �������� ��������, ����������.
        imgui.RadioButton(u8"��������� 3/3", checked_NakNumber, 4)            -- �������� ��������, ����������.

        imgui.Separator()

        imgui.RadioButton(u8"Jail", checked_jail, 2)            -- �������� ��������, ����������.
        imgui.RadioButton(u8"Ban", checked_jail, 4)


        imgui.Combo(u8"�������", combo_select, arr_cheat, #arr_cheat)




        if imgui.Button(u8"��������!") then
            if checked_jail.v == 2 then
                if checked_NakNumber.v == 2 then
                    nakaz = "[1/3]"
                elseif checked_NakNumber.v == 3 then
                    nakaz = "[2/3]"
                elseif checked_NakNumber.v == 4 then
                    nakaz = "[3/3]"
                end
                if checked_band.v == 2 then
                    band = "����"
                elseif checked_band.v == 3 then
                    band = "������"
                elseif checked_band.v == 4 then
                    band = "�����"
                elseif checked_band.v == 5 then
                    band = "�����"
                end

                sampSendChat("/jail " .. ids .. " " .. arr_cheat[combo_select.v + 1] .. " " .. band .. " " .. nakaz)
            else
                if checked_NakNumber.v == 2 then
                    nakaz = "[1/3]"
                elseif checked_NakNumber.v == 3 then
                    nakaz = "[2/3]"
                elseif checked_NakNumber.v == 4 then
                    nakaz = "[3/3]"
                end
                if checked_band.v == 2 then
                    band = "����"
                elseif checked_band.v == 3 then
                    band = "������"
                elseif checked_band.v == 4 then
                    band = "�����"
                elseif checked_band.v == 5 then
                    band = "�����"
                end
                sampSendChat("/cban " .. ids .. " " .. arr_cheat[combo_select.v + 1] .. " " .. band .. " " .. nakaz)
            end
        end
    end
    imgui.End()

    if secondary_window_state.v then
		imgui.Begin(u8"���� ����������", secondary_window_state)
		if imgui.Button(u8"������� �����") then
            cmd_grul()
        end
        if imgui.Button(u8"���������� � �������� ������") then
            cmd_clans()
        end
        if imgui.Button(u8"������ �������") then
            cmd_1()
        end
        if imgui.Button(u8"���������� �������") then
            cmd_2()
        end
        if imgui.Button(u8"��������� �������") then
            cmd_3()
        end
		imgui.End()
	end
end


function cmd_grul(arg)
	thread:run("grul")
end

function cmd_1(arg)
	thread:run("1")
end

function cmd_2(arg)
	thread:run("2")
end

function cmd_3(arg)
	thread:run("3")
end

function cmd_clans(arg)
	thread:run("clans")
end

function thread_ghetto(option)
	if option == "grul" then
		sampSendChat("/msg ��������� ������, ��� ���� ��������� �� ������, ��������� ������ � ������ � ����� [GW].")
		wait(3000)
		sampSendChat("/msg ��� �� �� ��������� �������: �� ��������� ������ � 0:59. ����� �� ���������� ��� ��������.")
		wait(3000)
		sampSendChat("/msg ����� �� ������ �� ����� � �������� � �����, ��������������, ��� ���������� �� ��")
		wait(3000)
		sampSendChat("/msg �� ������ � ������� [�� � �����] ���� ���� [���� �����-���� ��� �� Gang War]")
	end
	if option == "1" then
		sampSendChat("/a ������� ������� �� �����")
		wait (1000)
		sampSendChat("/time")
	end
	if option == "2" then
		sampSendChat("/a ��������� ������� �� �����")
		wait (1000)
		sampSendChat("/time")
	end
	if option == "3" then
		sampSendChat("/a ���������� ������� �� �����")
		wait (1000)
		sampSendChat("/time")
	end
	if option == "clans" then
		sampSendChat("/msg ������ ������� ���� ���� � ����� ����� ������ ������������ �� �������?")
		wait(3000)
		sampSendChat("/msg ��� �������� ���������� �� ������, �� ������ �� ������ � ��������������� �������.")
	end
end
--[[
--
--     _   _   _ _____ ___  _   _ ____  ____    _  _____ _____   ______   __   ___  ____  _     _  __
--    / \ | | | |_   _/ _ \| | | |  _ \|  _ \  / \|_   _| ____| | __)\ \ / /  / _ \|  _ \| |   | |/ /
--   / _ \| | | | | || | | | | | | |_) | | | |/ _ \ | | |  _|   |  _  \\ V /  | | | | |_) | |   | ' / 
--  / ___ \ |_| | | || |_| | |_| |  __/| |_| / ___ \| | | |___  | |_) || |/  | |_| |  _ <| |___| . \ 
-- /_/   \_\___/  |_| \___/ \___/|_|   |____/_/   \_\_| |_____| |____/ |_|    \__\_\_| \_\_____|_|\_\                                                                                                                                                                                                                    
--
-- Author: http://qrlk.me/samp
--]]

function autoupdate(json_url, prefix, url)
    local dlstatus = require('moonloader').download_status
    local json = getWorkingDirectory() .. '\\'..thisScript().name..'-version.json'
    if doesFileExist(json) then os.remove(json) end
    downloadUrlToFile(json_url, json,
      function(id, status, p1, p2)
        if status == dlstatus.STATUSEX_ENDDOWNLOAD then
          if doesFileExist(json) then
            local f = io.open(json, 'r')
            if f then
              local info = decodeJson(f:read('*a'))
              updatelink = info.updateurl
              updateversion = info.latest
              f:close()
              os.remove(json)
              if updateversion ~= thisScript().version then
                lua_thread.create(function(prefix)
                  local dlstatus = require('moonloader').download_status
                  local color = -1
                  sampAddChatMessage(('[Ghelper]{FFFFFF} �������� ����� ����������! ������� ���������� c '..thisScript().version..' �� '..updateversion), 0x046D63)
                  wait(250)
                  downloadUrlToFile(updatelink, thisScript().path,
                    function(id3, status1, p13, p23)
                      if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                      elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
                        sampAddChatMessage(('[Ghelper]{FFFFFF} ������ ������� �������.'), 0x046D63)
                        sampAddChatMessage(('[Ghelper]{FFFFFF} ������������ �� ����� ������������ �� ������� �� ������� /upds.'), 0x046D63)
                        goupdatestatus = true
                        lua_thread.create(function() wait(500) thisScript():reload() end)
                      end
                      if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                        if goupdatestatus == nil then
                          sampAddChatMessage(('[Ghelper]{FFFFFF} �� ������� �������� ������! ���������� ������ ������ � �� 01.'), 0x046D63)
                          update = false
                        end
                      end
                    end
                  )
                  end, prefix
                )
              else
                update = false
              end
            end
          else
            update = false
          end
        end
      end
    )
    while update ~= false do wait(100) end
end