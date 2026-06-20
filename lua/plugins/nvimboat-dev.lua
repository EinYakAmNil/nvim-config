return {
	"boat",
	dev = true,
	lazy = false,
	config = function()
		local nvimboat = require("nvimboat")
		nvimboat.setup({
			feeds = {
				{ rssurl = "https://www.youtube.com/feeds/videos.xml?user=CaravanPalace", tags = { "Video", "YouTube", "Music" } },
			}
		})
	end,
	enabled = false
}
