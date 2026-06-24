# Fixed-size lock-free ring buffer (SPSC)

## What it does
A statically-allocated byte FIFO sized to a power of two. Designed for the
classic embedded pattern: an ISR (producer) pushes bytes from a UART/DMA while
the main loop (consumer) drains them. No `malloc`, no locks — correctness comes
from the single-producer/single-consumer (SPSC) discipline plus a power-of-two
capacity so head/tail wrap with a cheap mask instead of a modulo.

## How to run / build
```bash
gcc -std=c99 -Wall -Wextra -o demo ring_buffer.c demo_main.c   # if you add a demo
# or just compile the unit into your firmware:
gcc -std=c99 -c ring_buffer.c
```
There's no `demo_main.c` here — drop one in if you want a runnable demo, then
update `metadata.yaml` files list via `scripts/reindex.py`.

## Dependencies
- C99 (uses `<stdint.h>`, `<stdbool.h>`, `<stddef.h>`).
- No RTOS, no heap.

## Gotchas
- **SPSC only.** Exactly one writer thread/context and one reader. Two producers
  (or two consumers) will corrupt the indices. For multi-producer you need real
  atomics/locks.
- **Capacity must be a power of two.** The mask trick (`idx & (size-1)`) is wrong
  otherwise. `rb_init` asserts this.
- **Usable capacity is size - 1.** One slot is sacrificed to distinguish full
  from empty without a separate count.
- On multi-core / aggressive compilers you may need `volatile` or a memory
  barrier between writing the data and advancing the index. On a single-core
  Cortex-M with the writer in an ISR, the natural ordering is sufficient.

## Related
- (none yet — add a DMA double-buffer snippet and link it here)
