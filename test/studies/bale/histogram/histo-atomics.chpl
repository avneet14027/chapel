use CyclicDist;
use BlockDist;
use Random;
use Time;

config const printStats = true,
             printArrays = false;

config const useRandomSeed = true,
             seed = if useRandomSeed then SeedGenerator.oddCurrentTime else 314159265;

config const numTasksPerLocale = here.maxTaskPar;
const numTasks = numLocales * numTasksPerLocale;
config const N = 2000000; // number of updates per task
config const M = 1000; // number of entries in the table perf task

const numUpdates = N * numTasks;
const tableSize = M * numTasks;

// The intuitive implementation of histogram that uses global atomics

proc main() {
  const Mspace = {0..tableSize-1};
  const D = Mspace dmapped Cyclic(startIdx=Mspace.low);
  var A: [D] atomic int;

  const Nspace = {0..numUpdates-1};
  const D2 = Nspace dmapped Block(Nspace);
  var rindex: [D2] int;

  /* set up loop */
  fillRandom(rindex, seed);
  forall r in rindex {
    r = mod(r, tableSize);
  }

  var t: Timer;
  t.start();

  /* main loop */
  forall r in rindex {
    A[r].add(1);
  }

  t.stop();
  if printStats {
    writeln("Time: " + t.elapsed());

    const bytesPerTask = N * numBytes(int);
    const mbPerTask = bytesPerTask:real / (1<<20):real;
    writeln("MB/s per task: " + mbPerTask / t.elapsed());
    writeln("MB/s per node: " + mbPerTask * numTasksPerLocale / t.elapsed());
  }

  if printArrays {
    writeln(A);
  }
}
