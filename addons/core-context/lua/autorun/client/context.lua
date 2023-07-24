Team = Team or {}

local pos_x, pos_y
-- print ()
 
function ContextOpen()
        LocalPlayer():ConCommand ("open_context_menu")
        pos_x, pos_y = GetGlobalInt("XContext") or 494, GetGlobalInt("YContext") or 1460
end
hook.Add ("OnContextMenuOpen", "Context", ContextOpen)
 
function closecontext ()
        if loz then
            loz:Remove()
        end
end
hook.Add ("OnContextMenuClose", "Context", closecontext)
 
function draw_textbox(strTitle, strBtn, strDefaultText, fnEnter)
        local Window = vgui.Create ("DFrame")
        Window:SetTitle (strTitle)
        Window:ShowCloseButton(true)
        Window:MakePopup()
        Window:SetSize (250, 100)
        Window:Center()
        Window:SetKeyboardInputEnabled(true)
        Window:SetMouseInputEnabled(true)
        Window.Paint = function()
                draw.RoundedBox ( 0, 0, 0, Window:GetWide(), Window:GetTall(), Color(0,0,0,255) )
                draw.RoundedBox ( 0, 1, 1, Window:GetWide()-2, Window:GetTall()-2, Color(255,255,255,100) )
        end
 
        local TextEntr = vgui.Create( "DTextEntry", Window)
        TextEntr:SetPos (75, 25)
        TextEntr:SetSize (110, 20)
        TextEntr:SetMultiline (false)
        TextEntr:SetAllowNonAsciiCharacters( true )
        TextEntr:SetText(strDefaultText || "")
        TextEntr:SetEnterAllowed (true)
 
        local Btn = vgui.Create ("DButton", Window)
        Btn:SetText(strBtn)
        Btn:SetSize (110, 20)
        Btn:SetPos (75, 50)
        Btn.DoClick = function ()
                fnEnter( TextEntr:GetValue() )
                Window:Remove()
        end
end
 
function OpenContextMenu(ply, argm, cmd)
        local context = DermaMenu()
        local demotemenu, edited = context:AddSubMenu("Оружие")
        edited:SetImage ("icon16/gun.png")
        demotemenu:AddOption( "Бросить оружие", function() 

            if LocalPlayer():GetActiveWeapon():GetClass() == "weapon_doorlocker" then return end
            if LocalPlayer():GetActiveWeapon():GetClass() == "mcr_hands" then return end
            RunConsoleCommand ("say", "/drop") 
        
        
        end ):SetImage("icon16/gun.png")

        local wep = LocalPlayer():GetActiveWeapon()
        local child_checkammo
        
        
        demotemenu:AddOption( "Проверить оружие", function() 
            RunConsoleCommand('say', '/me проверяет магазин.')
            timer.Simple(3, function()
                wep = LocalPlayer():GetActiveWeapon()

                if wep then
                    chat.AddText(Color( 224, 72, 56 ), '[Уведомление] ', Color(231, 231, 231),'У вас в магазине осталось: ' .. wep:Clip1() .. ', в запасе: ' .. wep:Ammo1() .. '.', 0)
                end
            end )
        end ):SetImage("icon16/zoom.png")


        context:AddOption( "Узнать время", function() chat.AddText(Color(241, 171, 60), 'Время на данный момент: ', Color(221, 221, 221), os.date('%X')) end ):SetIcon('icon16/clock.png')
        context:AddSpacer()
    
        local demotemenu, edited = context:AddSubMenu("Рация")
                edited:SetImage ("icon16/lightbulb.png")
     if LocalPlayer():HaveEnabledRadio() then
        context:AddOption('Выключить рацию', function()
            net.Start('radio-setEnabled')
                net.WriteBool(false)
            net.SendToServer()
        end):SetIcon('icon16/bullet_delete.png')
    else
        context:AddOption('Включить рацию', function()
            net.Start('radio-setEnabled')
                net.WriteBool(true)
            net.SendToServer()
        end):SetIcon('icon16/bullet_add.png')
    end

                
                demotemenu:AddOption ("Бежать быстро", function () RunConsoleCommand ("alternate_sprint_anim", "1") end ):SetImage("icon16/tag_green.png")


        context:AddOption( "Вызвать военную полицию", function() 
        draw_textbox("Вызвать ВП", "Вызвать", "Место", function(d) 
        RunConsoleCommand ("say", "/r [ВП] Просьба сотрудников ВП прибыть в " ..tostring(d) ) end)
                 
        end):SetImage("icon16/shield.png")
    if LocalPlayer():Team() != TEAM_CADET then
        context:AddOption ("Сбор на плацу", function ()
                 draw_textbox("Объявить сбор", "Объявить", "Подразделения", function(b) RunConsoleCommand ("say", "/r [Хмеймим] Объявлен сбор на плацу. Требуемые подразделения - " ..tostring(b) ) end) end):SetImage("icon16/page_edit.png")
        end
    if LocalPlayer():Team() != TEAM_CADET then
        context:AddSpacer()
    local demotemenu, edited = context:AddSubMenu("Документы")
    
                edited:SetImage ("icon16/transmit_edit.png")
                demotemenu:AddOption("Показать документы", function() RunConsoleCommand ("showdoc") end):SetImage("icon16/comment.png")
        end
        context:AddSpacer()
        local demotemenu, edited = context:AddSubMenu("Машина")
                edited:SetImage ("icon16/car.png")
                demotemenu:AddOption ("Включить радио", function ()
                end):SetImage("icon16/user_delete.png")
    demotemenu:AddOption ("Заспавнить машину", function ()
            RunConsoleCommand("mcrveh")
                end):SetImage("icon16/car.png")
    
        context:AddSpacer()
        local demotemenu, edited = context:AddSubMenu("Вероятность")
        edited:SetImage ("icon16/color_swatch.png")
        demotemenu:AddOption( "Кинуть кубик", function() RunConsoleCommand ("say", "/roll ") end ):SetImage("icon16/rainbow.png")
        local demotemenu, edited = context:AddSubMenu("Жесты")
                edited:SetImage ("icon16/lightbulb.png")
                demotemenu:AddOption ("Позвать к себе", function () RunConsoleCommand ("act", "becon") end ):SetImage("icon16/tag_blue.png")
                demotemenu:AddOption ("Указать на", function () RunConsoleCommand ("act", "forward") end ):SetImage("icon16/tag_red.png")
                demotemenu:AddOption ("Приветствие", function () RunConsoleCommand ("act", "halt") end ):SetImage("icon16/tag_green.png")
                demotemenu:AddOption ("Приклониться", function () RunConsoleCommand ("alternate_crouch_anim", "1") end ):SetImage("icon16/tag_green.png")
                demotemenu:AddOption ("Бежать быстро", function () RunConsoleCommand ("alternate_sprint_anim", "1") end ):SetImage("icon16/tag_green.png")
                demotemenu:AddOption( "Сдаться", function() 
                    net.Start("Surrend")
                    net.SendToServer() 
            end):SetImage("icon16/tag_green.png")

            demotemenu:AddOption( "Остановиться", function() 
                net.Start("STOP")
                net.SendToServer() 
        end):SetImage("icon16/tag_green.png")

        demotemenu:AddOption( "Остановиться", function() 
            net.Start("STOP")
            ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_AGREE, true)
        end):SetImage("icon16/tag_green.png")


        local demotemenu, edited = context:AddSubMenu("Неролевые действия")
                edited:SetImage ("icon16/world.png")
                demotemenu:AddOption("Изменить РП имя", function()
                draw_textbox("Изменить РП имя", "Изменить", "", function(a) RunConsoleCommand ("say", "/name "..tostring(a)) end)
        end):SetImage("icon16/page_edit.png")
        local demotemenu, edited = demotemenu:AddSubMenu("Ссылки")
        edited:SetImage ("icon16/link.png")
        demotemenu:AddOption( "Wiki", function() gui.OpenURL('http://mcr-rp.ru/ru') end ):SetImage("icon16/book_add.png")
        demotemenu:AddOption( "Discord", function() gui.OpenURL('https://discord.com/invite/ZuxutAeM6H') end ):SetImage("icon16/book_delete.png")
        demotemenu:AddOption( "Vk", function() gui.OpenURL('https://vk.com/mcr_gmod') end ):SetImage("icon16/book_error.png")
        context:Open()
        context:CenterHorizontal()
        context.y = 500
        context.x = 10
    if LocalPlayer():Team() == TEAM_VVS1 then
        local demotemenu, edited = context:AddSubMenu("ВКС")
                edited:SetImage ("icon16/joystick.png")
        demotemenu:AddOption ("MAYDAY", function () 
                RunConsoleCommand ("maydaya" ) 

            
            end ):SetImage("icon16/stop.png")
        demotemenu:AddOption ("Запрос на частоту", function () RunConsoleCommand ("say", "/r [ВКС-ШТАБ] Ожидаем на ВКС-СВЯЗЬ!" ) end ):SetImage("icon16/error.png")
        demotemenu:AddOption ("Запрос Взлета", function () 
        draw_textbox("Борт", "Запросить", "", function(k) 
        draw_textbox("Причина", "Запросить", "", function(l) 
        RunConsoleCommand ("say", "/r [ВКС-УВД/ШТАБ] Борт " ..tostring(k).. " запрашивает взлет.Причина - " ..tostring(l) ) end) end) end):SetImage("icon16/accept.png")
        
                       
        end
    if LocalPlayer():Team() == TEAM_VVS then
        local demotemenu, edited = context:AddSubMenu("ВКС")
                edited:SetImage ("icon16/joystick.png")
        demotemenu:AddOption ("MAYDAY", function () RunConsoleCommand ("maydaya" ) end ):SetImage("icon16/stop.png")
        demotemenu:AddOption ("Запрос на частоту", function () RunConsoleCommand ("say", "/r [ВКС-ШТАБ] Ожидаем на ВКС-СВЯЗЬ!" ) end ):SetImage("icon16/error.png")
        demotemenu:AddOption ("Запрос Взлета", function () 
        draw_textbox("Борт", "Запросить", "", function(k) 
        draw_textbox("Причина", "Запросить", "", function(l) 
        RunConsoleCommand ("say", "/r [ВКС-ШТАБ] Борт " ..tostring(k).. " запрашивает взлет.Причина - " ..tostring(l) ) end) end) end):SetImage("icon16/accept.png")        
        end
    if LocalPlayer():Team() == TEAM_VVS2 then
        local demotemenu, edited = context:AddSubMenu("ВКС")
                edited:SetImage ("icon16/joystick.png")
        demotemenu:AddOption ("MAYDAY", function () RunConsoleCommand ("maydaya" ) end ):SetImage("icon16/stop.png")
        demotemenu:AddOption ("Запрос на частоту", function () RunConsoleCommand ("say", "/r [ВКС-ШТАБ] Ожидаем на ВКС-СВЯЗЬ!" ) end ):SetImage("icon16/error.png")
        demotemenu:AddOption ("Запрос Взлета", function () 
        draw_textbox("Борт", "Запросить", "", function(k) 
        draw_textbox("Причина", "Запросить", "", function(l) 
        RunConsoleCommand ("say", "/r [ВКС-ШТАБ] Борт " ..tostring(k).. " запрашивает взлет.Причина - " ..tostring(l) ) end) end) end):SetImage("icon16/accept.png")
        demotemenu:AddOption("Запрос местоположения", function()
                                        local dist2 = 200
                        if LocalPlayer():GetPos():Distance( Vector( -1814.075928, -1486.222656, -1358.874023)) < dist2 then
          RunConsoleCommand ("say", "/r [ВКС - БОРТ] Запрашиваю местоположение по приборам")

          --RunConsoleCommand("sg", "respawn_G", ply:SteamID())
         
    hook.Add("HUDPaint", "VKSMetka", function()
        local scrw, scrh = ScrW(), ScrH()
        for k,v in pairs(player.GetAll()) do
            if v == LocalPlayer() then continue end
            local pos = v:GetPos()
                            if v:Team() == TEAM_VVS then
           if v:InVehicle() then
                pos = pos:ToScreen()
                                    
               surface.SetDrawColor( 255, 255, 255, 255 ) -- Set the drawing color
              surface.SetMaterial( Material("icon16/stop.png") ) -- Use our cached material
              surface.DrawTexturedRect( pos.x - 15 , pos.y - 32, 30, 30 ) -- Actually draw the rectangle
                                    
               draw.SimpleText("ЛЕТЧИК", Trebuchet24, pos.x, pos.y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

         end
                                
       end
                            end
  end)
 timer.Simple(10, function() hook.Remove("HUDPaint", "VKSMetka") end)    
                    else 
                        chat.AddText( Color( 255, 0, 0 ), "| Ты должен быть на вышке!! ")
                    end
            end):SetImage("icon16/stop.png")
        
        end
        if LocalPlayer():Team() == TEAM_VP1 then
        local demotemenu, edited = context:AddSubMenu("Служебное")
                edited:SetImage ("icon16/shield.png")
        demotemenu:AddOption("ВП-ТАК", function() RunConsoleCommand ("say", "/changeradiochannel 13.4") end):SetImage("icon16/comment.png")
        
        
        end
    if LocalPlayer():Team() == TEAM_VP3 then
        local demotemenu, edited = context:AddSubMenu("ВП")
                edited:SetImage ("icon16/shield.png")
        demotemenu:AddOption("ВП-ТАК", function() RunConsoleCommand ("say", "/changeradiochannel 13.4") end):SetImage("icon16/comment.png")
        
        
        end
    
    if LocalPlayer():Team() == TEAM_SHTAB1 then
        local demotemenu, edited = context:AddSubMenu("ШТАБ")
        edited:SetImage ("icon16/shield.png")
        demotemenu:AddOption("ВП-ТАК", function() RunConsoleCommand ("say", "/changeradiochannel 13.4") end):SetImage("icon16/comment.png")
        demotemenu:AddOption("ССО-ТАК", function() RunConsoleCommand ("say", "/changeradiochannel 89.5") end):SetImage("icon16/comment.png")
        demotemenu:AddOption("Проверить подразделения", function()
RunConsoleCommand ("say", "/r [Штаб - БАЗА] Запрашиваю информацию о бойцах на базе.")
         local dist = 4000^2
    hook.Add("HUDPaint", "ShtabMetka", function()
        local scrw, scrh = ScrW(), ScrH()
        for k,v in pairs(player.GetAll()) do
            if v == LocalPlayer() then continue end
            local pos = v:GetPos()
                            if v:Team() == TEAM_ADMIN then return false end
if v:Team() == TEAM_CIV then return false end
                            if v:Team() == TEAM_TER1 then return false end
if v:Team() == TEAM_TER2 then return false end
if v:Team() == TEAM_TER3 then return false end
if v:Team() == TEAM_TER4 then return false end
           if LocalPlayer():GetPos():DistToSqr(pos) < dist then
                pos = pos:ToScreen()
               draw.SimpleText(v:Name(), Trebuchet24, pos.x, pos.y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
              draw.SimpleText(team.GetName(v:Team()), Trebuchet24, pos.x + 32, pos.y + 32, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                                               surface.SetDrawColor( 255, 255, 255, 255 ) -- Set the drawing color
              surface.SetMaterial( Material("icon16/shield.png") ) -- Use our cached material
              surface.DrawTexturedRect( pos.x - 15 , pos.y - 35, 30, 30 ) -- Actually draw the rectangle

          end
       end
  end)
 timer.Simple(15, function() hook.Remove("HUDPaint", "ShtabMetka") end)      
            end):SetImage("icon16/stop.png")
        
    end
    
    if LocalPlayer():Team() == TEAM_SHTAB2 then
        local demotemenu, edited = context:AddSubMenu("ШТАБ")
        edited:SetImage ("icon16/shield.png")
        demotemenu:AddOption("ВП-ТАК", function() RunConsoleCommand ("say", "/changeradiochannel 13.4") end):SetImage("icon16/comment.png")
        demotemenu:AddOption("ССО-ТАК", function() RunConsoleCommand ("say", "/changeradiochannel 89.5") end):SetImage("icon16/comment.png")
                demotemenu:AddOption("Проверить подразделения", function()
RunConsoleCommand ("say", "/r [Штаб - БАЗА] Запрашиваю информацию о бойцах на базе.")
         local dist = 4000^2
    hook.Add("HUDPaint", "ShtabMetka", function()
        local scrw, scrh = ScrW(), ScrH()
        for k,v in pairs(player.GetAll()) do
            if v == LocalPlayer() then continue end
            local pos = v:GetPos()
                                                        if v:Team() == TEAM_ADMIN then return false end
if v:Team() == TEAM_CIV then return false end
                            if v:Team() == TEAM_TER1 then return false end
if v:Team() == TEAM_TER2 then return false end
if v:Team() == TEAM_TER3 then return false end
if v:Team() == TEAM_TER4 then return false end
if v:Team() == TEAM_ADMIN then return false end
           if LocalPlayer():GetPos():DistToSqr(pos) < dist then
                pos = pos:ToScreen()
               draw.SimpleText(v:Name(), Trebuchet24, pos.x, pos.y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
              draw.SimpleText(team.GetName(v:Team()), Trebuchet24, pos.x + 32, pos.y + 32, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                                               surface.SetDrawColor( 255, 255, 255, 255 ) -- Set the drawing color
              surface.SetMaterial( Material("icon16/shield.png") ) -- Use our cached material
              surface.DrawTexturedRect( pos.x - 15 , pos.y - 35, 30, 30 ) -- Actually draw the rectangle

          end
       end
  end)
 timer.Simple(15, function() hook.Remove("HUDPaint", "ShtabMetka") end)      
            end):SetImage("icon16/stop.png")
        
    end
    
    if LocalPlayer():Team() == TEAM_SHTAB3 then
        local demotemenu, edited = context:AddSubMenu("ШТАБ")
        edited:SetImage ("icon16/shield.png")
        demotemenu:AddOption("ВП-ТАК", function() RunConsoleCommand ("say", "/changeradiochannel 13.4") end):SetImage("icon16/comment.png")
        demotemenu:AddOption("ССО-ТАК", function() RunConsoleCommand ("say", "/changeradiochannel 89.5") end):SetImage("icon16/comment.png")
                demotemenu:AddOption("Проверить подразделения", function()
RunConsoleCommand ("say", "/r [Штаб - БАЗА] Запрашиваю информацию о бойцах на базе.")
         local dist = 4000^2

    hook.Add("HUDPaint", "ShtabMetka", function()
        local scrw, scrh = ScrW(), ScrH()

        for k,v in pairs(player.GetAll()) do
            if v == LocalPlayer() then continue end
            local pos = v:GetPos()
                                                        if v:Team() == TEAM_ADMIN then return false end
if v:Team() == TEAM_CIV then return false end
                            if v:Team() == TEAM_TER1 then return false end
if v:Team() == TEAM_TER2 then return false end
if v:Team() == TEAM_TER3 then return false end
if v:Team() == TEAM_TER4 then return false end
                            if v:Team() == TEAM_ADMIN then return false end

           if LocalPlayer():GetPos():DistToSqr(pos) < dist then
                pos = pos:ToScreen()
               draw.SimpleText(v:Name(), Trebuchet24, pos.x, pos.y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
              draw.SimpleText(team.GetName(v:Team()), Trebuchet24, pos.x + 32, pos.y + 32, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
               surface.SetDrawColor( 255, 255, 255, 255 ) -- Set the drawing color
              surface.SetMaterial( Material("icon16/shield.png") ) -- Use our cached material
              surface.DrawTexturedRect( pos.x - 15 , pos.y - 35, 30, 30 ) -- Actually draw the rectangle
          end
       end
  end)
 timer.Simple(15, function() hook.Remove("HUDPaint", "ShtabMetka") end)      
            end):SetImage("icon16/stop.png")
        
    end
    
    if LocalPlayer():Team() == TEAM_VAGNER1 then
        local demotemenu, edited = context:AddSubMenu("CCO")
        edited:SetImage ("icon16/shield.png")
        demotemenu:AddOption("ССО-ТАК", function() RunConsoleCommand ("say", "/changeradiochannel 89.5") end):SetImage("icon16/comment.png")
        
    end
    
     if LocalPlayer():Team() == TEAM_VAGNER6 then
        local demotemenu, edited = context:AddSubMenu("CCO")
        edited:SetImage ("icon16/shield.png")
        demotemenu:AddOption("ССО-ТАК", function() RunConsoleCommand ("say", "/changeradiochannel 89.5") end):SetImage("icon16/comment.png")
        
    end
    
    
        if LocalPlayer():Team() == TEAM_GVP then 
                local demotemenu, edited = context:AddSubMenu("Служебное")
                edited:SetImage ("icon16/shield.png")
                demotemenu:AddOption ("Тревожная кнопка", function () RunConsoleCommand ("say", "/r [ГВП] Прокурор активировал тревожную кнопку" ) end ):SetImage("icon16/stop.png")
                demotemenu:AddOption ("УК РФ", function () gui.OpenURL('http://www.consultant.ru/document/cons_doc_LAW_10699/') end ):SetImage("icon16/script.png")
                demotemenu:AddOption ("Удостоверение", function () RunConsoleCommand ("say", "/me показал удостоверение прокурора. Имя " ..LocalPlayer():Name()  ) end ):SetImage("icon16/tag_blue.png")
                 demotemenu:AddOption ("Вызов ВП", function ()
                 draw_textbox("Вызвать ВП", "Вызвать", "Место", function(c) RunConsoleCommand ("say", "/r [ГВП-ВП] Срочно требуются сотрудники ВП в " ..tostring(c) ) end) end):SetImage("icon16/shield.png")
                  end
    
    
            if LocalPlayer():Team() == TEAM_GVP1 then 
                local demotemenu, edited = context:AddSubMenu("Служебное")
                edited:SetImage ("icon16/shield.png")
                demotemenu:AddOption ("Тревожная кнопка", function () RunConsoleCommand ("say", "/r [ГВП] Прокурор активировал тревожную кнопку" ) end ):SetImage("icon16/stop.png")
                demotemenu:AddOption ("УК РФ", function () gui.OpenURL('http://www.consultant.ru/document/cons_doc_LAW_10699/') end ):SetImage("icon16/script.png")
                demotemenu:AddOption ("Удостоверение", function () RunConsoleCommand ("say", "/me показал удостоверение прокурора. Имя " ..LocalPlayer():Name()  ) end ):SetImage("icon16/tag_blue.png")
                 demotemenu:AddOption ("Вызов ВП", function ()
                 draw_textbox("Вызвать ВП", "Вызвать", "Место", function(c) RunConsoleCommand ("say", "/r [ГВП-ВП] Срочно требуются сотрудники ВП в " ..tostring(c) ) end) end):SetImage("icon16/shield.png")

                  end
    
    
        print (context.x, context.y)
        context:MoveTo(pos_x, pos_y,  - 25, 0)
        context:MoveTo(context.x, ScrH() - context:GetTall() - 9, .0, 0)

        if LocalPlayer():Team() == TEAM_ADMIN then
            local demotemenu, edited = context:AddSubMenu("Админ")
                    edited:SetImage ("icon16/status_online.png")
            demotemenu:AddOption ("Респавн из призрака", function () RunConsoleCommand("sg", "respawn_G", ply:SteamID()) end ):SetImage("icon16/control_play.png")
    
              --RunConsoleCommand("sg", "respawn_G", ply:SteamID())
            end
end


concommand.Add("open_context_menu", OpenContextMenu)


