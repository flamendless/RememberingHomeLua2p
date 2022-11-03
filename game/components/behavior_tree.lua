Concord.component("behavior_tree", function(c, beehive, nodes)
	ASSERT(type(beehive) == "function")
	ASSERT(type(nodes) == "table")
	c.beehive = beehive
	c.nodes = nodes
	c.current_node = nil
	c.result = ""
end)
