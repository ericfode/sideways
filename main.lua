-- bootstrap the compiler
require("rocks")
fennel = require("fennel")
view   = require("fennelview")
table.insert(package.loaders, fennel.make_searcher({correlate=true}))
fun  = require("fun")
bump = require("bump")
-- hump = require("hump")

require("wrap")
