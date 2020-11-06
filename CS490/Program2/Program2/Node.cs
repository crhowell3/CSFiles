using System;
using System.Collections.Generic;
using System.Text;

namespace Program2
{
    public class Node
    {
        private int pid;
        private int priority;
        private int time_ms;

        public Node(int id, int pri, int t)
        {
            pid = id;
            priority = pri;
            time_ms = t;
        }

        public int GetPid()
        {
            return pid;
        }

        public int GetPriority()
        {
            return priority;
        }

        public int GetTimeMs()
        {
            return time_ms;
        }
    }
}
