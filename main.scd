// main.scd

(
s.waitForBoot({
	var basePath = thisProcess.nowExecutingPath.dirname;

	// --- Load SynthDefs ---
	(basePath +/+ "synthdefs/drums.scd").load;
	(basePath +/+ "synthdefs/bass.scd").load;
	(basePath +/+ "synthdefs/guitar.scd").load;
	(basePath +/+ "synthdefs/sounds.scd").load;
	"✅ SynthDefs loaded.".postln;

	// --- Load Utilities ---
	// (basePath +/+ "utils/tempo.scd").load;
	// (basePath +/+ "utils/globals.scd").load;
	// "✅ Utils loaded.".postln;

	// --- Load and start your groove ---
	(basePath +/+ "patterns/basic_groove.scd").load;

	~song.play(TempoClock.default);
});
)