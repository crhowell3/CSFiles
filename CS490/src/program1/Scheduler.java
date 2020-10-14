package program1;

/**
 * This program simulates a thread scheduler
 *
 * @author Cameron Howell
 * @version 1.0
 * @since 2020-10-01
 */
public class Scheduler {
    // Create global MinHeap object
    public static MinHeap min_heap = new MinHeap();
    protected static boolean queuewatcherFinished = false;
    protected static Producer producer;

    /**
     * Main control method
     *
     * @param args default argument for main
     */
    public static void main(String[] args) throws InterruptedException {
        Consumer consumer1 = new Consumer(1, 0);
        consumer1.start();
        Consumer consumer2 = new Consumer(2, 0);
        consumer2.start();
        producer = new Producer();
        producer.start();

        while (producer.getIsComplete()) {
            Thread.sleep(1000);
        }
        System.out.println("Queuewatcher has started...");
        while (true) {
            if (min_heap.getSize() == 0 && consumer1.finished && consumer2.finished) {
                System.out.println("Queuewatcher is exiting...");
                queuewatcherFinished = true;
                break;
            }
        }

        Thread.sleep(1000);
        consumer1.join();
        consumer2.join();
        producer.join();
        System.out.println("Main program exiting");
    }
}
