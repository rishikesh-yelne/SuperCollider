(
TempoClock.default.tempo = 120/60; // 120 BPM -> 2 beats/sec

~drumsStart1 = {
	Routine({
		loop {
			// --- BAR 1 (4 beats)
			Synth(\kick); Synth(\hihatClosed);   0.5.wait; // beat 1 -> hihat on the "and"
			Synth(\hihatClosed);                 0.5.wait; // beat 1.5
			Synth(\snare);  Synth(\hihatClosed); 0.5.wait; // beat 2
			Synth(\hihatClosed);                 0.5.wait; // beat 2.5

			// --- BAR 2 (4 beats)
			Synth(\kick);      0.25.wait;
			Synth(\kick);      0.25.wait;
			0.5.wait;
			Synth(\kick);      0.25.wait;
			Synth(\kick);      0.25.wait;
			Synth(\snare);     0.25.wait;
			Synth(\hihatOpen); 0.25.wait;
		}
	})
};

~drums = {
	Routine({
		loop {
			// --- BAR 1 (4 beats)
			Synth(\kick); Synth(\hihatClosed);   0.5.wait; // beat 1 -> hihat on the "and"
			Synth(\hihatClosed);                 0.5.wait; // beat 1.5
			Synth(\snare);  Synth(\hihatClosed); 0.5.wait; // beat 2
			Synth(\hihatClosed);                 0.5.wait; // beat 2.5

			// --- BAR 2 (4 beats)
			Synth(\kick);  Synth(\hihatClosed);  0.5.wait;
			Synth(\kick);  Synth(\hihatOpen);    0.5.wait;
			Synth(\snare);  Synth(\hihatClosed); 0.5.wait;
			Synth(\hihatOpen);                   0.5.wait;
		}
	})
};

~drumsSwitch1 = {
	Routine({
		loop {
			// --- BAR 1 (4 beats)
			Synth(\kick); Synth(\hihatOpen);   0.5.wait; // beat 1 -> hihat on the "and"
			Synth(\hihatClosed);                 0.5.wait; // beat 1.5
			Synth(\snare);  Synth(\hihatClosed); 0.5.wait; // beat 2
			Synth(\hihatClosed);                 0.5.wait; // beat 2.5

			// --- BAR 2 (4 beats)
			Synth(\snare);  0.25.wait;
			Synth(\snare);  0.25.wait;
			0.25.wait;
			Synth(\snare);  0.25.wait;
			Synth(\snare);  0.25.wait;
			0.25.wait;
			Synth(\snare);  0.25.wait;
			0.25.wait;
		}
	})
};

~drumsSwitch2 = {
	Routine({
		loop {
			// --- BAR 1 (4 beats)
			Synth(\kick); Synth(\hihatOpen);   0.5.wait; // beat 1 -> hihat on the "and"
			Synth(\hihatClosed);                 0.5.wait; // beat 1.5
			Synth(\snare);  Synth(\hihatClosed); 0.5.wait; // beat 2
			Synth(\hihatClosed);                 0.5.wait; // beat 2.5

			// --- BAR 2 (4 beats)
			Synth(\snare);  0.25.wait;
			Synth(\snare);  0.25.wait;
			Synth(\snare);  0.25.wait;
			Synth(\snare);  0.25.wait;
			Synth(\snare);  0.25.wait;
			Synth(\snare);  0.25.wait;
			0.25.wait;
			Synth(\snare);  0.25.wait;
		}
	})
};


~bass = {
	Routine({
		loop {
			Synth(\bass, [\freq, 55]);          0.5.wait;
			Synth(\bass, [\freq, 82.4]);        0.5.wait;
			Synth(\bass, [\freq, 55]);          0.5.wait;
			Synth(\bass, [\freq, 82.4]);        0.5.wait;

			Synth(\bass, [\freq, 55]);          0.5.wait;
			Synth(\bass, [\freq, 82.4]);        0.5.wait;
			Synth(\bass, [\freq, 65]);          0.5.wait;
			Synth(\bass, [\freq, 82.4]);        0.5.wait;
		}
	})
};

~keys = {
	Routine({
		loop {
			Synth(\organ, [\freq, 250]);        2.wait;
			Synth(\organ, [\freq, 230]);        2.wait;

			Synth(\organ, [\freq, 200]);        2.wait;
			Synth(\organ, [\freq, 300]);        2.wait;
		}
	})
};

// --- The "Conductor" routine ---
~song = Routine({
	var barsPerRound = 2; // each "round" = 2 bars (8 beats at 120bpm)
	var beatsPerRound = barsPerRound * 4;

	// Start with bass only
	"Starting bass...".postln;
	~bassRoutine = ~bass.value.play(TempoClock.default);
	(beatsPerRound * 2).wait; // Wait 2 rounds

	// Add drums
	"Adding drums...".postln;
	~drumsRoutine = ~drums.value.play(TempoClock.default);

	3.do { |i|
		("Iteration: " ++ (i+1)).postln;
		(beatsPerRound * 2).wait; // Wait 2 rounds

		// Fade out bass
		"Stopping bass...".postln;
		~bassRoutine.stop;

		// Keep drums running
		(beatsPerRound * 1).wait;

		if (i < 2) {
			// Fade in bass
			"Starting bass...".postln;
			~bassRoutine = ~bass.value.play(TempoClock.default);
		};
	};

	"Stopping all...".postln;
	~drumsRoutine.stop;
});

~stopAll = {
	"⏹ Stopping everything...".postln;
	if (~song.notNil) { ~song.stop; };
    if (~drumsRoutine.notNil) { ~drumsRoutine.stop; };
    if (~bassRoutine.notNil) { ~bassRoutine.stop; };
};
)