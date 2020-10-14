package program1;

public class Producer extends Thread {
    protected boolean isComplete = false;

    /**
     * Default constructor
     */
    Producer() {
    }

    public boolean getIsComplete() {
        return !isComplete;
    }

    /**
     * Run method for the producer thread
     */
    public void run() {
        int id_counter = 1;
        int process_adding_iterator = 0;

        System.out.println("Starting producer...");
        while (process_adding_iterator < 3) {
            if (process_adding_iterator != 0) {
                try {
                    Thread.sleep((int) (Math.random() * (5000 - 2000) + 2000));
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
            System.out.println("Producer Adding Nodes");
            for (int i = 0; i < 25; i++) {
                node n = new node(id_counter, (int) (Math.random() * 10), (int) (Math.random() * 500));
                Scheduler.min_heap.insert(n);
                id_counter++;
            }
            Scheduler.min_heap.makeHeap();
            System.out.println("Producer thinks there are " + Scheduler.min_heap.getSize() + " nodes in the heap");
            process_adding_iterator++;
        }
        isComplete = true;
        System.out.println("Producer has completed its tasks...");
    }
}
