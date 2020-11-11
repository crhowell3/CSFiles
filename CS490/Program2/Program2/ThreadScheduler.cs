using System;
using System.Diagnostics;
using System.Net.NetworkInformation;
using System.Threading;

namespace Program2
{
    /// <summary>
    /// This program, like the Java implementation, simulates
    /// a thread scheduler
    /// 
    /// Author: Cameron Howell
    /// Created: 2020-11-05
    /// </summary>
    class ThreadScheduler
    {
        public static Random rnd = new Random();
        public static MinHeap min_heap = new MinHeap();
        public static bool isComplete;
        public static bool queuewatcherFinished = false;
        public static bool consumer_1_finished = false;
        public static bool consumer_2_finished = false;
        private static readonly string tab_1 = "\t";
        private static readonly string tab_2 = "\t\t";

        /// <summary>
        /// Main control method
        /// </summary>
        /// <param name="args">default argument for main</param>
        static void Main(string[] args)
        {
            var consumer1 = new Thread(() => Consumer(1, tab_1));
            consumer1.Start();
            var consumer2 = new Thread(() => Consumer(2, tab_2));
            consumer2.Start();
            var producer = new Thread(() => Producer());
            producer.Start();

            while (!isComplete)
            {
                Thread.Sleep(1000);
            }
            Console.WriteLine("Queuewatcher has started...");
            while (true)
            {
                if (min_heap.GetSize() == 0)
                {
                    Console.WriteLine("Queuewatcher is exiting...");
                    queuewatcherFinished = true;
                    break;
                }
            }

            Thread.Sleep(1000);
            consumer1.Join();
            consumer2.Join();
            producer.Join();
            Console.WriteLine("Main program exiting...");
            Console.WriteLine("Press any key to close...");
            Console.ReadKey();
        }

        /// <summary>
        /// Method for the consumer thread to run through
        /// Consumes processes in a synchronized manner to avoid deadlock or
        /// other thread conflicts
        /// </summary>
        /// <param name="num">The id number of the consumer thread</param>
        /// <param name="tab">The tab string for proper output spacing</param>
        private static void Consumer(object num, object tab)
        {
            int total = 0;
            Console.WriteLine("{0}Consumer {1} is starting...", tab, num); 
            
            while (min_heap.GetSize() != 0 || !isComplete)
            {
                if (min_heap.GetSize() == 0)
                {
                    try
                    {
                        Console.WriteLine("{0}Consumer {1} is idle", tab, num);
                        Thread.Sleep(1000);
                    }
                    catch (ThreadInterruptedException)
                    {
                        throw;
                    }
                    continue;
                }
                try
                {
                    Node process_node = min_heap.ConsumeNode();
                    Thread.Sleep(process_node.GetTimeMs());
                    total++;
                    Console.WriteLine("{0}Consumer {1} finished Process: {2} pri: {3} at {4}", tab, num, process_node.GetPid(), process_node.GetPriority(), DateTimeOffset.Now.ToUnixTimeMilliseconds());
                }
                catch (ThreadInterruptedException)
                {
                    throw;
                }
            }
            Console.WriteLine("{0}Consumer {1} is idle", tab, num);
            while (!queuewatcherFinished)
            {
                try
                {
                    Thread.Sleep(500);
                }
                catch (ThreadInterruptedException)
                {
                    throw;
                }
            }
            Console.WriteLine("{0}Consumer {1} exiting - completed {2} processes...", tab, num, total);
        }

        /// <summary>
        /// Method for the producer thread to run through
        /// Creates Node objects and places them in the Min Heap
        /// </summary>
        private static void Producer()
        {
            int id_counter = 1;
            int process_adding_iterator = 0;
            isComplete = false;

            Console.WriteLine("Starting producer...");
            while (process_adding_iterator < 3)
            {
                if (process_adding_iterator != 0)
                {
                    try
                    {
                        Thread.Sleep(2500);
                    } catch (ThreadInterruptedException)
                    {
                        throw;
                    }
                }
                Console.WriteLine("Producer Adding Nodes");
                for (int i = 0; i < 25; i++)
                {
                    Node n = new Node(id_counter, rnd.Next(1, 11), rnd.Next(1, 501));
                    min_heap.InsertNode(n);
                    id_counter++;
                }
                min_heap.MakeHeap();
                Console.WriteLine("Producer thinks there are {0} nodes in the heap", min_heap.GetSize());
                process_adding_iterator++;
            }
            isComplete = true;
            Console.WriteLine("Producer has completed its tasks...");
        }
    }
}
