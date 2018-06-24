textHeight = 16; --change this if the text doesn't print out properly
version = "GBA-US"; -- Change this based on which version you're using. Not sure if EU/JP versions have different addresses.
--Valid version strings are "GBA-US and SNES"


-- Here there be coding horrors. Yarr!


	-- Initial variable setup.
	client.SetClientExtraPadding(480,0,0,0); -- Adds a 480 pixel border on the left to display the text into.
	mag = false;
	knife = true;
	bell = false;
	brawl = false;
	cannon = false;
	rune = false;
	abl2 = false;
	abl3 = false;
	strings = {};

	chars = {};
	for i=1,4 do
		chars[i] = {}
		for j=0,8 do
			chars[i][j] = false; --Fill the array with false, only display what is needed.
		end
	end
	-- set up table of memory addresses.
	addresses = {};
	
	for i=1,4 do
		addresses[i] = {};
	end

	if version == "GBA-US" then
	addresses[1][1]  = 0x0200DAEE; -- char 1 str
	addresses[1][2]  = 0x0200DAEF; -- agi
	addresses[1][3]  = 0x0200DAF1; -- mag
	addresses[1][4]  = 0x0200DABE; -- lvl
	addresses[1][5]  = 0x0200DABD; -- job
	addresses[1][6]  = 0x0200DADE; -- abil 1
	addresses[1][7]  = 0x0200DADD; -- abil 2
	addresses[1][8]  = 0x0200DADF; -- abil 3
	addresses[1][9]  = 0x0200DAD6; -- r wep
	addresses[1][10] = 0x0200DAD8; -- l wep

	addresses[2][1]  = 0x0200DB52; -- char 2 str
	addresses[2][2]  = 0x0200DB53; -- agi
	addresses[2][3]  = 0x0200DB55; -- mag
	addresses[2][4]  = 0x0200DB22; -- lvl
	addresses[2][5]  = 0x0200DB21; -- job
	addresses[2][6]  = 0x0200DB42; -- abil 1
	addresses[2][7]  = 0x0200DB41; -- abil 2
	addresses[2][8]  = 0x0200DB43; -- abil 3
	addresses[2][9]  = 0x0200DB3A; -- r wep
	addresses[2][10] = 0x0200DB3C; -- l wep

	addresses[3][1]  = 0x0200DBB6; -- char 3 str
	addresses[3][2]  = 0x0200DBB7; -- agi
	addresses[3][3]  = 0x0200DBB9; -- mag
	addresses[3][4]  = 0x0200DB86; -- lvl
	addresses[3][5]  = 0x0200DB85; -- job
	addresses[3][6]  = 0x0200DBA6; -- abil 1
	addresses[3][7]  = 0x0200DBA5; -- abil 2
	addresses[3][8]  = 0x0200DBA7; -- abil 3
	addresses[3][9]  = 0x0200DB9E; -- r wep
	addresses[3][10] = 0x0200DBA0; -- l wep

	addresses[4][1]  = 0x0200DC1A; -- char 4 str
	addresses[4][2]  = 0x0200DC1B; -- agi
	addresses[4][3]  = 0x0200DC1D; -- mag
	addresses[4][4]  = 0x0200DBEA; -- lvl
	addresses[4][5]  = 0x0200DBE9; -- job
	addresses[4][6]  = 0x0200DC0A; -- abil 1
	addresses[4][7]  = 0x0200DC09; -- abil 2
	addresses[4][8]  = 0x0200DC0B; -- abil 3
	addresses[4][9]  = 0x0200DC02; -- r wep
	addresses[4][10] = 0x0200DC04; -- l wep

	elseif version == "SNES" then 
	addresses[1][1]  = 0x0528; -- char 1 str
	addresses[1][2]  = 0x0529; -- agi
	addresses[1][3]  = 0x052B; -- mag
	addresses[1][4]  = 0x0502; -- lvl
	addresses[1][5]  = 0x0501; -- job
	addresses[1][6]  = 0x0518; -- abil 1
	addresses[1][7]  = 0x0517; -- abil 2
	addresses[1][8]  = 0x0519; -- abil 3
	addresses[1][9]  = 0x0513; -- r wep
	addresses[1][10] = 0x0514; -- l wep

	addresses[2][1]  = 0x0578; -- char 2 str
	addresses[2][2]  = 0x0579; -- agi
	addresses[2][3]  = 0x057B; -- mag
	addresses[2][4]  = 0x0552; -- lvl
	addresses[2][5]  = 0x0551; -- job
	addresses[2][6]  = 0x0568; -- abil 1
	addresses[2][7]  = 0x0567; -- abil 2
	addresses[2][8]  = 0x0569; -- abil 3
	addresses[2][9]  = 0x0563; -- r wep
	addresses[2][10] = 0x0564; -- l wep

	addresses[3][1]  = 0x05C8; -- char 3 str
	addresses[3][2]  = 0x05C9; -- agi
	addresses[3][3]  = 0x05CB; -- mag
	addresses[3][4]  = 0x05A2; -- lvl
	addresses[3][5]  = 0x05A1; -- job
	addresses[3][6]  = 0x05B8; -- abil 1
	addresses[3][7]  = 0x05B7; -- abil 2
	addresses[3][8]  = 0x05B9; -- abil 3
	addresses[3][9]  = 0x05B3; -- r wep
	addresses[3][10] = 0x05B4; -- l wep

	addresses[4][1]  = 0x0618; -- char 4 str
	addresses[4][2]  = 0x0619; -- agi
	addresses[4][3]  = 0x061B; -- mag
	addresses[4][4]  = 0x05F2; -- lvl
	addresses[4][5]  = 0x05F1; -- job
	addresses[4][6]  = 0x0608; -- abil 1
	addresses[4][7]  = 0x0607; -- abil 2
	addresses[4][8]  = 0x0609; -- abil 3
	addresses[4][9]  = 0x0603; -- r wep
	addresses[4][10] = 0x0604; -- l wep
	end


function detectJobs()

	for i=1,4 do
		chars[i][2] = true; -- Display knives for now.
		chars[i][0] = true; -- Also display row 0
		job = memory.readbyte(addresses[i][5]);

		if job == 0x00 then --Knight, set Rune
			chars[i][6] = true;
		end

		if job == 0x01 then -- Monk, set brawl, disable knife
			chars[i][2] = false; --disable knife
			chars[i][4] = true; --show brawl
		end

		if job == 0x06 then -- Zerk, set Rune
			chars[i][6] = true;
		end

		if job == 0x07 then -- Ranger, set Magic (for !Animals)
			chars[i][1] = true;
		end

		if job == 0x08 then -- Mystic Knight, set Rune
			chars[i][6] = true;
		end

		if job >= 0x09 then -- Jobs ID >= 9 are (almost) all mages. Gladiator and Cannoneer will disable this when it gets to them.
			chars[i][1] = true;
		end

		if job == 0x09 then -- White Mage loses knives
			chars[i][2] = false;
		end

		if job == 0x0D then -- Blue Mage gets Rune
			chars[i][6] = true;
		end

		if job == 0x0E then -- Red Mage also gets Rune
			chars [i][6] = true;
		end

		if job == 0x11 then -- Geomancer gets rune bell.
			chars[i][6] = true;
		end

		if job == 0x16 then -- Cannnoneer gets cannon and loses magic
			chars[i][1] = false;
			chars[i][5] = true;
		end

		if job == 0x17 then --Gladiator loses magic, but gets rune
			chars[i][1] = false;
			chars[i][6] = true;
		end

		if job == 0x18 then -- Mime gets all three ability slots checked.
			chars[i][7] = true; --check ability slot 2 (usually the job-based one)
			chars[i][8] = true; --check ability slot 3 (usually !Item)
		end

		if job == 0x19 then -- Freelancer gets rune, bell, and ability 2
			chars[i][3] = true;
			chars[i][6] = true;
			chars[i][7] = true;
		end
	end -- end for

end --end detectJobs()

function detectAbilities()

	for i=1,4 do
		abl1 = memory.readbyte(addresses[i][6]);
		abl2 = 0;
		abl3 = 0;
		if chars[i][7] == true then
			abl2 = memory.readbyte(addresses[i][7]);
		end
		if chars[i][8] == true then
			abl3 = memory.readbyte(addresses[i][8]);
		end

		if chars[i][2] == false then -- only check knife abilities if knife is false.
			
			if abl1 == 0x87 then
				chars [i][2] = true;
			end

			if abl2 == 0x87 then
				chars [i][2] = true;
			end

			if abl3 == 0x87 then
				chars [i][2] = true;
			end

			if abl1 == 0x88 then
				chars[i][2] = true;
			end

			if abl2 == 0x88 then
				chars[i][2] = true;
			end

			if abl3 == 0x88 then
				chars[i][2] = true;
			end
		end -- end knife check

		if chars [i][1] == false then -- check mag if it's false
			if abl1 >= 0x32 then 
				if abl1 <= 0x5E then
					chars [i][1] = true;
				end
			end

			if abl1 == 0x9F then
				chars[i][1] = true;
			end

			if abl2 >= 0x32 then
				if abl2 <= 0x5E then
					chars [i][1] = true;
				end
			end

			if abl2 == 0x9F then
				chars[i][1] = true;
			end

			if abl3 >= 0x32 then
				if abl3 <= 0x5E then
					chars [i][1] = true;
				end
			end

			if abl3 == 0x9F then
				chars[i][1] = true;
			end
		end -- end mag check

		if chars[i][4] == false then -- check brawl if it's false based on class
			if abl1 == 0x90 then
				chars[i][4] = true;
			end

			if abl2 == 0x90 then
				chars[i][4] = true;
			end

			if abl3 == 0x90 then
				chars[i][4] = true;
			end
		end

		if chars[i][5] == false then --check for cannon
			if abl1 == 0x5F then
				chars[i][5] = true;
			end

			if abl1 == 0x60 then
				chars[i][5] = true;
			end

			if abl2 == 0x5F then
				chars[i][5] = true;
			end

			if abl2 == 0x60 then
				chars[i][5] = true;
			end
			

			if abl3 == 0x5F then
				chars[i][5] = true;
			end

			if abl3 == 0x60 then
				chars[i][5] = true;
			end
		end

		if chars[i][6] == false then --finally, check for rune

			if abl1 == 0x83 then
				chars[i][6] = true;
			end

			if abl1 == 0x86 then
				chars[i][6] = true;
			end

			if abl2 == 0x83 then
				chars[i][6] = true;
			end

			if abl2 == 0x86 then
				chars[i][6] = true;
			end

			if abl3 == 0x83 then
				chars[i][6] = true;
			end

			if abl3 == 0x86 then
				chars[i][6] = true;
			end
		end
	end -- end for
end --end detectAbilities()

function drawText()
	gui.cleartext(); -- Clear all text.

	for i=1,4 do -- Display initial status lines
		gui.text(0,(textHeight*7*(i-1))+textHeight,strings[i]);
	end

	for i=5,8 do -- Display standard next M at line
		gui.text(0,(textHeight*7*(i-5))+(textHeight*2),strings[i]);
	end

	for i=9,12 do -- Display knife bonus, if needed
		if chars[i-8][2] == true then
			gui.text(0,textHeight*7*(i-9)+(textHeight*3),strings[i]);
		end --end if
	end --end for

	for i=13,16 do -- Display mag bonus, if needed
		if chars[i-12][1] == true then
			gui.text(0,textHeight*7*(i-13)+(textHeight*4),strings[i]);
		end --end if
	end --end for

	for i=17,20 do -- Display brawl bonus, if needed
		if chars[i-16][4] == true then
			gui.text(0,textHeight*7*(i-17)+(textHeight*5),strings[i]);
		end --end if
	end --end for

	for i=21,24 do -- Display cannon bonus, if needed
		if chars[i-20][5] == true then
			gui.text(0,textHeight*7*(i-21)+(textHeight*6),strings[i]);
		end --end if
	end --end for

end

function clearStrings()
	for i=1,24 do
		strings[i] = "";
	end
end

function computeMult()
	-- Read stats and level
	for i=1,24 do
		strings[i] = "";
	end
	for i=1,4 do
		lvl = memory.readbyte(addresses[i][4]);
		str = memory.readbyte(addresses[i][1]);
		agi = memory.readbyte(addresses[i][2]);
		mag = memory.readbyte(addresses[i][3]);
		physM = math.floor(((lvl*str)/128)+2);
		nextLvl = math.ceil(((physM-1)*128)/str);
		nextStr = math.ceil(((physM-1)*128)/lvl);
		strings[i]   = "Job " .. memory.readbyte(addresses[i][5]) .. " phys: " .. physM;
        strings[i+4] = "Next lvl +" .. nextLvl-lvl .. "("..nextLvl..") or str +" ..nextStr-str.."("..nextStr..")";

        if chars[i][2] then --if knife M is to be displayed
			knifeBonus = math.floor(((lvl*agi)%256)/128);
			-- Calculate when bonus flips
			-- Hokay. Lvl*agi mod 256 will give us a number 0-255.
			-- If < 128, subtract it from 128, div that by agi/level, and ceiling for when bonus is gained.
			-- If >= 128, subtract it from 256, div that by agi/level, and ceiling for when bonus is lost.
			-- Or just ((knifeBonus+1)*128) - ((agi*lvl)%256), div agi/level, and ceiling.
			nextLvl = math.ceil(((math.floor((lvl*agi)/128)+1)*128)/agi);
			nextAgi = math.ceil(((math.floor((lvl*agi)/128)+1)*128)/lvl);
			if knifeBonus == 1 then
				strings[i] = strings[i] .. "+";
				strings[i+8] = "Lose knife bonus at lvl +" .. nextLvl-lvl .. "(" ..nextLvl..") or agi +" ..nextAgi-agi .. "(" .. nextAgi ..")";
			else
				strings[i] = strings[i] .. "-";
				strings[i+8] = "Gain knife bonus at lvl +" .. nextLvl-lvl .. "(" ..nextLvl..") or agi +" ..nextAgi-agi .. "(" .. nextAgi ..")";
			end
		end
		
		if chars[i][1] then --if mag M is to be displayed
			magM = math.floor(((lvl*mag)/256)+4);
			nextLvl = math.ceil(((magM-3)*256)/mag);
			nextMag = math.ceil(((magM-3)*256)/lvl);
			strings[i] = strings[i] .. " Mag: " .. magM;
			strings[i+12] = "Mag: next lvl +" .. nextLvl-lvl .. "(" .. nextLvl ..") or mag +" .. nextMag - mag .. "(" ..nextMag ..")";
		end

		if chars[i][3] then --if bell M is to be displayed
			bellM = math.floor(((lvl*agi)/128) + ((lvl*mag)/128));
			strings[i] = strings[i] .. " Bell: " ..bellM;
			--Not going to deal with when the multi-stat weapons get their next M.
		end

		if chars[i][4] then --if brawl M is to be displayed
			brawlM = math.floor((lvl*str)/256)+2;
			nextLvl = math.ceil(((brawlM-1)*256)/str);
			nextStr = math.ceil(((brawlM-1)*256)/lvl);
			strings[i] = strings[i] .. " Brawl: " .. brawlM;
			strings[i+16] = "Brawl: next lvl +"  ..nextLvl - lvl .. "(" .. nextLvl ..") or str +" .. nextStr-str .. "(" ..nextStr ..")";
		end

		if chars[i][5] then --if cannon M is to be displayed
			cannonM = math.floor((lvl*lvl)/256);
			nextLvl = math.ceil(math.sqrt(cannonM+1));
			strings[i] = strings[i] .. " Cannon: " .. cannonM;
			strings[i+20] = "Cannon: next lvl +" .. nextLvl-lvl .. "(" .. nextLvl ..")";
		end

		if chars[i][6] then --if rune M is to be displayed
			runeM = math.floor((str*lvl)/128) + math.floor((mag*lvl)/128) + 2;
			strings[i] = strings[i] .. " Rune: " .. runeM;
		end

		if chars[i][2] then --if knife M is to be displayed, handle Chicken Knife
			chickenM = math.floor((str*lvl)/128) + math.floor((agi*lvl)/128) +2
			strings[i] = strings[i] .. " Chicken: " .. chickenM;
		end
	end -- end for
end -- end computeMult()

function refresh()
	for i=1,4 do
		for j=0,8 do
			chars[i][j] = false;
		end
	end
end

while true do
	refresh();
	detectJobs();
	detectAbilities();
	computeMult();
	
	drawText();
	
	emu.frameadvance();

end
