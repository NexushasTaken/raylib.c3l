module rl @if($feature(SUPPORT_RANDOM_GENERATION));

// Random values generation functions
//------------------------------------------------------------------------------------
tlocal bool is_random_initialized = false; // WARNING: required if raylib was configured with SUPPORT_RPRAND_GENERATOR
/**
 * Set the seed for the random number generator
 */
extern fn void set_random_seed(uint seed) @extern("SetRandomSeed");

/**
 * Get a random value between min and max (both included)
 */
fn int get_random_value(int min, int max) @inline {
	$if $defined(is_random_initialized):
		if (!is_random_initialized) {
			set_random_seed(0);
			is_random_initialized = true;
		}
	$endif
	return __get_random_value(min, max);
}

/**
 * Load random values sequence, no values repeated
 */
fn int[] load_random_sequence(uint count, int min, int max) @inline {
	$if $defined(is_random_initialized):
		if (!is_random_initialized) {
			set_random_seed(0);
			is_random_initialized = true;
		}
	$endif
	return __load_random_sequence(count, min, max)[:(usz)count];
}

/**
 * Unload random values sequence
 */
fn void unload_random_sequence(int[] sequence) @inline {
	return __unload_random_sequence(sequence.ptr);
}
