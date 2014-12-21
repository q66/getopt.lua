-- A simple example for getopt.lua

local getopt = require("getopt")

local maybe = function(v)
    if v == nil then
        return "(not given)"
    end
    return tostring(v)
end

local opts, args, parser = getopt.parse {
    -- optional
    usage = "Usage: %prog [OPTIONS] [ARGUMENTS]",
    -- Lua by default provides this
    args  = arg,
    -- header
    header = "Headers are awesome.",
    -- footer
    footer = "Footers are great.",
    -- our descriptions
    descs = {
        { category = "General" },

        { "h", "help", nil, help = "Show this message.", metavar = "CATEGORY",
            callback = getopt.help_cb(io.stdout)
        },
        { "v", "verbose", false, help = "Be verbose." },

        { category = "Awesome args", alias = "awesome" },

        { "I", "include", true, help = "Include a directory.", metavar = "DIR",
            list = {}
        },
        { "d", "dimensions", true, help = "Specify dimensions", metavar = "WxH",
            callback = getopt.size_parse_cb
        },
        { "g", "geometry", true, help = "Specify geometry",
            "x:y:w:h", callback = getopt.geometry_parse_cb
        },
        { "s", "silly", true, help = "Silly arg to test arg count limit",
            count = 3
        }
    },
    -- what happens if we fail
    error_cb = function(parser, msg)
        io.stderr:write("we failed! handling it: ", msg, "\n")
        io.stderr:write("perhaps you need help?\n\n")
        getopt.help(parser, io.stderr)
    end,
    -- what happens if we succeed
    done_cb = function(parser, opts, args)
        print("\nwoo, success!")
        print("going over our optional args!")
        if #opts == 0 then
            print("got no optional args though :(")
        end
        for i, opt in ipairs(opts) do
            print("got opt!")
            print("    name : " .. opt[1])
            print("    short: " .. maybe(opt.short))
            print("    long : " .. maybe(opt.long))
            print("    alias: " .. maybe(opt.alias))
            print("    val  : " .. maybe(opt.val))
            print("    array vals: " .. table.concat(opt, ", "))
        end
        print("\npositional args are boring.")
        local v = table.concat(args, ", ")
        if v == "" then
            print("... and none were given anyway.")
        else
            print(v)
        end
    end
}

if not opts then
    print("\nour program failed :( error message: " .. args)
else
    print("\nour program succeeded!")
end