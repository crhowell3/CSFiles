using System;
using System.Collections.Generic;
using System.Text;

namespace Program2
{
    /// <summary>
    /// Node class for instantiating and working with a node,
    /// or "process"
    /// </summary>
    public class Node
    {
        private readonly int pid;
        private readonly int priority;
        private readonly int time_ms;

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="id">ID number for the process</param>
        /// <param name="pri">The process priority level</param>
        /// <param name="t">Time in milliseconds</param>
        public Node(int id, int pri, int t)
        {
            pid = id;
            priority = pri;
            time_ms = t;
        }

        /// <summary>
        /// Accessor for the pid
        /// </summary>
        /// <returns>The node's process id</returns>
        public int GetPid()
        {
            return pid;
        }

        /// <summary>
        /// Accessor for the priority
        /// </summary>
        /// <returns>The node's priority level</returns>
        public int GetPriority()
        {
            return priority;
        }

        /// <summary>
        /// Accessor for the time in milliseconds
        /// </summary>
        /// <returns>The node's time in ms</returns>
        public int GetTimeMs()
        {
            return time_ms;
        }
    }
}
