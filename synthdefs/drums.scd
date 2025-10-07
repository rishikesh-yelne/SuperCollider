(
// Kick
SynthDef(\kick, {
	var env = Env.perc(0.001, 0.3, curve: -4);
	var sig = SinOsc.ar(60, 0, EnvGen.kr(env, doneAction:2));
	Out.ar(0, sig!2);
}).add;

// Snare
SynthDef(\snare, {
	var env = Env.perc(0.001, 0.2);
	var noise = WhiteNoise.ar(0.3) * EnvGen.kr(env, doneAction:2);
	Out.ar(0, noise!2);
}).add;

// Closed hi-hat
SynthDef(\hihatClosed, {
	var env = Env.perc(0.001, 0.05);
	var sig = HPF.ar(WhiteNoise.ar(0.3), 8000) * EnvGen.kr(env, doneAction:2);
	Out.ar(0, sig!2);
}).add;

// Open hi-hat
SynthDef(\hihatOpen, {
	var env = Env.perc(0.001, 0.4);
	var sig = HPF.ar(WhiteNoise.ar(0.3), 6000) * EnvGen.kr(env, doneAction:2);
	Out.ar(0, sig!2);
}).add;

// Better crash cymbal
SynthDef(\cymbal, {
	var env = Env.perc(0.001, 1.5, curve: -4);
	var noise = WhiteNoise.ar(0.5);
	var tone = HPF.ar(noise, 5000);
	var sig = tone * EnvGen.kr(env, doneAction:2);
	Out.ar(0, sig!2);
}).add;
)
