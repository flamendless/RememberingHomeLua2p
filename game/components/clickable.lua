Concord.component("clickable")

Concord.component("on_click", function(c, mb, signal, ...)
	ASSERT(mb >= 1 and mb <= 3)
	ASSERT(type(signal) == "string")
	c.mb = mb
	c.signal = signal
	c.args = {...}
end)
