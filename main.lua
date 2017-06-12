globlaAccount = "pettosryg@126.com";
globlaPassword = "Mayundashabi123";

mainAccountInfo = {};


local tsld = loadTSLibrary("pretender.tsl") --库加载
if tsld.status == 0 then --验证判断
	dialog("插件加载异常", 0)
	return
end
require("TBackups") --需要加载

require "TSLib";



--字符串分割函数
--传入字符串和分隔符，返回分割后的table
function string.split(str, delimiter)
	if str==nil or str=='' or delimiter==nil then
		return nil
	end

	local result = {}
	for match in (str..delimiter):gmatch("(.-)"..delimiter) do
		table.insert(result, match)
	end
	return result
end

function Click(x,y)
	touchDown(1, x, y)
	mSleep(math.random(20,80))
	touchUp(1, x, y)
end

function GetDeviceFuck()
	local width, height = getScreenSize();
	if width == 640 and height == 1136 then         --iPhone 5, 5S, iPod touch 5
		return 5;
	elseif width == 640 and height == 960 then      --iPhone 4,4S, iPod touch 4
		return 4;
	else
		return 0;
	end
end

function Random(n,m)
	math.randomseed(os.clock() * math.random(1000000,90000000) + math.random(1000000,9000000));
	return math.random(n,m);
end

function RandomNumber(len)
	local rt = "";
	for i=1,len,1 do
		if i == 1 then
			rt = rt .. Random(1,9);
		else
			rt = rt .. Random(0,9);
		end
	end

	return rt;
end

function RandomLetter(len)
	local rt = "";
	for i=1,len,1 do
		rt = rt .. string.char(Random(97,122));
	end

	return rt;
end

function RandomCapital(len)
	local rt = "";
	for i=1,len,1 do
		rt = rt .. string.char(Random(65,90));
	end

	return rt;
end

function RandomPassword()
	return RandomCapital(1) .. RandomLetter(3) .. RandomNumber(2);
end

function GetAccountInfo()
	local sz = require("sz")
	local http = require("szocket.http")
	local res, code = http.request("http://ios.pettostudio.net/AccountInfo.aspx?action=getappaccountbychangecountrystate&country=USA&newCounry=China&state=icloud&newChangecountrystate=changing");

	if code == 200 then
		toast(res);
		local ts = require("ts");
		local json = ts.json;

		if string.find(res,"AppleAccount") ~= nil then
			local tmp = json.decode(res);
			return true,tmp;
		else 
			return false;
		end
	else
		return false;
	end
end

function UpdateCountryChanging(applePersonInfoID,id,applePassword)
	local sz = require("sz")
	local http = require("szocket.http")
	local res, code = http.request("http://ios.pettostudio.net/AccountInfo.aspx?action=UpdatePasswordCountryAndChangeCountryStateByID&country=China&changeCountryState=changed&applePersonInfoID=" .. applePersonInfoID .. "&id=" .. id .. "&applePassword=" .. applePassword);

	return code == 200;
end

function CleanAccounts()
	os.execute("cp -rf /User/Library/Accounts/new/*.* /User/Library/Accounts/");
	os.execute("chown -R mobile:mobile /User/Library/Accounts/*.*");
end


function CleanAppStore()
	os.execute("rm /User/Library/com.apple.itunesstored/itunesstored_private.sqlitedb-shm");
	os.execute("rm /User/Library/com.apple.itunesstored/itunesstored_private.sqlitedb-wal");

	os.execute("rm /User/Library/com.apple.itunesstored/itunesstored2.sqlitedb-shm");
	os.execute("rm /User/Library/com.apple.itunesstored/itunesstored2.sqlitedb-wal");

	os.execute("rm /User/Library/com.apple.itunesstored/play_activity.sqlitedb-shm");
	os.execute("rm /User/Library/com.apple.itunesstored/play_activity.sqlitedb-wal");

	os.execute("cp -rf /User/Library/com.apple.itunesstored/new/*.* /User/Library/com.apple.itunesstored/");

	os.execute("chown -R mobile:mobile /User/Library/com.apple.itunesstored/*.*");
end

function CleanFSCachedData()
	os.execute("rm -rf /User/Library/Caches/com.apple.itunesstored/fsCachedData/*");
end

function  KillProcess(process)
	os.execute("killall -9 " .. process);  
end

function ChangeCountry_4(timeout)
	local time1 = os.time();

	local islogouted = false;
	while true do
		if deviceIsLock() ~= 0 then
			unlockDevice();
			mSleep(3000);
		end

		if isFrontApp("com.apple.Preferences")~= 1 then
			openURL("prefs:root=STORE");
			mSleep(1000);
		end

		local x, y = findImageInRegionFuzzy("需要激活_注册IC_4.png",90, 20, 355, 235, 415,0);
		if x ~= -1 and y ~= -1 then     
			unlockDevice();
		end

		local x, y = findImageInRegionFuzzy("未知设备_注册IC_4.png",90, 190, 135, 445, 215,0);
		if x ~= -1 and y ~= -1 then     
			return 3;
		end

		local x, y = findImageInRegionFuzzy("激活失败_注册IC_4.png",90, 190, 135, 450, 215,0);
		if x ~= -1 and y ~= -1 then     
			return 3;
		end

		local x, y = findImageInRegionFuzzy("iPhone尚未激活_注册IC_4.png",90, 180, 390, 455, 435,0);
		if x ~= -1 and y ~= -1 then  
			toast("尚未激活",1);
			Click(180,560);			
		end	

		local x, y = findImageInRegionFuzzy("再试一次1_注册IC_4.png",90, 240, 355, 400, 400,0);
		if x ~= -1 and y ~= -1 then  
			Click(320,380);			
		end	

		local x, y = findImageInRegionFuzzy("再试一次2_注册IC_4.png",90, 245, 850, 400, 900,0);
		if x ~= -1 and y ~= -1 then  
			Click(320,875);			
		end	

		local x, y = findImageInRegionFuzzy("需要激活(单个)_注册IC_4.png",90, 240, 410, 400, 465,0);
		if x ~= -1 and y ~= -1 then  
			toast("需要激活",1);
			Click(320,540);			
		end	

		local x, y = findImageInRegionFuzzy("下一步_注册IC_4.png",90, 515, 60, 630, 110,0);
		if x ~= -1 and y ~= -1 then  
			Click(575,80);			
		end	

		if not islogouted then
			local x, y = findImageInRegionFuzzy("appleid_修改国家_4.png",90, 15, 170, 190, 280,0);
			if x ~= -1 and y ~= -1 then  
				Click(100,y + 20);			
			end			

			local x, y = findImageInRegionFuzzy("ok_修改国家_4.png",90, 275, 605, 365, 655,0);
			if x ~= -1 and y ~= -1 then  
				Click(320,520);			
			end	
			
			local x, y = findImageInRegionFuzzy("注销_修改国家_4.png",90, 270, 480, 370, 570,0);
			if x ~= -1 and y ~= -1 then  
				Click(320,520);			
			end	
			
			local x, y = findImageInRegionFuzzy("appleid_修改国家2_4.png",90, 15, 170, 190, 280,0);
			if x ~= -1 and y ~= -1 then  
				
				toast("登出成功",1);
				islogouted = true;
			end	


		end

		mSleep(1000);
		local time2 = os.time();

		if (time2 - time1) >= timeout then
			return 2;
		end		
	end
end


KillProcess("Preferences");
mSleep(1000);
CleanAccounts();
mSleep(1000);
CleanAppStore();
mSleep(1000);	
CleanFSCachedData();

ChangeCountry_4(180);