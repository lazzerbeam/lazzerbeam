/* Fixed-size lock-free SPSC byte ring buffer.
 * Single producer, single consumer. Capacity must be a power of two.
 * Usable capacity is (size - 1). No dynamic allocation. C99. */
#ifndef RING_BUFFER_H
#define RING_BUFFER_H

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

typedef struct {
    uint8_t *buf;   /* backing storage, owned by the caller */
    size_t   size;  /* power of two */
    size_t   head;  /* write index (producer only) */
    size_t   tail;  /* read index  (consumer only) */
} ring_buffer_t;

/* Bind a ring buffer to caller-provided storage. `size` must be a power of two.
 * Returns false if size is not a power of two (or is zero). */
bool rb_init(ring_buffer_t *rb, uint8_t *storage, size_t size);

bool   rb_is_empty(const ring_buffer_t *rb);
bool   rb_is_full(const ring_buffer_t *rb);
size_t rb_count(const ring_buffer_t *rb);  /* bytes currently stored */

/* Push one byte (producer). Returns false if full. */
bool rb_put(ring_buffer_t *rb, uint8_t byte);

/* Pop one byte (consumer). Returns false if empty. */
bool rb_get(ring_buffer_t *rb, uint8_t *out);

#endif /* RING_BUFFER_H */
