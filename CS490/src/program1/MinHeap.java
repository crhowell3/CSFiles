package program1;

import java.util.*;

public class MinHeap {
    private final Vector<node> heap;

    /**
     * Default constructor
     */
    MinHeap() {
        heap = new Vector<>();
    }

    /**
     * Pass a new node into the minHeap in the proper place
     *
     * @param n the node to be inserted
     */
    synchronized void insert(node n) {
        heap.add(n);

        int pos = heap.size() - 1;
        while (heap.get(pos).getPriority() < heap.get(pos / 2).getPriority()) {
            nodeSwap(pos, pos / 2);
            pos = pos / 2;
        }
    }

    /**
     * Called by a consumer thread to grab and remove the node with the lowest priority
     * from the heap
     *
     * @return the min node to be passed to the consumer thread
     */
    synchronized node consumeNode() {
        node n = heap.get(0);
        heap.set(0, heap.get(heap.size() - 1));
        heap.remove(heap.size() - 1);
        heapify(0);
        return n;
    }

    /**
     * Accessor method for getting the current size of the minHeap Vector
     *
     * @return the current size (number of nodes) of the minHeap
     */
    int getSize() {
        return heap.size();
    }

    /**
     * Method for swapping two nodes in the minHeap
     *
     * @param position_1 the position of the first node
     * @param position_2 the position of the second node
     */
    synchronized void nodeSwap(int position_1, int position_2) {
        node temp;
        temp = heap.get(position_1);
        heap.set(position_1, heap.get(position_2));
        heap.set(position_2, temp);
    }

    /**
     * Checks if the node at the given position is a leaf node
     *
     * @param position the position of the node in question
     * @return result of leaf node test
     */
    boolean isLeafNode(int position) {
        return position >= (heap.size() / 2) && position <= heap.size();
    }

    /**
     * Checks the node tree and creates a proper min heap
     *
     * @param position the position where the heapify method starts
     */
    void heapify(int position) {
        if (!isLeafNode(position)) {
            if (heap.get(position).getPriority() > heap.get(position * 2).getPriority()
                    || heap.get(position).getPriority() > heap.get(position * 2 + 1).getPriority()) {
                if (heap.get(position * 2).getPriority() < heap.get(position * 2 + 1).getPriority()) {
                    nodeSwap(position, position * 2);
                    heapify(position * 2);
                } else {
                    nodeSwap(position, position * 2 + 1);
                    heapify(position * 2 + 1);
                }
            }
        }
    }

    /**
     * Traverses the binary tree halfway and calls heapify for those elements
     */
    synchronized void makeHeap() {
        for (int i = (heap.size() / 2); i >= 1; i--) {
            heapify(i);
        }
    }
}
