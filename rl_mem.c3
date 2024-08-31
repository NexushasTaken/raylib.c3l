// vi: ts=4 sw=4
module rl @if($feature(SUPPORT_INTERNAL_MEMORY_MANAGEMENT));

/**
 * Internal memory allocator
 */
extern fn void* mem_alloc(uint size) @extern("MemAlloc");

/**
 * Internal memory reallocator
 */
extern fn void* mem_realloc(void* ptr, uint size) @extern("MemRealloc");

/**
 * Internal memory free
 */
extern fn void mem_free(void* ptr) @extern("MemFree");
