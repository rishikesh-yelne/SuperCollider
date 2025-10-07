(
SynthDef(\clap, {
	var env = Env.perc(0.001, 0.15);
	var noise = WhiteNoise.ar(0.5) * EnvGen.kr(env, doneAction:2);
	var sig = HPF.ar(noise, 2000); // high-pass for crispness
	Out.ar(0, sig!2);
}).add;
)