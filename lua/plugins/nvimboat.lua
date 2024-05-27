local feeds = {
	{
		rssurl = "https://feeds.feedburner.com/TheHackersNews",
		tags = { "Hacking", "Tech" }
	}
}
local filters = {

}
return {
	"EinYakAmNil/Nvimboat",
	build = function()
		local nvimboat_go_path = vim.fn.stdpath("data") .. "/lazy/Nvimboat/go"
		os.execute("go build -C " .. nvimboat_go_path)
	end,
	config = function()
		local nvimboat = require("nvimboat")
		nvimboat.setup({
			feeds = feeds,
			filters = filters,
		})
	end
}
