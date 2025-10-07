(
TempoClock.default.tempo = 120/60; // 120 BPM -> 2 beats/sec

~drums = Routine({
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
});

~bass = Routine({
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
});

~guitar = Routine({
	loop {
		Synth(\pluck, [\freq, 660]);          0.5.wait;
		Synth(\pluck, [\freq, 660]);          0.5.wait;
		Synth(\lead, [\freq, 500]);          0.5.wait;

		Synth(\pluck, [\freq, 660]);          0.5.wait;
		Synth(\pluck, [\freq, 660]);          0.5.wait;
		Synth(\lead, [\freq, 500]);          0.5.wait;

		Synth(\pluck, [\freq, 400]);          0.5.wait;
		Synth(\lead, [\freq, 500]);           0.5.wait;
	}
});

// --- The "Conductor" routine ---
~song = Routine({
	var barsPerRound = 2; // each "round" = 2 bars (8 beats at 120bpm)
	var beatsPerRound = barsPerRound * 4;

	// Start with bass only
	"Starting bass...".postln;
	~bass.play(TempoClock.default);
	(beatsPerRound * 2).wait; // Wait 2 rounds

	// Add drums
	"Adding drums...".postln;
	~drums.play(TempoClock.default);
	(beatsPerRound * 2).wait; // Wait 2 rounds

	// Add guitar
	"Adding guitar...".postln;
	~guitar.play(TempoClock.default);
	(beatsPerRound * 2).wait; // Wait 4 rounds

	// Fade out guitar and bass
	"Stopping guitar and bass...".postln;
	~guitar.stop;
	~bass.stop;

	// Keep drums running
	(beatsPerRound * 2).wait;

	"Stopping all...".postln;
	~drums.stop;
});

~stopAll = {
	"⏹ Stopping everything...".postln;
	~song.stop;
	~drums.stop;
	~bass.stop;
	~guitar.stop;
};
)