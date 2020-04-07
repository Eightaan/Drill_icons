if not _G.DrillUpgradeIcon then
    _G.DrillUpgradeIcon = {}
    DrillUpgradeIcon._path = ModPath
    DrillUpgradeIcon._data_path = SavePath .. "DrillUpgradeIcon.txt"
    DrillUpgradeIcon._data = {} 

    function DrillUpgradeIcon:Save()
	    local file = io.open( self._data_path, "w+" )
	    if file then
	    	file:write( json.encode( self._data ) )
	    	file:close()
    	end
    end

    function DrillUpgradeIcon:Load()
    	local file = io.open( self._data_path, "r" )
    	if file then
    		self._data = json.decode( file:read("*all") )
    		file:close()
    	end
    end

    function DrillUpgradeIcon:GetOption(id)
	    return self._data[id]
    end

    Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_DrillUpgradeIcon", function( loc )
	    loc:load_localization_file( DrillUpgradeIcon._path .. "loc/en.txt")
    end)

    Hooks:Add( "MenuManagerInitialize", "MenuManagerInitialize_DrillUpgradeIcon", function( menu_manager )

	    MenuCallbackHandler.callback_ace_icon = function(self, item)
		    DrillUpgradeIcon._data.ace_icon = (item:value() == "on" and true or false)
    		DrillUpgradeIcon:Save()
    	end
    	MenuCallbackHandler.callback_kickstart_icon = function(self, item)
    		DrillUpgradeIcon._data.kickstart_icon = (item:value() == "on" and true or false)
    		DrillUpgradeIcon:Save()
    	end
        MenuCallbackHandler.callback_icon_scale = function(self, item)
            DrillUpgradeIcon._data.icon_scale = item:value()
		    DrillUpgradeIcon:Save()
        end
	    DrillUpgradeIcon:Load()
	    MenuHelper:LoadFromJsonFile( DrillUpgradeIcon._path .. "options/options.json", DrillUpgradeIcon, DrillUpgradeIcon._data )
    end )
end