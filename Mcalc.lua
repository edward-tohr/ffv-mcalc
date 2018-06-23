textHeight = 16; --change this if the text doesn't print out properly
version = "GBA-US"; -- Change this based on which version you're using. Not sure if EU/JP versions have different addresses.
--Valid version strings are "GBA-US and SNES"

while true do
	-- Memory addresses for GBA US version. Change these for different versions.
	if version == "GBA-US" then
	c1Str = memory.readbyte(0x0200DAEE);
	c1Agi = memory.readbyte(0x0200DAEF);
	c1Mag = memory.readbyte(0x0200DAF1);
	c1Lvl = memory.readbyte(0x0200DABE);

	c2Str = memory.readbyte(0x0200DB52);
	c2Agi = memory.readbyte(0x0200DB53);
	c2Mag = memory.readbyte(0x0200DB55);
	c2Lvl = memory.readbyte(0x0200DB22);

	c3Str = memory.readbyte(0x0200DBB6);
	c3Agi = memory.readbyte(0x0200DBB7);
	c3Mag = memory.readbyte(0x0200DBB9);
	c3Lvl = memory.readbyte(0x0200DB86);

	c4Str = memory.readbyte(0x0200DC1A);
	c4Agi = memory.readbyte(0x0200DC1B);
	c4Mag = memory.readbyte(0x0200DC1D);
	c4Lvl = memory.readbyte(0x0200DBEA);

	elseif version == "SNES" then
	c1Str = memory.readbyte(0x0528);
	c1Agi = memory.readbyte(0x0529);
	c1Mag = memory.readbyte(0x052B);
	c1Lvl = memory.readbyte(0x0502);

	c2Str = memory.readbyte(0x0552);
	c2Agi = memory.readbyte(0x0578);
	c2Mag = memory.readbyte(0x0579);
	c2Lvl = memory.readbyte(0x057B);

	c3Str = memory.readbyte(0x05C8);
	c3Agi = memory.readbyte(0x05C9);
	c3Mag = memory.readbyte(0x05CB);
	c3Lvl = memory.readbyte(0x05A2);

	c4Str = memory.readbyte(0x0618);
	c4Agi = memory.readbyte(0x0619);
	c4Mag = memory.readbyte(0x061B);
	c4Lvl = memory.readbyte(0x05F2);
end 


	c1AgiPart = math.floor((c1Agi % 256)/128); -- Used for bugged knife calc
	c1StrM = math.floor((c1Str*c1Lvl)/128); --lvl*str/128
	c1MagM = math.floor((c1Mag*c1Lvl)/128); --lvl*mag/128
	c1AgiM = math.floor((c1Agi*c1Lvl)/128); --lvl*agi/128
	c1PM = c1StrM + 2; --Physical attack M, ((lvl*str)/128)+2
	c1MM = math.floor((c1MagM/2)) +4; --Magic attack M, ((lvl*mag)/256)+4
	c1KM = c1PM + c1AgiPart; --Knife/Bow M, ((lvl*str)/128) + (((lvl*agi)%256)/128) +2, or Phys M + (agiPart/128)
	c1BM = c1MagM + c1AgiM +2; --Bell M, ((lvl*mag)/128) + ((lvl*agi)/128) +2
	c1CM = c1StrM + c1AgiM +2; --Throw/Chicken Knife M, ((lvl*str)/128) + ((lvl*agi)/128) +2
	c1FM = math.floor((c1StrM/2))+2; --Unarmed M, ((lvl*str)/256)+2
	c1CanM = math.floor((c1Lvl * c1Lvl)/256) +4; -- M for cannons, lvl^2/256 +4

	--(strM+1 * 128) / Str to get next level
	--(strM_1 * 128) / lvl to get next str
	c1NextPart = (c1StrM + 1)*128;
	c1NextLevel = math.ceil(c1NextPart / c1Str);
	c1NextStrength = math.ceil(c1NextPart / c1Lvl);


	
	c2AgiPart = math.floor((c2Agi % 256)/128); -- Used for bugged knife calc
	c2StrM = math.floor((c2Str*c2Lvl)/128); --lvl*str/128
	c2MagM = math.floor((c2Mag*c2Lvl)/128); --lvl*mag/128
	c2AgiM = math.floor((c2Agi*c2Lvl)/128); --lvl*agi/128
	c2PM = c2StrM + 2; --Physical attack M, ((lvl*str)/128)+2
	c2MM = math.floor((c2MagM/2)) +4; --Magic attack M, ((lvl*mag)/256)+4
	c2KM = c2PM + c2AgiPart; --Knife/Bow M, ((lvl*str)/128) + (((lvl*agi)%256)/128) +2, or Phys M + (agiPart/128)
	c2BM = c2MagM + c2AgiM +2; --Bell M, ((lvl*mag)/128) + ((lvl*agi)/128) +2
	c2CM = c2StrM + c2AgiM +2; --Throw/Chicken Knife M, ((lvl*str)/128) + ((lvl*agi)/128) +2
	c2FM = math.floor((c2StrM/2))+2; --Unarmed M, ((lvl*str)/256)+2
	c2CanM = math.floor((c2Lvl * c2Lvl)/256) +4; -- M for cannons, lvl^2/256 +4

	c2NextPart = (c2StrM + 1)*128;
	c2NextLevel = math.ceil(c2NextPart / c2Str);
	c2NextStrength = math.ceil(c2NextPart / c2Lvl);



	c3AgiPart = math.floor((c3Agi % 256)/128); -- Used for bugged knife calc
	c3StrM = math.floor((c3Str*c3Lvl)/128); --lvl*str/128
	c3MagM = math.floor((c3Mag*c3Lvl)/128); --lvl*mag/128
	c3AgiM = math.floor((c3Agi*c3Lvl)/128); --lvl*agi/128
	c3PM = c3StrM + 2; --Physical attack M, ((lvl*str)/128)+2
	c3MM = math.floor((c3MagM/2)) +4; --Magic attack M, ((lvl*mag)/256)+4
	c3KM = c3PM + c3AgiPart; --Knife/Bow M, ((lvl*str)/128) + (((lvl*agi)%256)/128) +2, or Phys M + (agiPart/128)
	c3BM = c3MagM + c3AgiM +2; --Bell M, ((lvl*mag)/128) + ((lvl*agi)/128) +2
	c3CM = c3StrM + c3AgiM +2; --Throw/Chicken Knife M, ((lvl*str)/128) + ((lvl*agi)/128) +2
	c3FM = math.floor((c3StrM/2))+2; --Unarmed M, ((lvl*str)/256)+2
	c3CanM = math.floor((c3Lvl * c3Lvl)/256) +4; -- M for cannons, lvl^2/256 +4

	--(strM+1 * 128) / Str to get next level
	--(strM_1 * 128) / lvl to get next str
	c3NextPart = (c3StrM + 1)*128;
	c3NextLevel = math.ceil(c3NextPart / c3Str);
	c3NextStrength = math.ceil(c3NextPart / c3Lvl);



	c4AgiPart = math.floor((c4Agi % 256)/128); -- Used for bugged knife calc
	c4StrM = math.floor((c4Str*c4Lvl)/128); --lvl*str/128
	c4MagM = math.floor((c4Mag*c4Lvl)/128); --lvl*mag/128
	c4AgiM = math.floor((c4Agi*c4Lvl)/128); --lvl*agi/128
	c4PM = c4StrM + 2; --Physical attack M, ((lvl*str)/128)+2
	c4MM = math.floor((c4MagM/2)) +4; --Magic attack M, ((lvl*mag)/256)+4
	c4KM = c4PM + c4AgiPart; --Knife/Bow M, ((lvl*str)/128) + (((lvl*agi)%256)/128) +2, or Phys M + (agiPart/128)
	c4BM = c4MagM + c4AgiM +2; --Bell M, ((lvl*mag)/128) + ((lvl*agi)/128) +2
	c4CM = c4StrM + c4AgiM +2; --Throw/Chicken Knife M, ((lvl*str)/128) + ((lvl*agi)/128) +2
	c4FM = math.floor((c4StrM/2))+2; --Unarmed M, ((lvl*str)/256)+2
	c4CanM = math.floor((c4Lvl * c4Lvl)/256) +4; -- M for cannons, lvl^2/256 +4

	--(strM+1 * 128) / Str to get next level
	--(strM_1 * 128) / lvl to get next str
	c4NextPart = (c4StrM + 1)*128;
	c4NextLevel = math.ceil(c4NextPart / c4Str);
	c4NextStrength = math.ceil(c4NextPart / c4Lvl);

	if version == "GBA-US" then
		gui.text(0,textHeight*1,"Char 1: Phys: " .. c1PM .. " Mag: " .. c1MM .. " Knife: " .. c1KM .. " Bell: " .. c1BM .. " CK: " ..c1CM .. " Brawl: " .. c1FM .. " Cannon: " .. c1CanM);	
	else
		gui.text(0,textHeight*1,"Char 1: Phys: " .. c1PM .. " Mag: " .. c1MM .. " Knife: " .. c1KM .. " Bell: " .. c1BM .. " CK: " ..c1CM .. " Brawl: " .. c1FM);
	end
	gui.text(0,textHeight*2,"Next at level: +" .. c1NextLevel-c1Lvl .. "(" .. c1NextLevel .. ") or str +" .. c1NextStrength-c1Str .. "(" .. c1NextStrength .. ")");

	if version == "GBA-US" then
		gui.text(0,textHeight*4,"Char 2: Phys: " .. c2PM .. " Mag: " .. c2MM .. " Knife: " .. c2KM .. " Bell: " .. c2BM .. " CK: " ..c2CM .. " Brawl: " .. c2FM .. " Cannon: " .. c2CanM);
	else
		gui.text(0,textHeight*4,"Char 2: Phys: " .. c2PM .. " Mag: " .. c2MM .. " Knife: " .. c2KM .. " Bell: " .. c2BM .. " CK: " ..c2CM .. " Brawl: " .. c2FM);
	end
	gui.text(0,textHeight*5,"Next at level: +" .. c2NextLevel-c2Lvl .. "(" .. c2NextLevel .. ") or str +" .. c2NextStrength-c2Str .. "(" .. c2NextStrength .. ")");

	if version == "GBA-US" then
		gui.text(0,textHeight*7,"Char 3: Phys: " .. c3PM .. " Mag: " .. c3MM .. " Knife: " .. c3KM .. " Bell: " .. c3BM .. " CK: " ..c3CM .. " Brawl: " .. c3FM .. " Cannon: " .. c3CanM);
	else
		gui.text(0,textHeight*7,"Char 3: Phys: " .. c3PM .. " Mag: " .. c3MM .. " Knife: " .. c3KM .. " Bell: " .. c3BM .. " CK: " ..c3CM .. " Brawl: " .. c3FM);
	end
	gui.text(0,textHeight*8,"Next at level: +" .. c3NextLevel-c3Lvl .. "(" .. c3NextLevel .. ") or str +" .. c3NextStrength-c3Str .. "(" .. c3NextStrength .. ")");

	if version == "GBA-US" then
		gui.text(0,textHeight*10,"Char 4: Phys: " .. c4PM .. " Mag: " .. c4MM .. " Knife: " .. c4KM .. " Bell: " .. c4BM .. " CK: " ..c4CM .. " Brawl: " .. c4FM .. " Cannon: " .. c4CanM);
	else
		gui.text(0,textHeight*10,"Char 4: Phys: " .. c4PM .. " Mag: " .. c4MM .. " Knife: " .. c4KM .. " Bell: " .. c4BM .. " CK: " ..c4CM .. " Brawl: " .. c4FM);
	end
	gui.text(0,textHeight*11,"Next at level: +" .. c4NextLevel-c4Lvl .. "(" .. c4NextLevel .. ") or str +" .. c4NextStrength-c4Str .. "(" .. c4NextStrength .. ")");

	emu.frameadvance();
end
