-- Yazi configuration
-- https://yazi-rs.github.io/docs/configuration/overview

-- : Full border plugin {{{
require("full-border"):setup()
-- : }}}

-- : Linemode helper {{{
-- Shows size + mtime combined, similar to superfile's file info footer
function Linemode:size_and_mtime()
	local time = math.floor(self._file.cha.mtime or 0)
	if time == 0 then
		time = ""
	elseif os.date("%Y", time) == os.date("%Y") then
		time = os.date("%b %d %H:%M", time)
	else
		time = os.date("%b %d  %Y", time)
	end
	local size = self._file:size()
	return string.format("%s  %s", size and ya.readable_size(size) or "-", time)
end
-- : }}}
