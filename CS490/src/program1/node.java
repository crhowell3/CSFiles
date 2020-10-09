package program1;

/**
 * Class for instantiating a node object
 *
 * @author  Cameron Howell
 * @version 1.0
 * @since   2020-10-01
 */
public class node {
    private int pid;
    private int priority;
    private int time_ms;

    /**
     * Default constructor
     */
    node() {
        System.out.println("Node created.");
    }

    /**
     * Constructor
     * @param pid process id
     * @param priority priority level for execution order determination
     * @param time_ms time slice in milliseconds
     */
    node(int pid, int priority, int time_ms) {
        this.pid = pid;
        this.priority = priority;
        this.time_ms = time_ms;
    }

    /**
     * Accessor for pid
     * @return the current pid
     */
    int getPid() {
        return this.pid;
    }

    /**
     * Accessor for priority
     * @return the current priority
     */
    int getPriority() {
        return this.priority;
    }

    /**
     * Accessor for time_ms
     * @return the current time slice
     */
    int getTime_ms() {
        return this.time_ms;
    }
}
