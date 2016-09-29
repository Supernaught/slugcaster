--
-- tlog
-- by Alphonsus
--

tlog = {}

-- convert table to string recursively
tlog.stringify = function(t)
	string = ""

	for k, v in pairs(t) do
		if type(v) == 'table' then
			string = string .. k .. " = " .. tlog.stringify(v)
		else
			v = type(v) ~= 'number' and tostring(v) or v
			string = string .. k .. " = " .. v
		end

		string = string .. ", "
	end

	-- remove trailing ", "
	string = string.sub(string,1,#string-2)

	return "{" .. string .. "}"
end

-- print table inline
tlog.print = function(t)
	info = debug.getinfo(2, "Sl")
	lineinfo = info.short_src .. ":" .. info.currentline .. ": "
	io.write(lineinfo)
	if t and type(t) == 'table' then
		io.write(tlog.stringify(t))
	elseif type(t) == 'string' then
		io.write(t)
	end
	io.write("\n")
end

return tlog