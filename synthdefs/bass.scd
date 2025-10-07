(
// Better bass (fatter, deeper)
SynthDef(\better_bass, {
	var env = Env.perc(0.01, 0.6, curve: -4);
	var freq = \freq.kr(55); // A1 default
	var osc = Saw.ar(freq) * 0.5;
	var filt = LPF.ar(osc, 400);
	var sig = filt * EnvGen.kr(env, doneAction:2);
	Out.ar(0, sig!2);
}).add;

// Basic bass
SynthDef(\bass, { |freq = 60, amp = 0.3|
    var env = Env.perc(0.01, 0.75, amp, curve: -4); // <— 1.0 is the sustain time
    var sig = Saw.ar(freq) * EnvGen.kr(env, doneAction:2);
    sig = LPF.ar(sig, 800);
    Out.ar(0, sig!2);
}).add;
)