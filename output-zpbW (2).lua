local decalsyeeted = true
		g = game
		w = workspace
		l = g.Lighting
		t = w.Terrain -- Leaving this on makes games look shitty but the fps goes up by at least 20.
		t.WaterWaveSize = 0
		t.WaterWaveSpeed = 0
		t.WaterReflectance = 0
		t.WaterTransparency = 0
		l.GlobalShadows = false
		l.FogEnd = 9e9
		l.Brightness = 0
		settings().Rendering.QualityLevel = "Level01"
		local shit = g:GetDescendants()
		for i = 1, #shit do local v = shit[i]
			if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
				v.Material = "Plastic"
				v.Reflectance = 0
			elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
				v.Transparency = 1
			elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
				v.Lifetime = NumberRange.new(0)
			elseif v:IsA("Explosion") then
				v.BlastPressure = 1
				v.BlastRadius = 1
			elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
				v.Enabled = false
			elseif v:IsA("MeshPart") then
				v.Material = "Plastic"
				v.Reflectance = 0
				v.TextureID = 10385902758728957
			end
		end
		for i, e in pairs(l:GetChildren()) do
			if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
				e.Enabled = false
			end
		end
		-- < Services > --
		lighting = game:FindService("Lighting") or game:GetService("Lighting")
		networkSettings = settings().Network
		renderSettings = settings().Rendering
		gameSettings = settings()["Game Options"]
		userGameSettings = UserSettings():FindService("UserGameSettings") or UserSettings():GetService("UserGameSettings")
		-- < Definitions > --
		lagConfiguration = {
			-- FPS increasing
			qualityLevel = Enum.QualityLevel.Level01; -- Up to Level21
			savedQualityLevel = Enum.SavedQualitySetting.QualityLevel1; -- Up to QualityLevel10
			videoQualitySetting = Enum.VideoQualitySettings.LowResolution; -- Gives 15/20 additional FPS, Up to HighResolution
			eagerBulkExecution = false; -- Disables unlimited budget for rendering
			globalShadows = false; -- Disables shadows
			-- Lag decreasing (just in case!)
			incommingReplicationLag = -1000;
			-- funny thing because why not
			hasEverUsedVR = true
		}

		local set_hidden_property = sethiddenproperty or set_hidden_prop

		function boostAttempt()
			pcall(function() set_hidden_property(lighting, "Technology", Enum.Technology.Compatibility) end)
			-- FPS boost
			renderSettings.QualityLevel = lagConfiguration["qualityLevel"]
			userGameSettings.SavedQualityLevel = lagConfiguration["savedQualityLevel"]
			gameSettings.VideoQuality = lagConfiguration["videoQualitySetting"]
			renderSettings.EagerBulkExecution = lagConfiguration["eagerBulkExecution"]
			lighting.GlobalShadows = lagConfiguration["globalShadows"]
			-- Decreasing lag (just in case!)
			networkSettings.IncommingReplicationLag = lagConfiguration["incommingReplicationLag"]
			-- funny thing
			userGameSettings.HasEverUsedVR = lagConfiguration["hasEverUsedVR"]
		end

		boostAttempt()
