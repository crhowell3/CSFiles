package program1;

import java.time.ZonedDateTime;

public class Consumer extends Thread {
    private final int num;
    private int total;
    protected boolean finished = false;
    private String tab = "";

    /**
     * Constructor method
     *
     * @param n the number of the consumer thread
     * @param t the initial total number of processes "consumed"
     */
    Consumer(int n, int t) {
        this.num = n;
        this.total = t;
        if (this.num == 1) {
            this.tab = "\t\t\t";
        } else {
            this.tab = "\t\t\t\t\t\t";
        }
    }

    /**
     * Run call for the consumer thread
     */
    public void run() {
        System.out.println(this.tab + "Consumer " + this.num + " is starting...");

        while (Scheduler.min_heap.getSize() != 0 || Scheduler.producer.getIsComplete()) {
            if (Scheduler.min_heap.getSize() == 0) {
                try {
                    System.out.println(this.tab + "Consumer " + this.num + " is idle");
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                continue;
            }
            try {
                node process_node = Scheduler.min_heap.consumeNode();
                Thread.sleep(process_node.getTime_ms());
                this.total++;
                System.out.println(this.tab + "Consumer " + this.num + " finished Process: " + process_node.getPid() +
                        " pri: " + process_node.getPriority() + " at " + ZonedDateTime.now().toInstant().toEpochMilli());
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        System.out.println(this.tab + "Consumer " + this.num + " idle");
        this.finished = true;
        while (!Scheduler.queuewatcherFinished) {
            try {
                Thread.sleep(500);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        System.out.println(this.tab + "Consumer " + this.num + " exiting - completed " + this.total + " processes...");
    }
}
