package = "getopt.lua"
version = "scm-0"
source = {
	url = "git://github.com/q66/getopt.lua.git";
}
description = {
	summary = "A simple but powerful argument parser for Lua 5.1 and later.";
	homepage = "https://github.com/q66/getopt.lua";
	license = "MIT/X11";
}
dependencies = {
	"lua >= 5.1, < 5.4";
}
build = {
	type = "builtin";
	modules = {
		getopt = "getopt.lua";
	}
}
