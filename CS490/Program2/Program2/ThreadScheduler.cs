using System;
using System.Diagnostics;
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

        /// <summary>
        /// Main control method
        /// </summary>
        /// <param name="args">default argument for main</param>
        static void Main(string[] args)
        {
            var consumer1 = new Thread(Consumer);
            consumer1.Start(1);
            var consumer2 = new Thread(Consumer);
            consumer2.Start(2);
            var producer = new Thread(Producer);
            producer.Start();

            while (isComplete)
            {
                Thread.Sleep(1000);
            }
            Console.WriteLine("Queuewatcher has started...");
            while (true)
            {
                if (min_heap.GetSize() == 0 && )
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
            Console.WriteLine("Main program exiting");
        }

        private static void Consumer(object num)
        {
            int total = 0;
            Console.WriteLine("Consumer {0} is starting...", num); 
            
            while (min_heap.GetSize() != 0 || !isComplete)
            {
                if (min_heap.GetSize() == 0)
                {
                    try
                    {
                        Console.WriteLine("Consumer {0} is idle", num);
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
                    Node produce_node = min_heap.ConsumeNode();
                    Thread.Sleep(produce_node.GetTimeMs());
                    total++;
                    Console.WriteLine("Consumer {0}", num);
                }
                catch (ThreadInterruptedException)
                {
                    throw;
                }
            }
            Console.WriteLine("");
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
            Console.WriteLine("Consumer {0} exiting - completed processes...", num);
        }

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
                        Thread.Sleep(1000);
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
