local soundEffect = audio.loadSound("chime.wav")
audio.play(soundEffect)
audio.pause(<channel #>)
local soundTable = {
  shootSound = audio.loadSound(),
  hitSound = audio.loadSound(),
  explodeSound = audio.loadSound(),
}
--supports .wav, .mp3, .mp4, .acc, .ogg
--the audio supports 32 channels
audio.setVolume(0.5)
audio.setVolume(0.5,{channel=1})
--the volume is a decimal representation of percentage
if math.random(1,2) == 1 then
  print("Hello")
else
  print("Hi")
end
