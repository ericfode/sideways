if love.filesystem then
    require 'rocks' ()
end

function love.conf(t)
    t.dependencies = {
            "bump ~> 3.1.7",
            "hump ~> 0.4-2",
	    "fun",
            "fennel ~> 0.2.1-2",
    }

end
