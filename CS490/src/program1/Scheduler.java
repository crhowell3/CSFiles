package program1;

/**
 * This program simulates a thread scheduler
 *
 * @author  Cameron Howell
 * @version 1.0
 * @since   2020-10-01
 */
public class Scheduler {
    /**
     * Main control method
     * @param args default argument for main
     */
    public static void main(String[] args) {
        node n = new node();
        MinHeap min_heap = new MinHeap();
        min_heap.insert(n);
        min_heap.makeHeap();
    }
}
