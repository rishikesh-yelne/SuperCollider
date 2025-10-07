(
SynthDef(\pluck, { |freq = 440, amp = 0.3, decay = 3|
    var sig, env;
    env = Env.perc(0.001, decay, amp).kr(doneAction:2);
    sig = Pluck.ar(WhiteNoise.ar(amp), trig: Impulse.kr(0), maxdelaytime: 0.1, delaytime: 1/freq, decaytime: decay);
    Out.ar(0, sig!2);
}).add;

SynthDef(\lead, { |freq = 440, amp = 0.2|
	var env = Env.perc(0.001, 0.2).kr(doneAction:2);
	var sig = Saw.ar(freq) * env;
	sig = RLPF.ar(sig, freq * 3, 0.3);
	Out.ar(0, sig!2);
}).add;
)