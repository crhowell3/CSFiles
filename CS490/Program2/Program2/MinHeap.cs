using System;
using System.Collections.Generic;
using System.Numerics;
using System.Text;

namespace Program2
{
    /// <summary>
    /// Class for definition of the Min Heap, as well as all methods for 
    /// working with the heap
    /// </summary>
    public class MinHeap
    {
        private readonly object sync = new object();

        private List<Node> heap;

        /// <summary>
        /// Constructor
        /// </summary>
        public MinHeap()
        {
            heap = new List<Node>();
        }

        /// <summary>
        /// Takes a Node object and places it in the min heap, then heapifies
        /// the new heap
        /// </summary>
        /// <param name="n">The Node object to be placed and sorted in the heap</param>
        public void InsertNode(Node n)
        {
            lock (sync)
            {
                heap.Add(n);

                int pos = heap.Count - 1;
                while (heap[pos].GetPriority() < heap[pos / 2].GetPriority())
                {
                    NodeSwap(pos, pos / 2);
                    pos /= 2;
                }
            }
        }

        /// <summary>
        /// The method that allows a consumer thread to "consume" a process
        /// from the heap
        /// </summary>
        /// <returns>The Node to be processed and "consumed"</returns>
        public Node ConsumeNode()
        {
            lock (sync)
            {
                Node n = heap[0];
                heap[0] = heap[heap.Count - 1];
                heap.RemoveAt(heap.Count - 1);
                Heapify(0);
                return n;
            }
        }

        /// <summary>
        /// Accessor for the size of the heap List
        /// </summary>
        /// <returns>Size of List</returns>
        public int GetSize()
        {
            return heap.Count;
        }

        /// <summary>
        /// Method for taking a Node object and placing it in the correct spot
        /// in the Min Heap to ensure that the heap always stays a Min Heap
        /// </summary>
        /// <param name="pos_1">The position of the first Node</param>
        /// <param name="pos_2">The position of the second Node</param>
        public void NodeSwap(int pos_1, int pos_2)
        {
            Node temp;
            temp = heap[pos_1];
            heap[pos_1] = heap[pos_2];
            heap[pos_2] = temp;
        }

        /// <summary>
        /// Checks if a given Node object is a leaf node in the heap
        /// </summary>
        /// <param name="position">The position of the Node object in question</param>
        /// <returns>True if node is a leaf, false if otherwise</returns>
        public bool IsLeafNode(int position)
        {
            return position >= (heap.Count / 2) && position <= heap.Count;
        }

        /// <summary>
        /// Traverses through the heap and moves Node objects around to ensure that the heap
        /// is always a Min Heap
        /// </summary>
        /// <param name="position">The position of the first Node to begin traversal</param>
        public void Heapify(int position)
        {
            if (!IsLeafNode(position))
            {
                if (heap[position].GetPriority() > heap[position * 2].GetPriority()
                    || heap[position].GetPriority() > heap[position * 2 + 1].GetPriority()) {
                    if (heap[position * 2].GetPriority() < heap[position * 2 + 1].GetPriority())
                    {
                        NodeSwap(position, position * 2);
                        Heapify(position * 2);
                    } else
                    {
                        NodeSwap(position, position * 2 + 1);
                        Heapify(position * 2 + 1);
                    }
                }
            }
        }

        /// <summary>
        /// Boss method for the Heapify worker method
        /// </summary>
        public void MakeHeap()
        {
            for (int i = (heap.Count / 2); i >= 1; i--)
            {
                Heapify(i);
            }
        }
    }
}
