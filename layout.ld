/* Magic number: multiboot 2 */
MAGIC_NUMBER = 0xe85250d6;

SECTIONS {
  /* Our program/kernel starts at address: `0x00100000` */
  . = 1M;

  /* See http://intermezzos.github.io/book/multiboot-headers.html#The%20Section */
  .boot :
  {
    header_start = .;

    /* Magic number */
    LONG(MAGIC_NUMBER)
    /* Architecture 0: Protected mode i386 */
    LONG(0)
    /* Header length */
    LONG(header_end - header_start)
    /* Checksum */
    LONG(0x100000000 - (MAGIC_NUMBER + (header_end - header_start)))
    /* Required end tag */
    /* Type */
    SHORT(0)
    /* Flags */
    SHORT(0)
    /* Size */
    LONG(8)

    header_end = .;
  }

  .text :
  {
    KEEP(*(.text.start))
    *(.text.*)
  }

  /DISCARD/ :
  {
    *(.note.gnu.*)
  }
}
