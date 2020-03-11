# CS 524 Notes | 11 March 2020
## Heap Management
### Heap Management
- We will focus on heap management in this chapter and postpone detailed discussion of stack-dynamic memory until we discuss subprograms
- Design issues:
  - How to allocate storage: Single-size cells vs. variable-size cells
  - Who is responsible for deallocation when storage is no longer needed: Programmer on run-time system
- Single cell: all storage is allocated in units of the same size, preferably containing a pointer so heap storage can be maintained as a linked list
- Variable-sized cells: more complex memory management.
- Single or variable-size: always some power of 2

### Heap Management: Deallocation
- Who is responsible for deallocation when storage is no longer needed?
  - Programmer (C/C++)
  - Garbage collection (Java, Python, C#, modern languages)
- *Garbage collection* is the automated process of reclaiming memory that is no longer needed or being used

### Reference Counter
- Reference counter: maintains a counter in every cell that stores the number of pointers currently pointing at the cell
- Decrease when a pointer is re-assigned or freed, increase when another pointer is assigned
  - *Disadvantages*: extra space & execution time required, circular connections are a problem
  - *Advantage*: it is instrinsically incremental, so significant delays in the application execution are avoided
- Delete node when its reference field becomes 0, i.e., when no pointer exists for the cell

### Simple Example using Reference Count
- See slide 1-91 for the chart

### 
