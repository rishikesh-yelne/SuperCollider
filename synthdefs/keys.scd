(
SynthDef(\organ, { |freq = 440, amp = 0.6, sustain = 0.6|
	var env = Env.linen(0.1, sustain, 0.3).kr(doneAction: 2);  // smooth attack/release
	var sig = Mix.fill(3, { |i|
		SinOsc.ar(freq * (1 + (i * 0.01)), 0, amp / 3)
	}); // gentle detune for chorus effect
	sig = LPF.ar(sig, 4000); // soften tone
	Out.ar(0, sig!2 * env);
}).add;

SynthDef(\softKeys, { |freq = 440, amp = 0.3, sustain = 0.2|
	var env = Env.linen(0.05, sustain, 0.5).kr(doneAction: 2);
	var vibrato = SinOsc.kr(5, 0, 0.01, 1); // gentle pitch wobble
	var sig = Pulse.ar(freq * vibrato, 0.4, amp);
	sig = LPF.ar(sig, 1500);
	sig = sig * env;
	Out.ar(0, sig!2);
}).add;
)