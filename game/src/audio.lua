local Audio = {
	volume = 1
}

function Audio.init()
	Audio.set_volume(Settings.current.volume)
	Audio.set_mute(Settings.current.muted)
end

function Audio.set_volume(volume)
	ASSERT(type(volume) == "number" and volume >= 0.0 and volume <= 1.0)
	Audio.volume = volume
	love.audio.setVolume(Audio.volume)
end

function Audio.set_mute(mute)
	ASSERT(type(mute) == "boolean")
	if mute then
		love.audio.setVolume(0)
	else
		love.audio.setVolume(Audio.volume)
	end
end

return Audio
