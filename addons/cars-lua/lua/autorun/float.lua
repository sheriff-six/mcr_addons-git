
if SERVER then
	hook.Add("Think", "simf_swimmode_", function()
		for k,ent in pairs(ents:GetAll()) do
			if ( ent:GetClass() == "gmod_sent_vehicle_fphysics_base" ) then
				local waterLevel = ent:WaterLevel()
					if waterLevel > 0 then
						local throttle = ent:GetThrottle()
						local gear = ent:GetGear()
						if gear == 1 then throttle = throttle*(1) end

						local physObj = ent:GetPhysicsObject()

						local get_direction = ent:GetNWVector("_set_direction")
						local set_direction = ent:GetNWInt("_direction_")
						if set_direction == 0 then 
							ent:SetNWVector("_set_direction", ent:GetForward())
						elseif set_direction == 1 then
							ent:SetNWVector("_set_direction", ent:GetLeft())
						elseif set_direction == 2 then
							ent:SetNWVector("_set_direction", ent:GetRight())
						end

						if throttle > 0 then
							physObj:AddVelocity(get_direction*1*throttle*(ent:GetRPM()/5000)*(ent:GetMaxTorque()/30)*(ent:GetEfficiency()))
						elseif throttle < 0 then
							physObj:AddVelocity(get_direction*1*(throttle)*(ent:GetRPM()/2000)*(ent:GetMaxTorque()/30)*(ent:GetEfficiency()))
						end

						local steer = ent:GetVehicleSteer()
						local speed = ent:GetVelocity():Length()
		      			local kmh = math.Round(speed * 0.09144,0)
						if steer < 0 then
							if kmh >= 9 then
								physObj:AddAngleVelocity(Vector(0,0,ent:GetSteerSpeed()-0.8))
							elseif kmh < 9 and kmh != 0 then
								physObj:AddAngleVelocity(Vector(0,0,ent:GetSteerSpeed()-0.9))
							end
						elseif steer > 0 and kmh >= 2 then
							if kmh >= 9 then
								physObj:AddAngleVelocity(Vector(0,0,(ent:GetSteerSpeed()-0.8)*(-1)))
							elseif kmh < 9 and kmh != 0 then
								physObj:AddAngleVelocity(Vector(0,0,(ent:GetSteerSpeed()-0.9)*(-1)))
							end
						end
					end
				end
			end
		end)
	hook.Add("OnEntityCreated", "simf_swimmode_on_entcreate", function(ent)
		timer.Simple(1, function()
			if IsValid(ent) then
				if simfphys.IsCar(ent) and ent:GetNWBool("_can_swim__") then
					ent:GetPhysicsObject():SetBuoyancyRatio(ent:GetNWInt("__SetBuoyancyRatio__"))
				end
			end
		end)
	end)
end