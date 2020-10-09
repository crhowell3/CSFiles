package program1;
import java.util.*;

public class MinHeap {
    private final ArrayList<node> heap;

    /**
     * Default constructor
     */
    MinHeap() {
        heap = new ArrayList<>();
    }

    void insert(node n) {
        heap.add(n);
    }

    void nodeSwap(int position_1, int position_2) {
        node temp;
        temp = heap.get(position_1);
        heap.set(position_1, heap.get(position_2));
        heap.set(position_2, temp);
    }

    boolean isLeafNode(int position) {
        return position >= (heap.size() / 2) && position <= heap.size();
    }

    void heapify(int position) {
        if (!isLeafNode(position)) {
            if (heap.get(position).getPriority() > heap.get(position * 2).getPriority()
                || heap.get(position).getPriority() > heap.get(position * 2 + 1).getPriority()) {
                if (heap.get(position * 2).getPriority() < heap.get(position * 2 + 1).getPriority()) {
                    nodeSwap(position, position * 2);
                    heapify(position * 2);
                }
            }
        }
    }

    void makeHeap() {
        for (int i = (heap.size() / 2); i >= 1; i--) {
            heapify(i);
        }
    }
}
